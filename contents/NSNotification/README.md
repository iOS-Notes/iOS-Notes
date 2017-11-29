# 探索通知的原理

#### NSNotification解决的问题

* 可以实现跨层的传递，例如A页面跳转到B页面，B页面再跳转到C页面，这时候如果我们通过委托回调的模式让A知道C的一些修改，那么实现起来就会很麻烦。
* 可以实现一对多，`NSNotification` 的实际是一种观察者模式。

#### NSNotificationCenter

`NSNotificationCenter` 就相当于一个广播站，使用 `[NSNotificationCenter defaultCenter]` 来获取，`NSNotificationCenter` 实际上是 `iOS` 程序内部之间的一种消息广播机制，主要为了解决应用程序内部不同对象之间解耦而设计。它是基于观察者模式设计的，不能跨应用程序进程通信，当通知中心接收到消息之后会根据内部的消息转发表，将消息发送给订阅者；它可以向应用任何地方发送和接收通知。在通知中心注册观察者，发送者使用通知中心广播时，以 `NSNotification` 的 `name` 和 `object` 来确定需要发送给哪个观察者。为保证观察者能接收到通知，所以应先向通知中心注册观察者，接着再发送通知这样才能在通知中心调度表中查找到相应观察者进行通知。

#### NSNotification

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
如果 `NSNotification` 对象中的 `notificationName` 为 `nil`，则会接收所有的通知。通知中心是以 `NSNotification` 的 `name` 和 `objec` t来确定需要发送给哪个观察者。监听同一条通知的多个观察者，在通知到达时，它们执行回调的顺序是不确定的，所以我们不能去假设操作的执行会按照添加观察者的顺序来执行。

#### NSNotification在多线程中使用

在主线程中注册观察者，在子线程中发送通知，是发送通知的线程处理的通知事件

```
// 往通知中心添加观察者
[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(handleNotification:)
                                             name:@"MyNAME"
                                           object:nil];
NSLog(@"register notifcation thread = %@", [NSThread currentThread]);
// 创建子线程，在子线程中发送通知
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
	NSLog(@"post notification thread = %@", [NSThread currentThread]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MyNAME" object:nil userInfo:nil];
});

- (void)handleNotification:(NSNotification *)notification {
    //打印处理通知方法的线程
    NSLog(@"handle notification thread = %@", [NSThread currentThread]);
}

```

![image.png](http://upload-images.jianshu.io/upload_images/588630-5eda51fb29c68b9b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


在主线程中注册观察者，主线程中发送通知，是发送通知的线程处理的通知事件

```
// 往通知中心添加观察者
[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(handleNotification:)
                                             name:@"MyNAME"
                                           object:nil];
    
NSLog(@"register notifcation thread = %@", [NSThread currentThread]);
    
// 创建子线程，在子线程中发送通知
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
	NSLog(@"post notification thread = %@", [NSThread currentThread]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MyNAME" object:nil userInfo:nil];
});
    
- (void)handleNotification:(NSNotification *)notification {
    //打印处理通知方法的线程
    NSLog(@"handle notification thread = %@", [NSThread currentThread]);
}
```

![image.png](http://upload-images.jianshu.io/upload_images/588630-dee057a3614a9d88.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 通知的原理：

在发送通知的子线程处理通知的事件时，将 `NSNotification` 暂存，然后通过 `MachPort` 往相应线程的 `RunLoop` 中发送事件。相应的线程收到该事件后，取出在队列中暂存的 `NSNotification` , 然后在当前线程中调用处理通知的方法。
![image.png](http://upload-images.jianshu.io/upload_images/588630-7ddc2c7fab912f4d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
