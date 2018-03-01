#### 并行队列+同步执行
```
- (void)syncQueueConcurrent {
    
    NSLog(@"开始执行任务");
    
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        
        NSLog(@"第一个任务当前线程为: %@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        
        NSLog(@"第二个任务当前线程为: %@", [NSThread currentThread]);
    });

    dispatch_sync(queue, ^{
        
        NSLog(@"第三个任务当前线程为: %@", [NSThread currentThread]);
    });
    
    NSLog(@"结束执行任务");
}
```

```
2016-05-05 15:03:55.567 GCD-Example[14007:7612071] 开始执行任务
2016-05-05 15:03:55.567 GCD-Example[14007:7612071] 第一个任务当前线程为: <NSThread: 0x608000067340>{number = 1, name = main}
2016-05-05 15:03:55.567 GCD-Example[14007:7612071] 第二个任务当前线程为: <NSThread: 0x608000067340>{number = 1, name = main}
2016-05-05 15:03:55.568 GCD-Example[14007:7612071] 第三个任务当前线程为: <NSThread: 0x608000067340>{number = 1, name = main}
2016-05-05 15:03:55.568 GCD-Example[14007:7612071] 结束执行任务
```

`Concurrent queues` （并发队列，也称为全局队列）
按照任务加入队列的顺序同时执行一个或多个任务，任务的启动顺序仍是按照加入队列的顺序启动的。
同时执行的任务执行在不同的线程之上由调度队列管理。
同时执行的任务数目（使用的线程数）取决于系统的条件。
系统为我们提供了四种预定义的全局并发调度队列。
此外，在 `iOS5` 之后我们可以通过指定 `dispatch_queue_concurrent` 的队列类型来创建并发调度队列。

* 从以上代码中可以看出，后面所添加的任务也必须等待前面的任务完成后才能执行，类似我们前面所讲”饭堂”排队的例子，队列完全按照”先进先出”的顺序，也即是所执行的顺序取决于：开发者将工作任务添加进队列的顺序。

* 从输出结果，我们可以看得出，现在当前的线程都为同一条，名为 `main`，而且线程数只有1。

#### 并行队列+异步执行

```
- (void)asyncQueueConcurrent {
    
    NSLog(@"开始执行任务");
    
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        
        NSLog(@"第一个任务当前线程为: %@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        
        NSLog(@"第二个任务当前线程为: %@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        
        NSLog(@"第三个任务当前线程为: %@", [NSThread currentThread]);
    });
    
    NSLog(@"结束执行任务");
}
```

从以上代码中可以看出，与串行不同的是，不需要等到第一个任务调用完，就已经在调用第二个、第三个任务，显著地提高了线程的执行速度，凸显了并行队列所执行的异步操作的并行特性；
另外，从这段代码中，不同的是串行队列需要创建一个新的队列，而并行队列中，只需要调用iOS系统中为我们提供的全局共享dispatch_get_global_queue就可以了：
```
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
```
