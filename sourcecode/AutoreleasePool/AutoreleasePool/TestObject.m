//
//  TestObject.m
//  AutoreleasePool
//
//  Created by QMMac on 2018/5/19.
//  Copyright © 2018年 QMMac. All rights reserved.
//

#import "TestObject.h"

@implementation TestObject {
    NSInteger _number;
}

+ (instancetype) instanceWithNumber:(NSInteger)number {
    // 不加__autoreleasing 会因为arc返回值优化而不是一个autorelease对象，可以去掉试试
    __autoreleasing TestObject *object = [[TestObject alloc]init];
    object->_number = number;
    return object;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%ld", (long)self->_number];
}

- (void)dealloc {
    
    
}

@end
