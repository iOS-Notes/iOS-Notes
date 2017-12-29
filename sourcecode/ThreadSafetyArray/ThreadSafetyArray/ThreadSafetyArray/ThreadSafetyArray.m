//
//  ThreadSafetyArray.m
//  ThreadSafetyArray
//
//  Created by sunjinshuai on 2017/12/29.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "ThreadSafetyArray.h"

@interface ThreadSafetyArray()

@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation ThreadSafetyArray

- (instancetype)init {
    self = [super init];
    if (self) {
        _array = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addObject:(NSObject *)obj {
    @synchronized(self) {
        [_array addObject:obj];
    }
}

- (void)removeObject:(NSObject *)obj {
    @synchronized(self) {
        [_array removeObject:obj];
    }
}

- (void)enumerateObjects:(void (^)(NSObject *obj))block {
    @synchronized(self) {
        for (NSObject *obj in _array) {
            block(obj);
        }
    }
}

@end
