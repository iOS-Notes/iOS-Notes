//
//  ThreadSafetyArray.h
//  ThreadSafetyArray
//
//  Created by sunjinshuai on 2017/12/29.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

/**
 实现一个线程安全的NSMutabeArray，以保证多个线程对数组操作（遍历，插入，删除）的安全;
 简单的方式，是用一个类比如叫ThreadSafetyArray，将NSMutabeArray包装起来。
 之后ThreadSafetyArray提供插入和删除的函数。而要遍历，就提供一个enumerateObjects函数，enumerateObjects函数传入一个block。
 */


#import <Foundation/Foundation.h>

@interface ThreadSafetyArray : NSObject

- (void)addObject:(NSObject *)obj;
- (void)removeObject:(NSObject *)obj;
- (void)enumerateObjects:(void (^)(NSObject *obj))block;

@end
