//
//  MYGCD.m
//  GCD
//
//  Created by michael on 2019/2/26.
//  Copyright © 2019 MYSampleCode. All rights reserved.
//

#import "MYGCD.h"

@implementation MYGCD

// 串行队列
- (void)createSerialQueue {
    // 串行队列的创建方法:第一个参数表示队列的唯一标识,第二个参数用来识别是串行队列还是并发队列（若为NULL时，默认是DISPATCH_QUEUE_SERIAL）
    dispatch_queue_t queue = dispatch_queue_create("com.test.testQueue", DISPATCH_QUEUE_SERIAL);
}

// 并发队列
- (void)createConcurrentQueue {
    // 并发队列的创建方法:第一个参数表示队列的唯一标识,第二个参数用来识别是串行队列还是并发队列（若为NULL时，默认是DISPATCH_QUEUE_SERIAL）
    dispatch_queue_t queue = dispatch_queue_create("com.test.testQueue", DISPATCH_QUEUE_CONCURRENT);
}

// 全局并发队列
- (void)getConcurrentQueue {
    // 系统提供了全局并发队列的直接获取方法:第一个参数表示队列优先级,我们选择默认的好了,第二个参数flags作为保留字段备用,一般都直接填0
    // 全局并发队列的获取方法
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

// 主队列
- (void)getMainqueue {
    // 主队列其实也是一种特殊的串行队列
    // 主队列的获取方法
    dispatch_queue_t mainqueue = dispatch_get_main_queue();
}

// 同步队列同步执行，
// 总结：只会在当前线程中依次执行任务，不会开启新线程，执行完一个任务，再执行下一个任务,按照1>2>3顺序执行，遵循FIFO原则，并且不会产生新的线程。
- (void)testSerialQueueAsynExecution {
    dispatch_queue_t queue = dispatch_queue_create("com.test.syncQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        NSLog(@"任务一");
        NSLog(@"currentThread:%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"任务二");
        NSLog(@"currentThread:%@", [NSThread currentThread]);
    });
    
    NSLog(@"任务三");
}

// 同步队列异步执行，
// 总结：开启了一条新线程，异步执行具备开启新线程的能力且只开启一个线程，在该线程中执行完一个任务，再执行下一个任务,按照1>2>3顺序执行，遵循FIFO原则。
- (void)testSerialQueueSyncExecution {
    dispatch_queue_t queue = dispatch_queue_create("com.test.syncQueue", DISPATCH_QUEUE_SERIAL);
    // 第一个任务
    dispatch_async(queue, ^{
        // 这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第一个任务---当前线程%@", [NSThread currentThread]);
    });
    
    // 第二个任务
    dispatch_async(queue, ^{
        // 这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第二个任务---当前线程%@", [NSThread currentThread]);
    });
    
    // 第三个任务
    dispatch_async(queue, ^{
        // 这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第三个任务---当前线程%@", [NSThread currentThread]);
    });
}

// 同步执行 and 主队列
// 总结：直接crash。这是因为发生了死锁，在gcd中，禁止在主队列(串行队列)中再以同步操作执行主队列任务。同理，在同一个同步串行队列中，再使用该队列同步执行任务也是会发生死锁。
- (void)testMainQueueAsynExecution {
//    // 获取主队列
//    dispatch_queue_t queue = dispatch_get_main_queue();
//    
//    // 第一个任务
//    dispatch_sync(queue, ^{
//        // 这里线程暂停2秒,模拟一般的任务的耗时操作
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"----执行第一个任务---当前线程%@", [NSThread currentThread]);
//    });
//    
//    // 第二个任务
//    dispatch_sync(queue, ^{
//        // 这里线程暂停2秒,模拟一般的任务的耗时操作
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"----执行第二个任务---当前线程%@", [NSThread currentThread]);
//    });
//    
//    // 第三个任务
//    dispatch_sync(queue, ^{
//        // 这里线程暂停2秒,模拟一般的任务的耗时操作
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"----执行第三个任务---当前线程%@", [NSThread currentThread]);
//    });
//    
//    NSLog(@"----end-----当前线程---%@", [NSThread currentThread]);
    
    dispatch_queue_t queue = dispatch_queue_create("com.test.testQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----11111-----当前线程%@", [NSThread currentThread]);//到这里就死锁了
        dispatch_sync(queue, ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"----22222---当前线程%@", [NSThread currentThread]);
        });
        NSLog(@"----333333-----当前线程%@", [NSThread currentThread]);
    });
    NSLog(@"----44444-----当前线程%@", [NSThread currentThread]);
}

