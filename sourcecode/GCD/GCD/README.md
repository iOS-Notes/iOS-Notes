
### 并行队列

并行队列可以同时执行多个任务，系统会维护一个线程池来保证并行队列的执行。线程池会根据当前任务量自行安排线程的数量，以确保任务尽快执行。
并发 `dispatch queue` 可以同时并行地执行多个任务，不过**并发 `queue` 仍然按先进先出(FIFO)的顺序来启动任务**。但是任务结束的顺序则依赖各自的任务所需要消耗的时间。并发 `queue` 同时执行的任务数量会根据应用和系统动态变化，各种因素包括:可用核数量、其它进程正在执行的工作数量、其它串行 `dispatch queue` 中优先任务的数量等。与串行队列的不同，虽然启动时间一致，但是这是“并发执行”，因此不需要等到上一个任务完成后才进行下一个任务。并发 `queue` 会在之前的任务完成之前就出列并开始执行下一个任务。

`Concurrent queues`：并发队列，也称为全局队列，按照任务加入队列的顺序同时执行一个或多个任务，任务的启动顺序仍是按照加入队列的顺序启动的。同时执行的任务执行在不同的线程之上由调度队列管理。同时执行的任务数目（使用的线程数）取决于系统的条件。系统为我们提供了四种预定义的全局并发调度队列。
此外，在 `iOS5` 之后我们可以通过指定 `dispatch_queue_concurrent` 的队列类型来创建并发调度队列。

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

**在并行队列中执行同步任务，不开启新线程，串行方式执行任务**
**在并行队列中执行异步任务，开启新线程, 并行方式执行任务**

### 串行队列

串行队列指同一时间每次只能执行一个任务。线程池只提供一个线程用来执行任务，所以后一个任务必须等到前一个任务执行结束才能开始。可以添加多个任务到串行队列中，执行顺序按照先进先出(FIFO)，如果需要并发地执行大量任务，应该把任务提交到全局并发queue来完成才能更好地发挥系统性能。

#### 串行队列+同步执行

```
- (void)syncQueueSerial {
    
    NSLog(@"开始执行任务");
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
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
2016-05-05 15:16:21.723 GCD-Example[14119:7628753] 开始执行任务
2016-05-05 15:16:21.723 GCD-Example[14119:7628753] 第一个任务当前线程为: <NSThread: 0x6080000794c0>{number = 1, name = main}
2016-05-05 15:16:21.724 GCD-Example[14119:7628753] 第二个任务当前线程为: <NSThread: 0x6080000794c0>{number = 1, name = main}
2016-05-05 15:16:21.724 GCD-Example[14119:7628753] 第三个任务当前线程为: <NSThread: 0x6080000794c0>{number = 1, name = main}
2016-05-05 15:16:21.724 GCD-Example[14119:7628753] 结束执行任务
```

* 从结果看，这个串行队列中执行同步任务是按照一个一个任务来执行的，都是在主队列中完成，并没有开启新线程。


#### 串行队列 + 异步执行

