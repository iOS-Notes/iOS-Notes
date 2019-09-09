//
//  Cat.m
//  ResolveInstanceMethod
//
//  Created by aikucun on 2019/9/9.
//  Copyright © 2019 MYSampleCode. All rights reserved.
//

#import "Cat.h"
#import <objc/message.h>

void run (id self, SEL _cmd, NSNumber *metre) {
    NSLog(@"Cat 跑了 %@ 米", metre);
}

void asleep (id self, SEL _cmd) {
    NSLog(@"Cat 睡觉了");
}

@implementation Cat

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if ([NSStringFromSelector(sel) isEqualToString:@"run:"]) {
        class_addMethod(self, sel, (IMP)run, "v@:@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    if ([NSStringFromSelector(sel) isEqualToString:@"asleep"]) {
        class_addMethod(object_getClass(self), sel, (IMP)asleep, "v@:");
        return YES;
    }
    return [super resolveClassMethod:sel];
}

@end
