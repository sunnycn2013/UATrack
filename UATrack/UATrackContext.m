//
//  UATrackContext.m
//  UATrack
//
//  Created by guochaoyang on 15/10/30.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import "UATrackContext.h"
#import "UATrackUtil.h"
#import "UATrackDao.h"
#import "UATrackSingleClass.h"
#import "UATrackConfig.h"

@interface UATrackContext ()
{
    UATrackDao     *_trackDao;
}

@end
@implementation UATrackContext

UATRACK_SYNTHESIZE_SINGLE_CLASS(UATrackContext)

- (instancetype)init
{
    self = [super init];
    if (self) {
        _trackDao = [UATrackDao shareInstance];
        _appKey = @"";
        _appVersion = @"";
        _channel = @"";
    }
    return self;
}
/**
 *  检查是否允许插入本地db
 *
 *  @return bool Yes: 可以插入； NO不允许插入
 */
- (BOOL)checkInsertMAAvaiable
{
    BOOL shouldInsertToStack = YES;
    NSInteger num = [_trackDao numberOfCountInCurrentStack];
    if (num > self.maxStackCount) {
        shouldInsertToStack = NO;
    }
    return shouldInsertToStack;
}
/**
 *  检查是否需要上报数据
 *
 *  @return bool Yes 上报数据 ； No 不上报
 */
- (BOOL)checkUploadMAAvaiable
{
    BOOL shouldUpload = NO;
    
    NSInteger totalNum = [_trackDao numberOfCountInCurrentStack];
    double currentTime = [[NSDate date] timeIntervalSince1970];
    
    BOOL numAvaiable = (totalNum > _maxStackCount);
    BOOL timeAvaiable = ((currentTime - _lastUploadTime) > _minUploadTime);
    
    if (numAvaiable) {
        DBLog(@"stack out of max count..");
    }
    
    shouldUpload = (numAvaiable || timeAvaiable);
    
    return shouldUpload;
}

- (NSMutableDictionary *)commonInformations
{
    NSMutableDictionary *commonInfo = [NSMutableDictionary dictionary];
    
    NSString *timestamp     = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    NSString *openUDID      = [UATrackUtil getOpenUDID] ? : @"";
    NSString *deviceModel   = [UATrackUtil getDeviceModel] ? : @""; //@"iPhone", @"iPod touch"
    NSString *deviceName    = [UATrackUtil getDeviceName] ? : @"";  // "My iPhone"
    NSString *deviceMachine = [UATrackUtil getDModel] ? : @"";
    NSString *osVersion     = [UATrackUtil getOSVersion] ? : @"";
    NSString *screenSize    = [UATrackUtil getScreenSize] ? : @"";
    NSString *machineName   = [UATrackUtil machineName] ? : @"";    //X86-64 i386
    NSString *idfa          = [UATrackUtil getAdvertisingIdentifier] ? : @""; //IDFA
    NSString *imsi          = [UATrackUtil getSimInfo] ? : @"";     //imsi 移动、联通 、电信
    
    [commonInfo setObject:_appKey       forKey:@"appKey"];
    [commonInfo setObject:_appVersion   forKey:@"appVersion"];
    [commonInfo setObject:_channel      forKey:@"channel"];

    [commonInfo setObject:timestamp     forKey:@"timestamp"];
    [commonInfo setObject:openUDID      forKey:@"openUDID"];
    [commonInfo setObject:deviceModel   forKey:@"deviceModel"];
    [commonInfo setObject:deviceName    forKey:@"deviceName"];
    [commonInfo setObject:deviceMachine forKey:@"deviceMachine"];
    [commonInfo setObject:osVersion     forKey:@"osVersion"];
    [commonInfo setObject:screenSize    forKey:@"screenSize"];
    [commonInfo setObject:machineName   forKey:@"machineName"];
    [commonInfo setObject:idfa          forKey:@"idfa"];
    [commonInfo setObject:deviceMachine forKey:@"deviceMachine"];
    [commonInfo setObject:imsi          forKey:@"imsi"];
    
    return commonInfo;
}

@end
