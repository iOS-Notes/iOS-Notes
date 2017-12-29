//
//  ThreadSafetyArray.h
//  ThreadSafetyArray
//
//  Created by sunjinshuai on 2017/12/29.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

/**
 实现一个线程安全的NSMutabeArray，以保证多个线程对数组操作（遍历，插入，删除）的安全;
 iOS-SDK只提供了非线程安全的数组。如果要多线程并发的使用一个数组对象就必须要加锁，平凡的加锁使得代码的调用非常的麻烦。
 我们需要多线程的读写锁在类的内部实现，所以需要对NSMutableArray进行封装，封装后的对象负责接受所有事件并将其转发给真正的NSMutableArray
 */


#import <Foundation/Foundation.h>
#import "ThreadSafetyObject.h"

@protocol ThreadSafetyArrayProtocol

@optional
- (id)lastObject;
- (id)objectAtIndex:(NSUInteger)index;

- (NSUInteger)count;

- (void)addObject:(id)anObject;
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)removeLastObject;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
@end

@interface ThreadSafetyArray : ThreadSafetyObject <ThreadSafetyArrayProtocol>

@end