// 异步执行 and 主队列
// 总结：所有任务都是在当前线程（主线程）中执行的，并没有开启新的线程（虽然异步执行具备开启线程的能力，但因为是主队列，所以所有任务都在主线程中）,在主线程中执行完一个任务，再执行下一个任务,按照1>2>3顺序执行，遵循FIFO原则。
- (void)testMainQueueSyncExecution {
    // 获取主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 第一个任务
    dispatch_async(queue, ^{
        // 这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第一个任务---当前线程%@", [NSThread currentThread]);
    });
    
    // 第二个任务
    dispatch_async(queue, ^{
        // 这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第二个任务---当前线程%@", [NSThread currentThread]);
    });
    
    // 第三个任务
    dispatch_async(queue, ^{
        // 这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第三个任务---当前线程%@", [NSThread currentThread]);
    });
    
    NSLog(@"----end-----当前线程---%@", [NSThread currentThread]);
}

// 同步执行 and 并发队列
// 总结：只会在当前线程中依次执行任务，不会开启新线程，执行完一个任务，再执行下一个任务，按照1>2>3顺序执行，遵循FIFO原则。
- (void)testConcurrentQueueAsynExecution {
    // 并发队列
    dispatch_queue_t queue = dispatch_queue_create("com.test.testQueue", DISPATCH_QUEUE_CONCURRENT);
    // 全局并发队列
    // dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 第一个任务
    dispatch_sync(queue, ^{
        // 这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第一个任务---当前线程%@", [NSThread currentThread]);
    });
    
    // 第二个任务
    dispatch_sync(queue, ^{
        // 这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第二个任务---当前线程%@", [NSThread currentThread]);
    });
    
    // 第三个任务
    dispatch_sync(queue, ^{
        // 这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第三个任务---当前线程%@", [NSThread currentThread]);
    });
    NSLog(@"----end-----当前线程---%@", [NSThread currentThread]);
}

// 异步执行 and 并发队列
// 总结：从log中可以发现，系统另外开启了3个线程，并且任务是同时执行的，并不是按照1>2>3顺序执行。所以异步+并发队列具备开启新线程的能力,且并发队列可开启多个线程，同时执行多个任务。
- (void)testConcurrentQueueSyncExecution {
    // dispatch_queue_t queue = dispatch_queue_create("com.test.testQueue", DISPATCH_QUEUE_CONCURRENT);
    
    // 全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 第一个任务
    dispatch_async(queue, ^{
        // 这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第一个任务---当前线程%@", [NSThread currentThread]);
    });
    
    // 第二个任务
    dispatch_async(queue, ^{
        // 这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第二个任务---当前线程%@", [NSThread currentThread]);
    });
    
    // 第三个任务
    dispatch_async(queue, ^{
        // 这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第三个任务---当前线程%@", [NSThread currentThread]);
    });
    NSLog(@"----end-----当前线程---%@", [NSThread currentThread]);
}

// 总结：通过打印的结果说明我们设置了queue1和queue2队列以targetQueue队列为参照对象，那么queue1和queue2中的任务将按照targetQueue的队列处理。
// 适用场景：一般都是把一个任务放到一个串行的queue中，如果这个任务被拆分了，被放置到多个串行的queue中，但实际还是需要这个任务同步执行，那么就会有问题，因为多个串行queue之间是并行的。这时候dispatch_set_target_queue将起到作用。
- (void)testThreadSync {
    dispatch_queue_t targetQueue = dispatch_queue_create("targetQueue", DISPATCH_QUEUE_SERIAL);//目标队列
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_SERIAL);//串行队列
    dispatch_queue_t queue2 = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);//并发队列
    // 设置参考
    dispatch_set_target_queue(queue1, targetQueue);
    dispatch_set_target_queue(queue2, targetQueue);
    
    dispatch_async(queue2, ^{
        NSLog(@"job3 in");
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"job3 out");
    });
    dispatch_async(queue2, ^{
        NSLog(@"job2 in");
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"job2 out");
    });
    dispatch_async(queue1, ^{
        NSLog(@"job1 in");
        [NSThread sleepForTimeInterval:3.f];
        NSLog(@"job1 out");
    });
}

