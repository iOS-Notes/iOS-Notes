### NSNotification解决的问题

* 可以实现跨层的传递，例如A页面跳转到B页面，B页面再跳转到C页面，这时候如果我们通过委托回调的模式让A知道C的一些修改，那么实现起来就会很麻烦。
* 可以实现一对多，`NSNotification` 的实际是一种观察者模式。

### NSNotificationCenter

`NSNotificationCenter` 就相当于一个广播站，使用 `[NSNotificationCenter defaultCenter]` 来获取，`NSNotificationCenter` 实际上是 `iOS` 程序内部之间的一种消息广播机制，主要为了解决应用程序内部不同对象之间解耦而设计。
`NSNotificationCenter` 是整个通知机制的关键所在，它管理着监听者的注册和注销，通知的发送和接收。`NSNotificationCenter` 维护着一个通知的分发表，把所有通知发送者发送的通知，转发给对应的监听者们。每一个 `iOS` 程序都有一个唯一的通知中心，不必自己去创建一个，它是一个单例，通过 `[NSNotificationCenter defaultCenter]` 方法获取。
`NSNotificationCenter` 是基于观察者模式设计的，不能跨应用程序进程通信，当 `NSNotificationCenter` 接收到消息之后会根据内部的消息转发表，将消息发送给订阅者；它可以向应用任何地方发送和接收通知。
在 `NSNotificationCenter` 注册观察者，发送者使用通知中心广播时，以 `NSNotification` 的 `name` 和 `object` 来确定需要发送给哪个观察者。为保证观察者能接收到通知，所以应先向通知中心注册观察者，接着再发送通知这样才能在通知中心调度表中查找到相应观察者进行通知。

### NSNotification

`NSNotification` 是 `NSNotificationCenter` 接收到消息之后根据内部的消息转发表，将消息发送给订阅者封装的对象；

```
@interface NSNotification : NSObject <NSCopying, NSCoding>

//这个成员变量是这个消息对象的唯一标识，用于辨别消息对象
@property (readonly, copy) NSString *name;
// 这个成员变量定义一个对象，可以理解为针对某一个对象的消息，代表通知的发送者
@property (nullable, readonly, retain) id object;
//这个成员变量是一个字典，可以用其来进行传值
@property (nullable, readonly, copy) NSDictionary *userInfo;
// 初始化方法
- (instancetype)initWithName:(NSString *)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo NS_AVAILABLE(10_6, 4_0) NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@end
```

由于 `NSNotification` 属性都是只读的，如果要创建通知则要用下面 `NSNotification(NSNotificationCreation)` 分类相应的方法进行初始化；

```
@interface NSNotification (NSNotificationCreation)
+ (instancetype)notificationWithName:(NSString *)aName object:(nullable id)anObject;
+ (instancetype)notificationWithName:(NSString *)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;
- (instancetype)init /*NS_UNAVAILABLE*/;    /* do not invoke; not a valid initializer for this class */
@end
```

注意：
如果 `NSNotification` 对象中的 `notificationName` 为 `nil`，则会接收所有的通知。通知中心是以 `NSNotification` 的 `name` 和 `object` 来确定需要发送给哪个观察者。监听同一条通知的多个观察者，在通知到达时，它们执行回调的顺序是不确定的，所以我们不能去假设操作的执行会按照添加观察者的顺序来执行。

通知中心默认是以同步的方式发送通知的，也就是说，当一个对象发送了一个通知，**只有当该通知的所有接受者都接受到了通知中心分发的通知消息并且处理完成后，发送通知的对象才能继续执行接下来的方法。**

### Notification与多线程

在多线程中，无论在哪个线程注册了观察者，`Notification` 接收和处理都是在发送 `Notification` 的线程中的。所以，当我们需要在接收到 `Notification` 后作出更新 `UI` 操作的话，就需要考虑线程的问题了，如果在子线程中发送 `Notification`，想要在接收到 `Notification` 后更新UI的话就要切换回到主线程。

```
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *NOTIFICATION_NAME = @"NOTIFICATION_NAME";
    
    NSLog(@"Current thread = %@", [NSThread currentThread]);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:NOTIFICATION_NAME object:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         NSLog(@"Post notification，Current thread = %@", [NSThread currentThread]);
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NAME object:nil userInfo:nil];
    });
}
 
- (void)handleNotification:(NSNotification *)notification {
    NSLog(@"Receive notification，Current thread = %@", [NSThread currentThread]);
}
```

