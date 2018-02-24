//
//  NSTimer+TimerTarget.m
//  NSTimer&CADisplayLink
//
//  Created by sunjinshuai on 2018/2/24.
//  Copyright © 2018年 NSTimer&CADisplayLink. All rights reserved.
//

#import "NSTimer+TimerTarget.h"

@implementation NSTimer (TimerTarget)

+ (NSTimer *)my_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                        repeat:(BOOL)yesOrNo
                                         block:(void(^)(NSTimer *timer))block {
    
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(startTimer:)
                                       userInfo:[block copy]
                                        repeats:yesOrNo];
}

+ (void)startTimer:(NSTimer *)timer {
    void (^block)(NSTimer *timer) = timer.userInfo;
    if (block) {
        block(timer);
    }
}

@end
