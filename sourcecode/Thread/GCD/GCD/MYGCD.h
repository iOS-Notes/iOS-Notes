//
//  MYGCD.h
//  GCD
//
//  Created by michael on 2019/2/26.
//  Copyright © 2019 MYSampleCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYGCD : NSObject

#pragma mark --------队列的三种获取方式----------
// 串行队列
- (void)createSerialQueue;

// 并发队列
- (void)createConcurrentQueue;

// 全局并发队列
- (void)getConcurrentQueue;

// 主队列
- (void)getMainqueue;

#pragma mark ---------三种队列+两种执行方式组合起来的7种多线程常用使用姿势----------

// 同步执行 and 串行队列
// 串行队列同步执行
- (void)testSerialQueueAsynExecution;

// 异步执行 and 串行队列
// 串行队列异步执行
- (void)testSerialQueueSyncExecution;

// 同步执行 and 主队列
- (void)testMainQueueAsynExecution;

// 异步执行 and 主队列
- (void)testMainQueueSyncExecution;

// 同步执行 and 并发队列
- (void)testConcurrentQueueAsynExecution;

// 异步执行 and 并发队列
- (void)testConcurrentQueueSyncExecution;

// 线程同步
- (void)testThreadSync;

// 设置队列的优先级
- (void)setQueuePriority;

#pragma mark ---------dispatch_after----------
- (void)testDispatchAfter;

#pragma mark ---------dispatch_once----------
- (void)testDispatchOnce;

#pragma mark ---------dispatch_barrier_async----------
// 栅栏函数
- (void)dispatch_barrier_async;

@end
