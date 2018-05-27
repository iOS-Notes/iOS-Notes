//
//  NSNotificationCenter+Weak.m
//  NSNotificationTheory
//
//  Created by QMMac on 2018/5/27.
//  Copyright © 2018年 MYSampleCode. All rights reserved.
//

#import "NSNotificationCenter+Weak.h"
#import <objc/runtime.h>

@implementation NSNotificationCenter (Weak)

+ (void)load {
    Method origin = class_getInstanceMethod([self class], @selector(removeObserver:));
    Method current = class_getInstanceMethod([self class], @selector(_removeObserver:));
    method_exchangeImplementations(origin, current);
}

- (void)_removeObserver:(id)observer {
    NSLog(@"调用移除通知方法: %@", observer);
    //    [self _removeObserver:observer];
}

@end
