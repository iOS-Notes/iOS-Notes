//
//  NSTimer+TimerTarget.h
//  NSTimer&CADisplayLink
//
//  Created by sunjinshuai on 2018/2/24.
//  Copyright © 2018年 NSTimer&CADisplayLink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (TimerTarget)

+ (NSTimer *)my_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                        repeat:(BOOL)yesOrNo
                                         block:(void(^)(NSTimer *timer))block;

@end
