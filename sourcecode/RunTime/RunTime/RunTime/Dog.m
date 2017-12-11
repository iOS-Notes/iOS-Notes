//
//  Dog.m
//  RunTime
//
//  Created by sunjinshuai on 2017/12/11.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "Dog.h"
#import <objc/runtime.h>

@implementation Dog

void run (id self, SEL _cmd) {
    NSLog(@"%@ %s", self, sel_getName(_cmd));
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(run)) {
        class_addMethod(self, sel, (IMP)run, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

@end
