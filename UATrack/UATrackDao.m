//
//  UATrackDao.m
//  UATrack
//
//  Created by guochaoyang on 15/10/30.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import "UATrackDao.h"
#import "UATrackUtil.h"
#import "UATrackDao.h"
#import "UATrackContext.h"
#import "UATrackSingleClass.h"
#import "UATrackConfig.h"
#import "FMDB.h"

NSString * const tableName = @"performance";

@interface UATrackDao ()
{
    InsertCompletionBlock _insertComplateBlock;
}

@property (nonatomic,strong) FMDatabaseQueue *dataBaseQueue;
@end
@implementation UATrackDao

UATRACK_SYNTHESIZE_SINGLE_CLASS(UATrackDao)

- (instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}

- (FMDatabaseQueue *)dataBaseQueue
{
    if (!_dataBaseQueue) {
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *databasePath = [documentPath stringByAppendingPathComponent:UATrackDBName];
        _dataBaseQueue = [FMDatabaseQueue databaseQueueWithPath:databasePath];
        DBLog(@"DB_Path: %@",databasePath);
        //检查表是否存在
        /*INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT
         */
        NSString *tableCreateSQL = [NSString stringWithFormat:@"CREATE TABLE if not exists '%@' ('id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'eventid' TEXT,'attributes' TEXT,'type' TEXT)", tableName];
        [_dataBaseQueue inDatabase:^(FMDatabase *db){
            BOOL result = [db executeUpdate:tableCreateSQL];
            if (!result) {
                DBLog(@"init table failed...");
            }
        }];
    }
    return _dataBaseQueue;
}

#pragma mark - DB action Method---
- (void)addItems:(UATrackModel *)model completionHandler:(InsertCompletionBlock)block
{
    _insertComplateBlock = [block copy];
    
    NSString *eventid       = model.eventID ? : @"";
    NSString *attributeStr  = [UATrackUtil stringFromDic:model.attributes] ? : @"";
    NSString *trackType     = model.trackType ? : @"";
    NSArray *argumentsArray = @[eventid,attributeStr,trackType];
    
    NSString *sql = [NSString stringWithFormat:@"insert into %@ (eventid,attributes,type) values(?,?,?)",tableName];

    [self.dataBaseQueue inDatabase:^(FMDatabase *db){
        BOOL result = NO;
        result = [db executeUpdate:sql withArgumentsInArray:argumentsArray];
        if (!result) {
            DBLog(@"failed to insert into stack...");
        }
        _insertComplateBlock(result);
    }];
}

- (void)removeItemsWithIDs:(NSArray *)dataIDs
{
    NSMutableString *dataIDStr = nil;
    
    for (int i = 0; i < dataIDs.count; i++) {
        NSString *temIDStr = [dataIDs objectAtIndex:i];
        [dataIDStr appendFormat:@",%@",temIDStr];
    }
    if ([dataIDStr length]) {
        // remove the last ,
        [dataIDStr deleteCharactersInRange:NSMakeRange([dataIDStr length]-1, 1)];
        NSString *sql = [NSString stringWithFormat:@"delete from %@ where id in(%@)",tableName,dataIDStr];
        [self.dataBaseQueue inDatabase:^(FMDatabase *db){
            BOOL result = NO;
            result = [db executeUpdate:sql];
            if (!result) {
                DBLog(@"failed delete from %@",dataIDStr);
            }
        }];
    }
   
}
- (NSMutableArray<UATrackModel *> *)executeNoneQuery
{
    __block NSMutableArray *list = nil;
    list = [NSMutableArray array];

    NSString *sql = [NSString stringWithFormat:@"select * from %@",tableName];
    [self.dataBaseQueue inDatabase:^(FMDatabase *db){
        FMResultSet *sets = [db executeQuery:sql];
        if (!sets) {
            DBLog(@"failed select from %@",tableName);
            return ;
        }
        
        while ([sets next]) {
            @autoreleasepool {
                UATrackModel *model = [[UATrackModel alloc] init];
                model.ID            = [sets stringForColumn:@"id"];
                model.eventID       = [sets stringForColumn:@"eventID"];
                model.attributes    = [UATrackUtil dictionaryFromJson:[sets stringForColumn:@"attributes"]];
                model.trackType     = [sets stringForColumn:@"type"];
                
                [list addObject:model];
            }
        }
        [sets close];
    }];
    return list;
}

- (NSMutableArray<UATrackModel *> *)selectItemsFromLocalStack
{
    return [self executeNoneQuery];
}

- (NSInteger)numberOfCountInCurrentStack
{
    NSInteger totalNum = 0;
    NSMutableArray *sets = [self executeNoneQuery];
    totalNum = [sets count];
    return totalNum;
}

@end
