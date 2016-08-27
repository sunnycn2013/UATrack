//
//  UATrackNetWork.m
//  UATrack
//
//  Created by guochaoyang on 15/10/30.
//  Copyright © 2015年 guochaoyang. All rights reserved.
//

#import "UATrackNetWork.h"

@implementation UATrackNetWork

- (void)uploadData:(NSData *)postData
           withUrl:(NSString *)url
     completionHandler:(void(^)(NSURLResponse * response,NSData *data,NSError *error))block
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    [request setTimeoutInterval:30];
    
//    NSURLResponse *response = nil;
    NSURLSessionUploadTask *uploadTask = nil;
//    NSError *error;
    //    NSData *data =  [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    uploadTask =  [[NSURLSession sharedSession] uploadTaskWithRequest:request
                                                             fromData:nil
                                                    completionHandler:^(NSData * data, NSURLResponse * response, NSError * error){
                                                        if (block)
                                                        {
                                                            block(response, data, error);
                                                        }
                                                    }];
}

@end
