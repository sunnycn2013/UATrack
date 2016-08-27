//
//  UAHook.m
//  UATrack
//
//  Created by ccguo on 16/6/4.
//  Copyright © 2016年 guochaoyang. All rights reserved.
//

#import "UAHook.h"
#import <objc/runtime.h>

@implementation NSObject (ua_track_method_swizzing)

+ (BOOL)swizzleMethod:(SEL)origSel withMethod:(SEL)newSel
{
    if ([self instancesRespondToSelector:newSel]) {
        return NO;
    }
    Method origMethod = class_getInstanceMethod(self, origSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (class_addMethod(self, origSel, method_getImplementation(newMethod), method_getTypeEncoding(origMethod))) {
        class_replaceMethod(self, newSel, method_getImplementation(origMethod), method_getTypeEncoding(newMethod));
    }else {
        method_exchangeImplementations(origMethod, newMethod);
    }

    return YES;
}


@end
