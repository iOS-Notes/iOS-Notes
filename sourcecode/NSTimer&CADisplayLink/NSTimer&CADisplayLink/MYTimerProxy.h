//
//  MYTimerProxy.h
//  NSTimer&CADisplayLink
//
//  Created by sunjinshuai on 2018/2/24.
//  Copyright © 2018年 NSTimer&CADisplayLink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYTimerProxy : NSProxy

//注意此处weak
@property (nonatomic, weak, readonly) id target;

+ (instancetype)timerProxyWithTarget:(id)target;

- (instancetype)initWithTarget:(id)target;

@end
