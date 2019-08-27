//
//  TestClass+AssociatedObject.m
//  MYSampleCode
//
//  Created by sunjinshuai on 2017/11/23.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "TestClass+AssociatedObject.h"
#import <objc/runtime.h>

@implementation TestClass (AssociatedObject)

static char kDynamicAddProperty;

- (NSString *)dynamicAddProperty {
    return objc_getAssociatedObject(self, &kDynamicAddProperty);
}

- (void)setDynamicAddProperty:(NSString *)dynamicAddProperty {
    objc_setAssociatedObject(self, &kDynamicAddProperty, dynamicAddProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
