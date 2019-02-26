//
//  MYGCDGroup.m
//  GCD
//
//  Created by sunjinshuai on 2018/1/12.
//  Copyright © 2018年 MYSampleCode. All rights reserved.
//

#import "MYGCDGroup.h"
#import "MYNetworking.h"

@implementation MYGCDGroup

/**
 dispatch_group_wait，它会阻塞当前线程，直到组里面所有的任务都完成或者等到某个超时发生。
 按照注释的顺序，你会看到：
 
 因为你在使用的是同步的 dispatch_group_wait ，它会阻塞当前线程，所以你要用 dispatch_async 将整个方法放入后台队列以避免阻塞主线程。
 创建一个新的 Dispatch Group，它的作用就像一个用于未完成任务的计数器。
 dispatch_group_enter 手动通知 Dispatch Group 任务已经开始。你必须保证 dispatch_group_enter 和 dispatch_group_leave 成对出现，否则你可能会遇到诡异的崩溃问题。
 手动通知 Group 它的工作已经完成。再次说明，你必须要确保进入 Group 的次数和离开 Group 的次数相等。
 dispatch_group_wait 会一直等待，直到任务全部完成或者超时。如果在所有任务完成前超时了，该函数会返回一个非零值。你可以对此返回值做条件判断以确定是否超出等待周期；然而，你在这里用 DISPATCH_TIME_FOREVER 让它永远等待。它的意思，勿庸置疑就是，永－远－等－待！
 */
- (void)testGCDGroup {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ // 1
        NSString *url = @"http://114.215.108.225:8081/d/json/1.0?pos=3002";
        dispatch_group_t group = dispatch_group_create();
        for (int i = 0; i < 10; i++) {
            dispatch_group_enter(group);
            [MYNetworking getWithUrl:url refreshCache:NO success:^(id response) {
                NSLog(@"group%d",i);
                dispatch_group_leave(group);
            } fail:^(NSError *error) {
                NSLog(@"group%d",i);
                dispatch_group_leave(group);
            }];
        }
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{ // 6
            NSLog(@"testGCDGroup1 更新UI操作");
        });
    });
}

/**
 dispatch_group_notify 监听任务组内任务的执行情况，待任务组执行完毕时调用，不会阻塞当前线程
 使用 dispatch_group_enter 和 dispatch_group_leave，这种方式使用更为灵活，enter 和 leave 必须配合使用，有几次 enter 就要有几次 leave，否则 group 会一直存在。当所有 enter 的 block 都 leave 后，会执行 dispatch_group_notify 的block。
 */
- (void)testGCDGroup2 {
    NSString *url = @"http://114.215.108.225:8081/d/json/1.0?pos=3002";
    dispatch_group_t group = dispatch_group_create();
    for (int i = 0; i < 10; i++) {
        dispatch_group_enter(group);
        [MYNetworking getWithUrl:url refreshCache:NO success:^(id response) {
            NSLog(@"group%d",i);
            dispatch_group_leave(group);
        } fail:^(NSError *error) {
            NSLog(@"group%d",i);
            dispatch_group_leave(group);
        }];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"testGCDGroup2 更新UI操作");
    });
}

- (void)testGCDGroup3 {
    // 创建一个分组
    dispatch_group_t group = dispatch_group_create();
    
    // 全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"group1");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"group2");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"group3");
    });
    
    // 当上面分组任务都完成以后，会执行这个方法，我们在这里处理我们的需求
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"testGCDGroup3 更新UI操作");
    });
}

@end