运行结果：

```
2017-03-11 17:56:33.898 NotificationTest[23457:1615587] Current thread = <NSThread: 0x608000078080>{number = 1, name = main}
2017-03-11 17:56:33.899 NotificationTest[23457:1615738] Post notification，Current thread = <NSThread: 0x60000026c500>{number = 3, name = (null)}
2017-03-11 17:56:33.899 NotificationTest[23457:1615738] Receive notification，Current thread = <NSThread: 0x60000026c500>{number = 3, name = (null)}
```

上面我们在主线程注册观察者，在子线程发送 `Notification`，最后 `Notification` 的接收和处理也是在子线程。

##### 重定向Notification到指定线程

当然，想要在子线程发送 `Notification`、接收到 `Notification` 后在主线程中做后续操作，可以用一个很笨的方法，在 `handleNotification` 里面强制切换线程：

```
- (void)handleNotification:(NSNotification *)notification {
   NSLog(@"Receive notification，Current thread = %@", [NSThread currentThread]);
   dispatch_async(dispatch_get_main_queue(), ^{
      NSLog(@"Current thread = %@", [NSThread currentThread]);
   });
}
```

在简单情况下可以使用这种方法，但是当我们发送了多个 `Notification` 并且有多个观察者的时候，难道我们要在每个地方都手动切换线程？所以，这种方法并不是一个有效的方法。

最好的方法是在 `Notification` 所在的默认线程中捕获发送的通知，然后将其重定向到指定的线程中。关于 `Notification` 的重定向官方文档给出了一个方法：

>一种重定向的实现思路是自定义一个通知队列(不是 `NSNotificationQueue` 对象)，让这个队列去维护那些我们需要重定向的 `Notification`。我们仍然是像之前一样去注册一个通知的观察者，当 `Notification` 到达时，先看看 `post` 这个 `Notification` 的线程是不是我们所期望的线程，如果不是，就将这个 `Notification` 放到我们的队列中，然后发送一个信号`signal`到期望的线程中，来告诉这个线程需要处理一个 `Notification`。指定的线程收到这个信号`signal`后，将 `Notification` 从队列中移除，并进行后续处理。

```
//  ViewController.m
//  NotificationTest
//
//  Created by sunjinshuai on 2017/3/11.
//  Copyright © 2017年 sunjinshuai. All rights reserved.
//
 
#import "ViewController.h"
 
@interface ViewController ()<NSMachPortDelegate>
 
@property (nonatomic) NSMutableArray    *notifications;         // 通知队列
@property (nonatomic) NSThread          *notificationThread;    // 想要处理通知的线程（目标线程）
@property (nonatomic) NSLock            *notificationLock;      // 用于对通知队列加锁的锁对象，避免线程冲突
@property (nonatomic) NSMachPort        *notificationPort;      // 用于向目标线程发送信号的通信端口
 
@end
 
@implementation ViewController
 
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *NOTIFICATION_NAME = @"NOTIFICATION_NAME";
 
    NSLog(@"Current thread = %@", [NSThread currentThread]);
    
    [self setUpThreadingSupport];
    
    // 注册观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processNotification:) name:NOTIFICATION_NAME object:nil];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 发送Notification
        NSLog(@"Post notification，Current thread = %@", [NSThread currentThread]);
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NAME object:nil userInfo:nil];
        
    });
}
 
/*
    在注册任何通知之前，需要先初始化属性。下面方法初始化了队列和锁定对象，保留对当前线程对象的引用，并创建一个Mach通信端口，将其添加到当前线程的运行循环中。
    此方法运行后，发送到notificationPort的任何消息都会在首次运行此方法的线程的run loop中接收。如果接收线程的run loop在Mach消息到达时没有运行，则内核保持该消息，直到下一次进入run loop。接收线程的run loop将传入消息发送到端口delegate的handleMachMessage：方法。
 */
- (void)setUpThreadingSupport {
    if (self.notifications) {
        return;
    }
    self.notifications      = [[NSMutableArray alloc] init];
    self.notificationLock   = [[NSLock alloc] init];
    self.notificationThread = [NSThread currentThread];
    
    self.notificationPort = [[NSMachPort alloc] init];
    [self.notificationPort setDelegate:self];
    [[NSRunLoop currentRunLoop] addPort:self.notificationPort
                                forMode:(__bridge NSString*)kCFRunLoopCommonModes];
}
 
 
/**
 端口的代理方法
 */
- (void)handleMachMessage:(void *)msg {
    
    [self.notificationLock lock];
    
    while ([self.notifications count]) {
        NSNotification *notification = [self.notifications objectAtIndex:0];
        [self.notifications removeObjectAtIndex:0];
        [self.notificationLock unlock];
        [self processNotification:notification];
        [self.notificationLock lock];
    };
    
    [self.notificationLock unlock];
}
 
- (void)processNotification:(NSNotification *)notification {
    
    //判断是不是目标线程，不是则转发到目标线程
    if ([NSThread currentThread] != _notificationThread) {
        // 将Notification转发到目标线程
        [self.notificationLock lock];
        [self.notifications addObject:notification];
        [self.notificationLock unlock];
        [self.notificationPort sendBeforeDate:[NSDate date]
                                   components:nil
                                         from:nil
                                     reserved:0];
    } else {
        // 在此处理通知
        NSLog(@"Receive notification，Current thread = %@", [NSThread currentThread]);
        NSLog(@"Process notification");
    }
}
 
@end
```