```
- (void)asyncQueueSerial {
    
    NSLog(@"开始执行任务");
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
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

```
2016-05-05 17:32:06.723 GCD-Example[14279:7669095] 开始执行任务
2016-05-05 17:32:06.723 GCD-Example[14279:7669095] 结束执行任务
2016-05-05 17:32:06.723 GCD-Example[14279:7669192] 第一个任务当前线程为: <NSThread: 0x60800006ee00>{number = 3, name = (null)}
2016-05-05 17:32:06.724 GCD-Example[14279:7669192] 第二个任务当前线程为: <NSThread: 0x60800006ee00>{number = 3, name = (null)}
2016-05-05 17:32:06.724 GCD-Example[14279:7669192] 第三个任务当前线程为: <NSThread: 0x60800006ee00>{number = 3, name = (null)}
```

* 从结果来看，我们可以看到是开启新线程来执行任务，但由于是串行队列，所以这里的任务还是一个接着一个来执行的。

**在串行队列中，无论是执行同步任务，不开启新线程，串行方式执行任务**
**在串行队列中，无论是执行异任务，开启1条新线程，串行方式执行任务**

### 主队列

#### 主队列+同步执行

```
- (void)syncMainQueue {
    
    NSLog(@"开始执行任务");
    dispatch_queue_t queue = dispatch_get_main_queue();
    
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
2016-05-05 17:56:24.607 GCD-Example[14437:7689741] 开始执行任务
```

当我们运行的时候发现异常了，断言在执行完开始Log之后不动了，其实这是因为我们在ViewDidload方法里执行了同步任务。
**在主线程执行同步任务，会阻塞主线程**

#### 主队列+异步执行

```
- (void)asyncMainQueue {
    
    NSLog(@"开始执行任务");
    dispatch_queue_t queue = dispatch_get_main_queue();
    
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

```
2016-05-05 18:08:16.059 GCD-Example[14537:7704614] 开始执行任务
2016-05-05 18:08:16.059 GCD-Example[14537:7704614] 结束执行任务
2016-05-05 18:08:16.064 GCD-Example[14537:7704614] 第一个任务当前线程为: <NSThread: 0x608000261700>{number = 1, name = main}
2016-05-05 18:08:16.064 GCD-Example[14537:7704614] 第二个任务当前线程为: <NSThread: 0x608000261700>{number = 1, name = main}
2016-05-05 18:08:16.065 GCD-Example[14537:7704614] 第三个任务当前线程为: <NSThread: 0x608000261700>{number = 1, name = main}
```

**在主线程执行同步任务还是异步任务，都是不开启新线程，以串行方式执行任务**

### 线程之间的通信

线程间通信常用方法

一、NSThread

```
- (void)performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg waitUntilDone:(BOOL)wait;
- (void)performSelector:(SEL)aSelector onThread:(NSThread *)thr withObject:(id)arg waitUntilDone:(BOOL)wait;
```

```
- (void)thread {
    // 1.去网络上加载数据
    NSString *imageURLString = @"http://imgsrc.baidu.com/forum/w%3D580/sign=13eeace7d058ccbf1bbcb53229d9bcd4/9245d688d43f879404f24d7bd31b0ef41bd53a51.jpg";
    [self performSelectorInBackground:@selector(loadImage:) withObject:imageURLString];
}

- (void)loadImage:(NSString *)imageURLString {
    NSLog(@"loadImage--- %@",[NSThread currentThread]);
    
    // 1.拿着imageURLString去网络上下载
    NSURL *url = [NSURL URLWithString:imageURLString];
    
    // 2.去网络上加载图片
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    
    // 3.将我们从网络上获取到的图片的二进制,转成UIImage
    UIImage *image = [UIImage imageWithData:imageData];
    
    // 4.回到主线程,并且将image传给主线程,让主线程去更新UI
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];//YES同步,NO 异步
    
    NSLog(@"---子线程over---");
}

- (void)updateUI:(UIImage *)image {
    NSLog(@"updateUI---%@",[NSThread currentThread]);
    
    self.imageView.image = image;
}

```

二、GCD

```
// 开启一个全局队列的子线程
dispatch_async(dispatch_get_global_queue(0, 0), ^{
    // 1. 开始请求数据
    // ...
    // 2. 数据请求完毕
    // 我们知道UI的更新必须在主线程操作，所以我们要从子线程回调到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
            
        //我已经回到主线程更新
    }); 
});
```

三、NSOperation

#### 第一种方法

```
- (void)operation {
 
   // 1.创建一个新的队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.添加任务(操作)
    [queue addOperationWithBlock:^{
        // 2.1在子线程中下载图片
        NSURL *url  = [NSURL URLWithString:@"http://imgcache.mysodao.com/img2/M04/8C/74/CgAPDk9dyjvS1AanAAJPpRypnFA573_700x0x1.JPG"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        // 2.2回到主线程更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.imageView.image = image;
        }];
    }];
}
```

#### 第二种方法

```
- (void)operation {
 
   // 1.创建一个新的队列
   // 一般情况下, 在做企业开发时候, 都会定义一个全局的自定义队列, 便于使用
   NSOperationQueue *queue = [[NSOperationQueue alloc] init];

   // 2.添加一个操作下载第一张图片
   __block UIImage *image1 = nil;
   NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url  = [NSURL URLWithString:@"http://imgcache.mysodao.com/img2/M04/8C/74/CgAPDk9dyjvS1AanAAJPpRypnFA573_700x0x1.JPG"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        image1 = [UIImage imageWithData:data];
    }];

   // 3.添加一个操作下载第二张图片
   __block UIImage *image2 = nil;
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url  = [NSURL URLWithString:@"http://imgcache.mysodao.com/img1/M02/EE/B5/CgAPDE-kEtqjE8CWAAg9m-Zz4qo025-22365300.JPG"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        image2 = [UIImage imageWithData:data];
   }];
   // 4.添加一个操作合成图片
   NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        UIGraphicsBeginImageContext(CGSizeMake(200, 200));
        [image1 drawInRect:CGRectMake(0, 0, 100, 200)];
        [image2 drawInRect:CGRectMake(100, 0, 100, 200)];
        UIImage *res = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        // 5.回到主线程更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.imageView.image = res;
        }];
    }];

    // 6.添加依赖

    [op3 addDependency:op1];
    [op3 addDependency:op2];

    // 7.添加操作到队列中
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
}
```
