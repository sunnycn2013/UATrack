//
//  MAGzip.h
//  MA
//
//  Created by summer on 15/3/31.
//  Copyright (c) 2015年 360Buy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UATrackGzip : NSObject
- (NSData *)gzipInflate:(NSData*)data;
- (NSData *)gzipDeflate:(NSData*)data;
@end
