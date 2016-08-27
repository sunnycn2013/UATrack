//
//  UATrackObject+KeyValue.h
//  UATrack
//
//  Created by guochaoyang on 15/10/30.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KeyValue)

/**
 *  将模型转成字典
 *  @return 字典
 */
- (NSMutableDictionary *)keyValues;

@end
