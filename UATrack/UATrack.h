//
//  UATrack.h
//  UATrack
//
//  Created by guochaoyang on 15/10/30.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const UATrackPage;
extern NSString * const UATrackClick;
extern NSString * const UATrackPerform;
extern NSString * const UATrackTrack;

@interface UATrack : NSObject

+ (void)startWithAppkey:(NSString *)appkey;
+ (void)setAppVersion:(NSString *)appVersion;
+ (void)setAppChannel:(NSString *)appChannel;
+ (void)setLogEnable:(BOOL)value;
+ (void)setEncryptEnable:(BOOL)value;

+ (void)recorderEvent:(NSString *)eventID attributes:(NSDictionary *)attributes;
+ (void)recorderEvent:(NSString *)eventID attributes:(NSDictionary *)attributes eventType:(NSString *)type;

@end
