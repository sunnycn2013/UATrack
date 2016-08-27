//
//  UATrackManager.h
//  UATrack
//
//  Created by guochaoyang on 15/10/30.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UATrackModel.h"

@interface UATrackManager : NSObject

+ (instancetype)shareInstance;

- (void)recorderDataWithModel:(UATrackModel *)model;

@end

@interface UATrackManager (UnitTest)
- (BOOL)sendMAToServerWithList:(NSMutableArray *)list;
@end
