//
//  MYGCDApply.m
//  GCD
//
//  Created by sunjinshuai on 2018/1/12.
//  Copyright © 2018年 MYSampleCode. All rights reserved.
//

#import "MYGCDApply.h"
#import "MYNetworking.h"

@implementation MYGCDApply

/**
 dispatch_apply 类似一个 for 循环，会在指定的 dispatch queue 中运行 block 任务 n 次，如果队列是并发队列，则会并发执行 block 任务，dispatch_apply 是一个同步调用，block 任务执行 n 次后才返回。dispatch_apply 会将 block 任务执行完成之后才会继续往下执行。
 
 什么情况下使用 dispatch_apply
 自定义串行队列：串行队列会完全抵消 dispatch_apply 的功能；你还不如直接使用普通的 for 循环。
 主队列（串行）：与上面一样，在串行队列上不适合使用 dispatch_apply 。还是用普通的 for 循环吧。
 并发队列：对于并发循环来说是很好选择，特别是当你需要追踪任务的进度时。
 
 创建并行运行线程而付出的开销，很可能比直接使用 for 循环要多，若你要以合适的步长迭代非常大的集合，那才应该考虑使用 dispatch_apply。
 */
- (void)testGCDApply {
    NSString *url = @"http://114.215.108.225:8081/d/json/1.0?pos=3002";
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(10, queue, ^(size_t index) {
        // 执行10次
        [MYNetworking getWithUrl:url refreshCache:NO success:^(id response) {
            NSLog(@"group%zu", index);
        } fail:^(NSError *error) {
            NSLog(@"group%zu", index);
        }];
    });
}

@end
