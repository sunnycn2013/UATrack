//
//  UAHook.h
//  UATrack
//
//  Created by ccguo on 16/6/4.
//  Copyright © 2016年 guochaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ua_track_method_swizzing)

+ (BOOL)swizzleMethod:(SEL)origSel withMethod:(SEL)newSel;


//static BOOL dwu_replaceMethodWithBlock(Class c, SEL origSEL, SEL newSEL, id block) {
//    if ([c instancesRespondToSelector:newSEL]) {
//        return YES;
//    }
//    Method origMethod = class_getInstanceMethod(c, origSEL);
//    IMP impl = imp_implementationWithBlock(block);
//    if (!class_addMethod(c, newSEL, impl, method_getTypeEncoding(origMethod))) {
//        return NO;
//    }else {
//        Method newMethod = class_getInstanceMethod(c, newSEL);
//        if (class_addMethod(c, origSEL, method_getImplementation(newMethod), method_getTypeEncoding(origMethod))) {
//            class_replaceMethod(c, newSEL, method_getImplementation(origMethod), method_getTypeEncoding(newMethod));
//        }else {
//            method_exchangeImplementations(origMethod, newMethod);
//        }
//    }
//    return YES;
//}


@end
