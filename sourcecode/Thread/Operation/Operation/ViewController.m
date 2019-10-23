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

    [self addExecutionBlock];
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
        NSLog(@"执行 task2 --- 当前所在线程：%@", [NSThread currentThread]);
    }];
    [op start];
}

/**
 * 使用子类 NSBlockOperation
 * 调用方法 addExecutionBlock:
 */
- (void)addExecutionBlock {
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"执行 task3 --- 当前所在线程：%@", [NSThread currentThread]);
    }];

    [op addExecutionBlock:^{
        NSLog(@"执行 task4 --- 当前所在线程：%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"执行 task5 --- 当前所在线程：%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"执行 task6 --- 当前所在线程：%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"执行 task7 --- 当前所在线程：%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"执行 task8 --- 当前所在线程：%@", [NSThread currentThread]);
    }];

    [op start];
}

- (void)task1 {
    NSLog(@"执行 task1 --- 当前所在线程：%@", [NSThread currentThread]);
}

@end
