//
//  UATrackSingleClass.h
//  UniqueArchitecture
//
//  Created by ccguo on 15/5/12.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#define UATRACK_SYNTHESIZE_SINGLE_CLASS(classname)\
static classname *shareInatance = nil;\
\
+ (instancetype)shareInstance{\
    @synchronized(self){\
        if (shareInatance == nil) {\
            shareInatance = [[classname alloc] init];\
        }\
    }\
    return shareInatance;\
}\
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{\
    @synchronized(self){\
        if (shareInatance == nil) {\
            shareInatance = [super allocWithZone:zone];\
        }\
    }\
    return shareInatance;\
}\
\
- (instancetype)copy{\
    return shareInatance;\
}\
