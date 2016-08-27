//
//  UATrackMonitor.m
//  UATrack
//
//  Created by ccguo on 16/6/4.
//  Copyright © 2016年 guochaoyang. All rights reserved.
//

#import "UATrackMonitor.h"
#import "UATrackSingleClass.h"

@interface UATrackMonitor ()
{
@private
    NSInteger            _timeoutCount;
    CFRunLoopObserverRef _observer;
    
@public
    dispatch_semaphore_t _semaphore;
    CFRunLoopActivity    _activity;
}

@end

@implementation UATrackMonitor

//SYNTHESIZE_SINGLETON_FOR_CLASS(UATrackMonitor);
UATRACK_SYNTHESIZE_SINGLE_CLASS(UATrackMonitor)

static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    UATrackMonitor *moniotr = (__bridge UATrackMonitor*)info;
    
    moniotr->_activity = activity;
    
    dispatch_semaphore_t semaphore = moniotr->_semaphore;
    dispatch_semaphore_signal(semaphore);
}

- (void)stopMonitor
{
    if (!_observer)
        return;
    
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), _observer, kCFRunLoopCommonModes);
    CFRelease(_observer);
    _observer = NULL;
}

- (void)startMonitor
{
    if (_observer)
        return;
    
    // 信号
    _semaphore = dispatch_semaphore_create(0);
    
    // 注册RunLoop状态观察
    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
    _observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                       kCFRunLoopAllActivities,
                                       YES,
                                       0,
                                       &runLoopObserverCallBack,
                                       &context);
    CFRunLoopAddObserver(CFRunLoopGetMain(), _observer, kCFRunLoopCommonModes);
    
    // 在子线程监控时长
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (YES)
        {
            long st = dispatch_semaphore_wait(_semaphore, dispatch_time(DISPATCH_TIME_NOW, 30*NSEC_PER_MSEC));
            if (st != 0)
            {
                if (!_observer)
                {
                    _timeoutCount = 0;
                    _semaphore = 0;
                    _activity = 0;
                    return;
                }
                
                if (_activity==kCFRunLoopBeforeSources || _activity==kCFRunLoopAfterWaiting)
                {
                    if (++_timeoutCount < 5)
                        continue;
                    NSLog(@"*AAAAAAAA*");
//                    NSLog(@"%@",[[NSThread mainThread] callStackSymbols]);
//                    PLCrashReporterConfig *config = [[PLCrashReporterConfig alloc] initWithSignalHandlerType:PLCrashReporterSignalHandlerTypeBSD
//                                                                                       symbolicationStrategy:PLCrashReporterSymbolicationStrategyAll];
//                    PLCrashReporter *crashReporter = [[PLCrashReporter alloc] initWithConfiguration:config];
//                    
//                    NSData *data = [crashReporter generateLiveReport];
//                    PLCrashReport *reporter = [[PLCrashReport alloc] initWithData:data error:NULL];
//                    NSString *report = [PLCrashReportTextFormatter stringValueForCrashReport:reporter
//                                                                              withTextFormat:PLCrashReportTextFormatiOS];
//                    
//                    NSLog(@"------------\n%@\n------------", report);
                }
            }
            _timeoutCount = 0;
        }
    });
}
@end
