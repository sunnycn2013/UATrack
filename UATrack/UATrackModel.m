//
//  UATrackModel.m
//  UATrack
//
//  Created by guochaoyang on 15/10/30.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import "UATrackModel.h"

@implementation UATrackModel

- (NSDictionary *)keyValues
{
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
    [mutableDic setObject:(_eventID ? : @"")    forKey:@"eventID"];
    [mutableDic setObject:(_attributes ? : @"") forKey:@"attributes"];
    [mutableDic setObject:(_trackType ? : @"")  forKey:@"trackType"];
    return mutableDic;
}
@end
