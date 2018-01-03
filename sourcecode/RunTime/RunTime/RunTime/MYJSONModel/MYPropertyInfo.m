//
//  MYPropertyInfo.m
//  RunTime
//
//  Created by sunjinshuai on 2018/1/3.
//  Copyright © 2018年 MYSampleCode. All rights reserved.
//

#import "MYPropertyInfo.h"

@implementation MYPropertyInfo

- (instancetype)initWithProperty:(objc_property_t)property {
    if (!property) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        // 获取属性名
        const char *cPropertyName = property_getName(property);
        if (cPropertyName) {
            _propertyName = [NSString stringWithUTF8String:cPropertyName];
        }
        
        BOOL readOnlyProperty = NO;
        unsigned int attrCount;
        // 获取属性的属性list
        objc_property_attribute_t *attrs = property_copyAttributeList(property, &attrCount);
        for (unsigned int idx = 0; idx < attrCount; ++idx) {
            switch (attrs[idx].name[0]) {
                case 'T':   // 属性
                    if (attrs[idx].name[0] == 'T') {
                        size_t len = strlen(attrs[idx].value);
                        if (len > 3) {
                            char name[len - 2];
                            name[len - 3] = '\0';
                            memcpy(name, attrs[idx].value + 2, len - 3);
                            // 获取 属性类型名(基本类型 _typeClass = nil)
                            _typeClass = objc_getClass(name);
                        }
                    }
                    break;
                case 'R':
                    readOnlyProperty = YES;
                    break;
                case 'G':   // 自定义getter方法
                    if (attrs[idx].value) {
                        _getter = NSSelectorFromString([NSString stringWithUTF8String:attrs[idx].value]);
                    }
                    break;
                case 'S':   // 自定义setter方法
                    if (attrs[idx].value) {
                        _setter = NSSelectorFromString([NSString stringWithUTF8String:attrs[idx].value]);
                    }
                    break;
                    
                default:
                    break;
            }
        }
        
        if (attrs) {
            free(attrs);
        }
        
        if (_typeClass) {
            // 判断是否自定义对象类型
            _isCustomFondation = ![[self class] isClassFromFoundation:_typeClass];
        }
        
        if (_typeClass && _propertyName.length > 0) {
            // 如果是对象类型 生成 getter setter 方法
            if (!_getter) {
                _getter = NSSelectorFromString(_propertyName);
            }
            if (!_setter && !readOnlyProperty) {
                _setter = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:", [_propertyName substringToIndex:1].uppercaseString, [_propertyName substringFromIndex:1]]);
            }
        }
    }
    return self;
}

+ (BOOL)isClassFromFoundation:(Class)class {
    if (class == [NSString class] || class == [NSObject class]) {
        return YES;
    }
    
    static NSArray *foundations;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        foundations = @[[NSURL class],
                        [NSDate class],
                        [NSValue class],
                        [NSData class],
                        [NSError class],
                        [NSArray class],
                        [NSDictionary class],
                        [NSString class],
                        [NSAttributedString class]
                        ];
    });
    
    BOOL result = NO;
    for (Class foundationClass in foundations) {
        if ([class isSubclassOfClass:foundationClass]) {
            result = YES;
            break;
        }
    }
    return result;
}

@end
