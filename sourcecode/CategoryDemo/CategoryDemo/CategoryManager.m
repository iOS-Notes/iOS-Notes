//
//  CategoryManager.m
//  CategoryDemo
//
//  Created by sunjinshuai on 2019/2/17.
//  Copyright © 2019年 sunjinshuai. All rights reserved.
//

#import "CategoryManager.h"
#include <objc/runtime.h>

@implementation CategoryManager

+ (instancetype)shared {
    static CategoryManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[CategoryManager alloc] init];
    });
    
    return shareManager;
}

- (void)invokeOriginalMethod:(id)target selector:(SEL)selector {
    // Get the class method list
    uint count;
    Method *methodList = class_copyMethodList([target class], &count);
    
    // Print to console
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSLog(@"Category catch selector : %d %@", i, NSStringFromSelector(method_getName(method)));
    }
    
    // Call original method . Note here take the last same name method as the original method
    for (int i = count - 1 ; i >= 0; i--) {
        Method method = methodList[i];
        SEL name = method_getName(method);
        IMP implementation = method_getImplementation(method);
        if (name == selector) {
            // id (*IMP)(id, SEL, ...)
            ((void (*)(id, SEL))implementation)(target, name);
            break;
        }
    }
    free(methodList);
}

@end
