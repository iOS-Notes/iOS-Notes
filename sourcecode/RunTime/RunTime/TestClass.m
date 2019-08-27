//
//  TestClass.m
//  MYSampleCode
//
//  Created by sunjinshuai on 2017/11/23.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "TestClass.h"
#import "Runtime.h"
#import "ForwardTestClass.h"

@interface TestClass() {
    NSInteger _var1;
    int _var2;
    BOOL _var3;
    double _var4;
    float _var5;
}

@end

@implementation TestClass

+ (void)classMethod:(NSString *)value {
    NSLog(@"publicTestMethod1");
}

- (void)publicTestMethod1:(NSString *)value1 second:(NSString *)value2 {
    NSLog(@"publicTestMethod1");
}

- (void)publicTestMethod2 {
    NSLog(@"publicTestMethod2");
}

- (void)privateTestMethod1 {
    NSLog(@"privateTestMethod1");
}

- (void)privateTestMethod2 {
    NSLog(@"privateTestMethod2");
}

// 方法交换时使用
- (void)method1 {
    NSLog(@"我是Method1的实现");
}

// 运行时方法拦截
- (void)dynamicAddMethod:(NSString *) value {
    NSLog(@"OC替换的方法：%@", value);
}

/**
 没有找到SEL的IML实现时会执行下方的方法

 @param sel 当前对象调用并且找不到IML的SEL
 @return 找到其他的执行方法，并返回yes
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return NO;    //当返回NO时，会接着执行forwordingTargetForSelector:方法，
//    [Runtime addMethod:[self class] method:sel method:@selector(dynamicAddMethod:)];
//    return YES;
}

/**
 将当前对象不存在的SEL传给其他存在该SEL的对象

 @param aSelector 当前类中不存在的SEL
 @return 存在该SEL的对象
 */
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self;
//    return [[ForwardTestClass alloc] init];   // ForwardTestClass中相应的SEL去执行该方法
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    // 查找父类的方法签名
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if(signature == nil) {
        signature = [NSMethodSignature signatureWithObjCTypes:"@@:"];
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    ForwardTestClass *forwardClass = [[ForwardTestClass alloc] init];
    SEL sel = invocation.selector;
    if ([forwardClass respondsToSelector:sel]) {
        [invocation invokeWithTarget:forwardClass];
    } else {
        [self doesNotRecognizeSelector:sel];
    }
}

@end
