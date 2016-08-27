//
//  AppDelegate.m
//  UATrackDemo
//
//  Created by ccguo on 16/8/27.
//  Copyright © 2016年 guochaoyang. All rights reserved.
//

#import "AppDelegate.h"
#import "UATrack.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UATrack startWithAppkey:@"001"];
    [UATrack setAppChannel:@"pp"];
    [UATrack setAppVersion:@"1.0"];
    [UATrack setLogEnable:YES];
    
    return YES;
}

@end
