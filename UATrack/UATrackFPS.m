//
//  UATrackFPS.m
//  UATrack
//
//  Created by ccguo on 16/6/4.
//  Copyright © 2016年 guochaoyang. All rights reserved.
//

#import "UATrackFPS.h"
#import "UAHook.h"

@interface UATrackFpsLabel : UIView

@end

@implementation UIViewController (ua_track_fps_monitor)

+ (void)load{
    dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        [self swizzleMethod:@selector(viewDidLoad) withMethod:@selector(uatrack_viewDidLoad)];
    });
}

- (void)uatrack_viewDidLoad
{
    
}

@end