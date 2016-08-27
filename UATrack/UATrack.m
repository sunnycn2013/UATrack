//
//  UATrack.m
//  UATrack
//
//  Created by guochaoyang on 15/10/30.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//


#import "UATrack.h"
#import "UATrackManager.h"
#import "UATrackContext.h"

NSString  * const UATrackPV          = @"UATrackPV";
NSString  * const UATrackClick       = @"UATrackClick";
NSString  * const UATrackPerformance = @"UATrackPerformance";
NSString  * const UATrackTracking    = @"UATrackTracking";

@interface UATrack ()

@end

@implementation UATrack

+ (void)setAppVersion:(NSString *)appVersion
{
    [UATrackContext shareInstance].appVersion = appVersion ? : @"";
}

+ (void)setAppChannel:(NSString *)appChannel
{
    [UATrackContext shareInstance].channel = appChannel;
}

+ (void)setLogEnable:(BOOL)value
{
    [UATrackContext shareInstance].logEnable = value;
}

+ (void)setEncryptEnable:(BOOL)value
{
    [UATrackContext shareInstance].encryptEnable = value;
}

+ (void)startWithAppkey:(NSString *)appkey
{
    [UATrackContext shareInstance].appKey = appkey ? : @"";
}

+ (void)recorderEvent:(NSString *)eventID attributes:(NSDictionary *)attributes
{
    [self recorderEvent:eventID attributes:attributes eventType:nil];
}

+ (void)recorderEvent:(NSString *)eventID attributes:(NSDictionary *)attributes eventType:(NSString *)type
{
    if (!eventID) return;
    
    UATrackModel *model = [[UATrackModel alloc] init];
    
    model.eventID     = eventID ? : @"";
    model.attributes  = attributes ? : @{};
    model.trackType   = type ? : @"";
    
    [[UATrackManager shareInstance] recorderDataWithModel:model];
    
//    NSArray *array = nil;
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:array forKey:@"key1"];
}

@end
