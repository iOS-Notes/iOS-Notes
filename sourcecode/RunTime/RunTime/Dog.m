//
//  Dog.m
//  RunTime
//
//  Created by sunjinshuai on 2017/12/11.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "Dog.h"
#import "Cat.h"
#import <objc/runtime.h>

@implementation Dog

void run (id self, SEL _cmd) {
    NSLog(@"%@ %s", self, sel_getName(_cmd));
}

// resolveInstanceMethod，实例方法
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    if (sel == @selector(run)) {
//        class_addMethod(self, sel, (IMP)run, "v@:");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}

// resolveClassMethod，类方法
//+ (BOOL)resolveClassMethod:(SEL)sel {
//    Class metaClass = objc_getMetaClass(class_getName(self));
//    if (sel == @selector(run)) {
//        class_addMethod(metaClass, sel, (IMP)run , "v@:");
//        return YES;
//    }
//    return [super resolveClassMethod:sel];
//}

// forwardingTargetForSelector
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    return [[Cat alloc] init];
//}

// methodSignatureForSelector和forwardInvocation
// methodSignatureForSelector用来生成方法签名，这个签名就是给forwardInvocation中的参数NSInvocation调用的。

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSString *sel = NSStringFromSelector(aSelector);
    if ([sel isEqualToString:@"run"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL selector = [anInvocation selector];
    Cat *cat = [[Cat alloc] init];
    if ([cat respondsToSelector:selector]) {
        [anInvocation invokeWithTarget:cat];
    }
}

// 关于生成签名的类型"v@:"解释一下。
// 每一个方法会默认隐藏两个参数，self、_cmd，self代表方法调用者，_cmd代表这个方法的SEL，签名类型就是用来描述这个方法的返回值、参数的，v代表返回值为void，@表示self，:表示_cmd。

@end
