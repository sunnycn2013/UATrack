//
//  UATrackMonitor.h
//  UATrack
//
//  Created by ccguo on 16/6/4.
//  Copyright © 2016年 guochaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UATrackMonitor : NSObject

+ (instancetype)shareInstance;
- (void)startMonitor;
- (void)stopMonitor;

@end
