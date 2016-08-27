//
//  UATrackModel.h
//  UATrack
//
//  Created by guochaoyang on 15/10/30.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UATrackModel : NSObject

@property (nonatomic,strong) NSString      *ID;
@property (nonatomic,strong) NSString      *eventID;
@property (nonatomic,strong) NSDictionary  *attributes;
@property (nonatomic,strong) NSString      *trackType;

- (NSDictionary *)keyValues;
@end
