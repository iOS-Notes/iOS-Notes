//
//  Runtime.m
//  MYSampleCode
//
//  Created by sunjinshuai on 2017/11/23.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "Runtime.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation Runtime

+ (NSString *)fetchClassName:(Class)class {
    const char *className = class_getName(class);
    return [NSString stringWithUTF8String:className];
}

+ (NSArray *)fetchIvarList:(Class)class {
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(class, &count);
    NSMutableArray *mutableList = [NSMutableArray array];
    for (unsigned int i = 0; i < count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        const char *ivarName = ivar_getName(ivarList[i]);
        const char *ivarType = ivar_getTypeEncoding(ivarList[i]);
        dic[@"type"] = [NSString stringWithUTF8String:ivarType];
        dic[@"ivarName"] = [NSString stringWithUTF8String:ivarName];
        [mutableList addObject:dic];
    }
    free(ivarList);
    return mutableList.copy;
}

+ (NSArray *)fetchPropertyList:(Class)class {
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList(class, &count);
    NSMutableArray *mutableList = [NSMutableArray array];
    for (unsigned int i = 0; i < count; i++ ) {
        const char *propertyName = property_getName(propertyList[i]);
        [mutableList addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(propertyList);
    return mutableList.copy;
}

+ (NSArray *)fetchMethodList:(Class)class {
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(class, &count);
    NSMutableArray *mutableList = [NSMutableArray array];
    for (unsigned int i = 0; i < count; i++ ) {
        Method method = methodList[i];
        SEL methodName = method_getName(method);
        [mutableList addObject:NSStringFromSelector(methodName)];
    }
    free(methodList);
    return mutableList.copy;
}

+ (NSArray *)fetchProtocolList:(Class)class {
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(class, &count);
    NSMutableArray *mutableList = [NSMutableArray array];
    for (unsigned int i = 0; i < count; i++ ) {
        Protocol *protocol = protocolList[i];
        const char *protocolName = protocol_getName(protocol);
        [mutableList addObject:[NSString stringWithUTF8String:protocolName]];
    }
    return mutableList.copy;
}

+ (void)addMethod:(Class)class method:(SEL)methodSel method:(SEL)methodSelImpl {
    Method method = class_getInstanceMethod(class, methodSelImpl);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(class, methodSel, methodIMP, types);
}

+ (void)methodSwap:(Class)class firstMethod:(SEL)method1 secondMethod:(SEL)method2 {
    Method firstMethod = class_getInstanceMethod(class, method1);
    Method secondMethod = class_getInstanceMethod(class, method2);
    method_exchangeImplementations(firstMethod, secondMethod);
}

@end
