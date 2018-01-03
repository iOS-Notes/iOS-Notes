//
//  MYPropertyInfo.h
//  RunTime
//
//  Created by sunjinshuai on 2018/1/3.
//  Copyright © 2018年 MYSampleCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface MYPropertyInfo : NSObject

/// 属性
@property (nonatomic, assign, readonly) objc_property_t property;

/// 属性名
@property (nonatomic, strong, readonly) NSString *propertyName;

/// 属性class类型 如果属性是基本类型为nil
@property (nonatomic, assign, readonly) Class typeClass;

/// 是否自定义对象类型
@property (nonatomic, assign, readonly) BOOL isCustomFondation;

/// 属性 setter 方法
@property (nonatomic, assign, readonly) SEL setter;

/// 属性 getter 方法
@property (nonatomic, assign, readonly) SEL getter;

- (instancetype)initWithProperty:(objc_property_t)property;

// 是否是Foundation对象类型
+ (BOOL)isClassFromFoundation:(Class)cls;

@end
