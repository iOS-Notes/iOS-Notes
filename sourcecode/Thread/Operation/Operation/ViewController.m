//
//  ViewController.m
//  Operation
//
//  Created by aikucun on 2019/10/23.
//  Copyright © 2019 aikucun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self communication];
}

/**
 * 使用子类 NSInvocationOperation
 */
- (void)invocationOperation {
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self
                                                                     selector:@selector(task1)
                                                                       object:nil];
    [op start];
}

/**
 * 使用子类 NSBlockOperation
 */
- (void)blockOperation {
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        [self task2];
    }];
    [op start];
}

/**
 * 使用子类 NSBlockOperation
 * 调用方法 addExecutionBlock:
 */
- (void)addExecutionBlock {
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        [self task3];
    }];

    [op addExecutionBlock:^{
        [self task4];
    }];
    [op addExecutionBlock:^{
        [self task5];
    }];
    [op addExecutionBlock:^{
        [self task6];
    }];
    [op addExecutionBlock:^{
        [self task7];
    }];
    [op addExecutionBlock:^{
        [self task8];
    }];

    [op start];
}

- (void)mainQueue {
    NSOperationQueue *queue = [NSOperationQueue mainQueue];

    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self
                                                                      selector:@selector(task1)
                                                                        object:nil];

    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self
                                                                      selector:@selector(task2)
                                                                        object:nil];

    NSInvocationOperation *op3 = [[NSInvocationOperation alloc] initWithTarget:self
                                                                      selector:@selector(task3)
                                                                        object:nil];

    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        [self task4];
    }];

    [op4 addExecutionBlock:^{
        [self task5];
    }];

    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];

    [queue addOperationWithBlock:^{
        [self task6];
    }];

    [queue addOperationWithBlock:^{
        [self task7];
    }];
}

/**
 * 使用 addOperationWithBlock: 将操作加入到操作队列中
 */
- (void)addOperationWithBlockToQueue {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self
                                                                      selector:@selector(task1)
                                                                        object:nil];

    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self
                                                                      selector:@selector(task2)
                                                                        object:nil];

    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        [self task3];
    }];

    [queue addOperation:op1];
    [queue addOperation:op2];
    [op3 addExecutionBlock:^{
        [self task4];
    }];
    [queue addOperationWithBlock:^{
        [self task5];
    }];

    [queue addOperationWithBlock:^{
        [self task6];
    }];

    [queue addOperationWithBlock:^{
        [self task7];
    }];
}

/**
 * 设置 MaxConcurrentOperationCount（最大并发操作数）
 */
- (void)setMaxConcurrentOperationCount {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    queue.maxConcurrentOperationCount = 1; // 串行队列
    //    queue.maxConcurrentOperationCount = 2; // 并发队列
    //    queue.maxConcurrentOperationCount = 8; // 并发队列

    [queue addOperationWithBlock:^{
        [self task1];
    }];
    [queue addOperationWithBlock:^{
        [self task2];
    }];
    [queue addOperationWithBlock:^{
        [self task3];
    }];
    [queue addOperationWithBlock:^{
        [self task4];
    }];
}

/**
 * 操作依赖
 * 使用方法：addDependency:
 */
- (void)addDependency {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [self task1];
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [self task2];
    }];

    [op2 addDependency:op1];
    [queue addOperation:op1];
    [queue addOperation:op2];
}

/**
 * 设置优先级
 * 就绪状态下，优先级高的会优先执行，但是执行时间长短并不是一定的，所以优先级高的并不是一定会先执行完毕
 */
- (void)setQueuePriority {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [self task1];
    }];
    [op1 setQueuePriority:(NSOperationQueuePriorityVeryLow)];

    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [self task2];
    }];

    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        [self task3];
    }];

    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        [self task4];
    }];

    [op2 addDependency:op1];
    [op3 addDependency:op2];
    [op2 setQueuePriority:(NSOperationQueuePriorityVeryHigh)];

    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
}

/**
 * 线程间通信
 */
- (void)communication {
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];

    [queue addOperationWithBlock:^{
        [self task1];

        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // 进行一些 UI 刷新等操作
            NSLog(@"回到主线程刷新 UI");
        }];
    }];
}

- (void)task1 {
    NSLog(@"执行 task1 --- 当前所在线程：%@", [NSThread currentThread]);
}

- (void)task2 {
    NSLog(@"执行 task2 --- 当前所在线程：%@", [NSThread currentThread]);
}

- (void)task3 {
    NSLog(@"执行 task3 --- 当前所在线程：%@", [NSThread currentThread]);
}

- (void)task4 {
    NSLog(@"执行 task4 --- 当前所在线程：%@", [NSThread currentThread]);
}

- (void)task5 {
    NSLog(@"执行 task5 --- 当前所在线程：%@", [NSThread currentThread]);
}

- (void)task6 {
    NSLog(@"执行 task6 --- 当前所在线程：%@", [NSThread currentThread]);
}

- (void)task7 {
    NSLog(@"执行 task7 --- 当前所在线程：%@", [NSThread currentThread]);
}

- (void)task8 {
    NSLog(@"执行 task8 --- 当前所在线程：%@", [NSThread currentThread]);
}

@end
