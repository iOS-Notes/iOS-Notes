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
        self.container = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