- (void)setQueuePriority {
    NSLog(@"----start-----当前线程---%@", [NSThread currentThread]);
    
    // 串行队列的创建方法:第一个参数表示队列的唯一标识,第二个参数用来识别是串行队列还是并发队列（若为NULL时，默认是DISPATCH_QUEUE_SERIAL）
    dispatch_queue_t seriaQueue = dispatch_queue_create("com.test.testQueue", NULL);
    
    // 指定一个任务
    dispatch_async(seriaQueue, ^{
        // 这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第一个任务---当前线程%@", [NSThread currentThread]);
    });
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 指定一个任务
    dispatch_async(globalQueue, ^{
        // 这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行第二个任务---当前线程%@", [NSThread currentThread]);
    });
    
    // 第一个参数为要设置优先级的queue,第二个参数是参照物，即将第一个queue的优先级和第二个queue的优先级设置一样。
    // 第一个参数如果是系统提供的【主队列】或【全局队列】,则不知道会出现什么情况，因此最好不要设置第一参数为系统提供的队列
    dispatch_set_target_queue(seriaQueue, globalQueue);
    NSLog(@"----end-----当前线程---%@", [NSThread currentThread]);
}

// 延时执行，需要注意的是：dispatch_after函数并不是在指定时间之后才开始执行处理，而是在指定时间之后将任务追加到主队列中。严格来说，这个时间并不是绝对准确的，但想要大致延迟执行任务，dispatch_after函数是很有效的。
- (void)testDispatchAfter {
    NSLog(@"----start-----当前线程---%@", [NSThread currentThread]);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 2秒后异步追加任务代码到主队列等待执行
        NSLog(@"----执行第一个任务---当前线程%@", [NSThread currentThread]);
    });
    NSLog(@"----end-----当前线程---%@", [NSThread currentThread]);
}

// 单例
- (void)testDispatchOnce {
    NSLog(@"----start-----当前线程---%@", [NSThread currentThread]);
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"----只执行一次的任务---当前线程%@", [NSThread currentThread]);
    });
    
    NSLog(@"----end-----当前线程---%@", [NSThread currentThread]);
}

// 一个dispatch barrier 允许在一个并发队列中创建一个同步点。当在并发队列中遇到一个barrier, 他会延迟执行barrier的block,等待所有在barrier之前提交的blocks执行结束。 这时，barrier block自己开始执行。 之后， 队列继续正常的执行操作。

// 调用这个函数总是在barrier block被提交之后立即返回，不会等到block被执行。当barrier block到并发队列的最前端，他不会立即执行。相反，队列会等到所有当前正在执行的blocks结束执行。到这时，barrier才开始自己执行。所有在barrier block之后提交的blocks会等到barrier block结束之后才执行。

// 这里指定的并发队列应该是自己通过dispatch_queue_create函数创建的。如果你传的是一个串行队列或者全局并发队列，这个函数等同于dispatch_async函数。
- (void)dispatch_barrier_async {
    [self dispatch_barrier_async2];
}

- (void)dispatch_barrier_async1 {
    dispatch_queue_t queue = dispatch_queue_create("com.test.concurrent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^() {
        NSLog(@"dispatch_sync--1");
    });
    
    dispatch_async(queue, ^() {
        NSLog(@"dispatch_sync--2");
    });
    
    dispatch_barrier_async(queue, ^() {
        NSLog(@"dispatch-barrier_async");
        sleep(1);
    });
    
    // 同步, (可以改为异步, 3-4顺序就不一致了)
    dispatch_async(queue, ^() {
        NSLog(@"dispatch_sync--3");
        sleep(1);
    });
    
    dispatch_async(queue, ^() {
        NSLog(@"dispatch_sync--4");
    });
}

- (void)dispatch_barrier_async2 {
    dispatch_queue_t queue = dispatch_queue_create("com.test.serial", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^() {
        NSLog(@"dispatch_sync--1");
    });
    
    dispatch_async(queue, ^() {
        NSLog(@"dispatch_sync--2");
    });
    
    dispatch_barrier_async(queue, ^() {
        NSLog(@"dispatch-barrier_async");
        sleep(1);
    });
    
    // 同步, (可以改为异步, 3-4顺序就不一致了)
    dispatch_sync(queue, ^() {
        NSLog(@"dispatch_sync--3");
        sleep(1);
    });
    
    dispatch_sync(queue, ^() {
        NSLog(@"dispatch_sync--4");
    });
}

@end
