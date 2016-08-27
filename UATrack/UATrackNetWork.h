//
//  UATrackNetWork.h
//  UATrack
//
//  Created by guochaoyang on 15/10/30.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UATrackNetWork : NSObject

//- (void)uploadData:(NSData *)postData
//           withUrl:(NSString *)url
//     completionHandler:(void(^)(NSURLResponse * response,NSData *data,NSError *error))block;
- (void)uploadData:(NSData *)postData
           withUrl:(NSString *)url
       completionHandler:(void(^)(NSURLResponse * response,NSData *data,NSError *error))block;

@end
