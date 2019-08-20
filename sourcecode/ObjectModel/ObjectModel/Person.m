//
//  Person.m
//  ObjectModel
//
//  Created by aikucun on 2019/8/20.
//  Copyright © 2019 aikucun. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif

@implementation Person

- (void)test {
    // 实例对象
    NSLog(@"Person 的实例地址%@", self);

    // 类对象
    Class personClass = objc_getClass("Person");
    NSLog(@"Person 的类对象地址%p", personClass);

    // 元类对象
    Class personMetaClass = objc_getMetaClass("Person");
    NSLog(@"Person 的元类对象地址%p", personMetaClass);

    NSLog(@"-------------------ISA 指针-----------------------");
    NSLog(@"Person 的实例对象的 ISA 指针：%p", object_getClass(self));
    NSLog(@"Person 的类对象的 ISA 指针：%p", object_getClass(personClass));
    NSLog(@"Person 的元类对象的 ISA 指针：%p", object_getClass(personMetaClass));

    NSLog(@"-------------------superclass 指针-----------------------");
    NSLog(@"Person 的类对象的 superclass 指针：%p", class_getSuperclass([self class]));
    NSLog(@"Person 的元类对象的 superclass 指针：%p", class_getSuperclass(personMetaClass));

    // NSObject 的实例对象
    NSObject *obj = [NSObject new];
    NSLog(@"NSObject 的实例地址%p", obj);

    // NSObject 的类对象
    Class objClass = objc_getClass("NSObject");
    NSLog(@"NSObject 的类对象地址%p", objClass);

    // NSObject 的元类对象
    Class objMetaClass = objc_getMetaClass("NSObject");
    NSLog(@"NSObject 的元类对象地址%p", objMetaClass);

    NSLog(@"-------------------ISA 指针-----------------------");
    NSLog(@"NSObject 的实例对象的 ISA 指针：%p", object_getClass(self));
    NSLog(@"NSObject 的类对象的 ISA 指针：%p", object_getClass(objClass));
    NSLog(@"NSObject 的元类对象的 ISA 指针：%p", object_getClass(objMetaClass));

    NSLog(@"-------------------superclass 指针-----------------------");
    NSLog(@"NSObject 的类对象的 superclass 指针：%p", class_getSuperclass([NSObject class]));
    NSLog(@"NSObject 的元类对象的 superclass 指针：%p", class_getSuperclass(objMetaClass));
}

@end