打印结果：

```
2017-03-11 18:28:55.788 NotificationTest[24080:1665269] Current thread = <NSThread: 0x60800006d4c0>{number = 1, name = main}
2017-03-11 18:28:55.789 NotificationTest[24080:1665396] Post notification，Current thread = <NSThread: 0x60800026bc40>{number = 4, name = (null)}
2017-03-11 18:28:55.795 NotificationTest[24080:1665269] Receive notification，Current thread = <NSThread: 0x60800006d4c0>{number = 1, name = main}
2017-03-11 18:28:55.795 NotificationTest[24080:1665269] Process notification
```

在发送通知的子线程处理通知的事件时，将 `NSNotification` 暂存，然后通过 `MachPort` 往相应线程的 `RunLoop` 中发送事件。相应的线程收到该事件后，取出在队列中暂存的 `NSNotification` , 然后在当前线程中调用处理通知的方法。
可以看到，运行结果结果我们想要的：在子线程中发送 `Notification`，在主线程中接收与处理 `Notification`。

上面的实现方法也不是绝对完美的，苹果官方指出了这种方法的限制：
* 所有线程的 `Notification` 的处理都必须通过相同的方法 `processNotification:`。
* 每个对象必须提供自己的实现和通信端口。

更好但更复杂的方法是我们自己去子类化一个 `NSNotificationCenter`，或者单独写一个类来处理这种转发。

除了上面苹果官方给我们提供的方法外，我们还可以利用基于 `block` 的 `NSNotification` 去实现，`apple` 从 `ios4` 之后提供了带有 `block` 的 `NSNotification`。使用方式如下：

```
 - (id<NSObject>)addObserverForName:(NSString *)name
                            object:(id)obj
                             queue:(NSOperationQueue *)queue
                        usingBlock:(void (^)(NSNotification *note))block
```

其中：
* 观察者就是当前对象
* `queue` 定义了 `block` 执行的线程，`nil` 则表示 `block` 的执行线程和发通知在同一个线程
* `block` 就是相应通知的处理函数

这个 `API` 已经能够让我们方便的控制通知的线程切换。但是，这里有个问题需要注意。就是其 `remove` 操作。

原来的 `NSNotification` 的 `remove` 方式如下：


```
- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:POST_NOTIFICATION object:nil];
}
```

但是带 `block` 方式的 `remove` 便不能像上面这样处理了。其方式如下：

```
- (void)removeObservers {
    if（_observer）{
        [[NSNotificationCenter defaultCenter] removeObserver:_observer];
    }
}
```

其中 `_observer` 是 `addObserverForName` 方式的 `api` 返回观察者对象。这也就意味着，你需要为每一个观察者记录一个成员对象，然后在 `remove` 的时候依次删除。试想一下，你如果需要 10 个观察者，则需要记录 10 个成员对象，这个想想就是很麻烦，而且它还不能够方便的指定 `observer` 。因此，理想的做法就是自己再做一层封装，将这些细节封装起来。
