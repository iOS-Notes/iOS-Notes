//
//  Son.m
//  SelfClass与SuperClass的区别
//
//  Created by aikucun on 2019/8/27.
//  Copyright © 2019 MYSampleCode. All rights reserved.
//

#import "Son.h"

@implementation Son

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"%@", NSStringFromClass([self class]));
        NSLog(@"%@", NSStringFromClass([super class]));
    }
    return self;
}

@end
