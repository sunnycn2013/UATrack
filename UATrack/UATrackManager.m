//
//  UATrackManager.m
//  UATrack
//
//  Created by guochaoyang on 15/10/30.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import "UATrackManager.h"
#import "UATrackUtil.h"
#import "UATrackDao.h"
#import "UATrackContext.h"
#import "UATrackNetWork.h"
#import "UATrackSingleClass.h"
#import "UATrackConfig.h"

@interface UATrackManager ()
{
    UATrackContext *_context;
    UATrackDao     *_trackDao;
    UATrackNetWork *_netWork;
}

@property(nonatomic,strong) NSOperationQueue *operationQueue;
@property(nonatomic,strong) NSOperationQueue *netWorkQueue;
@end

@implementation UATrackManager

UATRACK_SYNTHESIZE_SINGLE_CLASS(UATrackManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        _context = [UATrackContext shareInstance];
        _context.maxStackCount  = UATrackContextMaxStackCount;
        _context.minUploadTime  = UATrackContextMinUploadTime;
        _context.isDebugModel   = UATrackContextIsDebugModel;
        _context.lastUploadTime = [[NSDate date] timeIntervalSince1970];
        
        _trackDao = [UATrackDao shareInstance];
        _netWork = [[UATrackNetWork alloc] init];
    }
    return self;
}

- (NSOperationQueue *)operationQueue
{
    if (!_operationQueue) {
        _operationQueue = [[NSOperationQueue alloc] init];
        [_operationQueue setMaxConcurrentOperationCount:1];
        [_operationQueue setName:@"com.uatrack.operationQueue"];
    }
    return _operationQueue;
}

- (NSOperationQueue *)netWorkQueue
{
    if (!_netWorkQueue) {
        _netWorkQueue = [[NSOperationQueue alloc] init];
        [_netWorkQueue setMaxConcurrentOperationCount:1];
        [_netWorkQueue setName:@"com.uatrack.netWorkQueue"];
    }
    return _netWorkQueue;
}

- (void)recorderDataWithModel:(UATrackModel *)model
{
    __weak typeof (self) weakself = self;
    
    [self.operationQueue addOperationWithBlock:^{
        //如果当前数据没有超过出最大num,继续insert，否则进行一次上报
        if([_context checkInsertMAAvaiable])
        {
            [_trackDao addItems:model completionHandler:^(BOOL state){
                //判断插入成功，
                if (state){
                     DBLog(@"insert data success : %@",model.keyValues);
                    [weakself checkAvaiableAndUploadPerformance];
                }else{
                    DBLog(@"insert data failed ...");
                }
                
            }];
        }else{
            [weakself checkAvaiableAndUploadPerformance];
        }
    }];
}

#pragma mark - private method

- (void)checkAvaiableAndUploadPerformance
{
    __weak typeof (self) weakself = self;
    [self.operationQueue addOperationWithBlock:^{
        
        if ([_context checkUploadMAAvaiable])
        {
            NSMutableArray *list = [_trackDao selectItemsFromLocalStack];
            
            [weakself.netWorkQueue addOperationWithBlock:^{
                DBLog(@"upload MA start...");
                [weakself sendMAToServerWithList:list];
            }];
            
        }
    }];
}
- (BOOL)sendMAToServerWithList:(NSMutableArray *)list
{
    BOOL success = NO;
    __weak typeof (self) weakself = self;

    //拼装数据，转码加密
    NSMutableDictionary *totalList = [_context commonInformations];
    NSMutableArray *dataArray = [NSMutableArray array];
    NSMutableArray *dataIDsArray = [NSMutableArray array];

    for (int i = 0; i < list.count; i++) {
        UATrackModel *obj = list[i];
        [dataArray addObject:obj.keyValues];
        [dataIDsArray addObject:[NSString stringWithFormat:@"%@",obj.ID]];
    }
    
    [totalList setObject:dataArray forKey:@"data"];
    
    //转json字符串
    NSString *jsonString = [UATrackUtil stringFromDic:totalList];
    
    NSData *postBody = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    //上报
    [_netWork uploadData:postBody withUrl:@"www.baidu.com" completionHandler:^(NSURLResponse * response,NSData *data,NSError *error){
        //case timeout
        if([error code] == NSURLErrorTimedOut)
        {
            [weakself.operationQueue addOperationWithBlock:^{
                //删除db
                [_trackDao removeItemsWithIDs:dataIDsArray];
            }];
            DBLog(@"upload MA start...");
        }
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)response;
            if ([httpRes statusCode] != 200) {
                //upload 失败
                DBLog(@"upload MA TimedOut...");
            }
        }
        //succes
        [weakself.operationQueue addOperationWithBlock:^{
            // list ids delete db
            [_trackDao removeItemsWithIDs:dataIDsArray];
        }];
        //发送成功，纪录成功时间
        _context.lastUploadTime = [[NSDate date] timeIntervalSince1970];
        DBLog(@"upload MA success : %@",jsonString);
    }];
    
    return success;
}
@end
