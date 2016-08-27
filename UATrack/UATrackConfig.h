//
//  UATrackConfig.h
//  UATrack
//
//  Created by guochaoyang on 15/10/30.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#ifndef UATrackConfig_h
#define UATrackConfig_h

#define UATrackDBName                   @"UATrackDB.sqlite"

#define UATrackContextMaxStackCount     1000
#define UATrackContextMinUploadTime     60*5
#define UATrackContextIsDebugModel      NO

#define UATrackServerURL     @"www.baidu.com"


#define DBLog(format, ...)  if([UATrackContext shareInstance].logEnable) {NSLog(format,##__VA_ARGS__);}

#endif /* UATrackConfig_h */
