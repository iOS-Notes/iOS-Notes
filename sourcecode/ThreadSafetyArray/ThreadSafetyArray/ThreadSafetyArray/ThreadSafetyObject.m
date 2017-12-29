//
//  ThreadSafetyObject.m
//  ThreadSafetyArray
//
//  Created by sunjinshuai on 2017/12/29.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "ThreadSafetyObject.h"

@interface ThreadSafetyObject() {
    dispatch_queue_t _dispatchQueue;
    NSObject *_container;
}

@end

@implementation ThreadSafetyObject

- (instancetype)init {
    self = [super init];
    if (self) {
        _dispatchQueue = dispatch_queue_create("com.threadsafety.array", NULL);
    }
    return self;
}

- (void)dealloc {
    _dispatchQueue = nil;
    _container = nil;
}

#pragma mark - method over writing
- (NSString *)description {
    return _container.description;
}

#pragma mark - public method
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [[_container class] instanceMethodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSMethodSignature *sig = [anInvocation valueForKey:@"_signature"];
    const char *returnType = sig.methodReturnType;
    NSLog(@"%@ = > %@",anInvocation.target, NSStringFromSelector(anInvocation.selector));
    NSLog(@"%s",returnType);
    if (!strcmp(returnType, "v")) {
        /** the setter method just use async dispatch
         remove the barrier to make it faster when u r sure that invacations will not affect each other
         */
        dispatch_barrier_async(_dispatchQueue, ^{
            [anInvocation invokeWithTarget:_container];
        });
    } else {
        /** all getter method need sync dispatch
         barrier make sure the result is correct
         getter method need barrier in most ways unless u dont except this */
        dispatch_barrier_sync(_dispatchQueue, ^{
            [anInvocation invokeWithTarget:_container];
        });
    }
}

@end
