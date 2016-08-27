//
//  UATrackDao.h
//  UATrack
//
//  Created by guochaoyang on 15/10/30.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UATrackModel.h"

typedef  void (^InsertCompletionBlock)(BOOL state);

@interface UATrackDao : NSObject

+ (instancetype)shareInstance;

- (void)addItems:(UATrackModel *)model completionHandler:(InsertCompletionBlock)block;
- (void)removeItemsWithIDs:(NSArray<NSString *> *)dataIDs;
- (NSMutableArray<UATrackModel *> *)selectItemsFromLocalStack;
- (NSInteger)numberOfCountInCurrentStack;

@end
