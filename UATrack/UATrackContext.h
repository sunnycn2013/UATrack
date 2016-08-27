//
//  UATrackContext.h
//  UATrack
//
//  Created by guochaoyang on 15/10/30.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UATrackContext : NSObject

#pragma mark - SDK params
@property (nonatomic,strong) NSString   *appVersion;
@property (nonatomic,strong) NSString   *appKey;
@property (nonatomic,strong) NSString   *channel;
@property (nonatomic,assign) BOOL       encryptEnable;
@property (nonatomic,assign) BOOL       logEnable;

#pragma mark - UATrack 配置参数
@property (nonatomic,assign) NSInteger  maxStackCount;
@property (nonatomic,assign) NSInteger  minUploadCount;
@property (nonatomic,assign) double     minUploadTime;
@property (nonatomic,assign) BOOL       isDebugModel;

#pragma mark - UATrack 持有参数
@property (nonatomic,assign) float      lastUploadTime;

+ (instancetype)shareInstance;
- (BOOL)checkInsertMAXAvaiable;
- (BOOL)checkUploadMAXAvaiable;
- (NSMutableDictionary *)commonInformations;

@end
