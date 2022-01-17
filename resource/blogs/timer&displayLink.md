谈论 `NSTimer & CADisplayLink` 内存泄漏，要理解 `NSTimer & CADisplayLink` 的基础概念，下面通过一个倒计时的实现的 `demo` 进入正题。

* 第一种就是直接在 `TableView` 的 `Cell` 上使用 `NSTimer`，然后添加到当前线程所对应的 `RunLoop` 中的 `commonModes` 中。
* 第二种是通过 `Dispatch` 中的 `TimerSource` 来实现定时器。
* 第三种是使用 `CADisplayLink` 来实现。

以 `UITableViewCell` 为例：

### 一、在 `Cell` 中直接使用 `NSTimer`

首先我们按照常规做法，直接在 `UITableView` 的 `Cell` 上添加相应的 `NSTimer`, 并使用 `scheduledTimer` 执行相应的代码块。
代码如下所示：

```
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)countDown:(NSTimer *)timer {
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = @"HH:mm:ss";
    self.textLabel.text = [NSString stringWithFormat:@"倒计时:%@", [dateformatter stringFromDate:[NSDate date]]];
}

- (void)dealloc {
    [self.timer invalidate];
    NSLog(@"%@_%s", self.class, __func__);
}

2017-06-07 13:36:11.981473+0800 NSTimer&CADisplayLink[24050:457782] MYNSTimerBlockViewController_-[MYNSTimerBlockViewController dealloc]

```

### 二、DispatchTimerSource

接下来我们就在 `TableView` 的 `Cell` 上添加 `DispatchTimerSource`，然后看一下运行效果。当然下方代码片段我们是在全局队列中添加的 `DispatchTimerSource`，在主线程中进行更新。当然我们也可以在 `mainQueue` 中添加 `DispatchTimerSource`，这样也是可以正常工作的。当然我们不建议在 `MainQueue` 中做，因为在编程时尽量的把一些和主线程关联不太大的操作放到子线程中去做。
代码如下所示：

```
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        [self countDown];
    }
    return self;
}

- (void)countDown {
    // 倒计时时间
    __block NSInteger timeOut = 60.0f;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.detailTextLabel.text = @"倒计时结束";
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
                dateformatter.dateFormat = @"HH:mm:ss";
                self.detailTextLabel.text = [NSString stringWithFormat:@"倒计时%@", [dateformatter stringFromDate:[NSDate date]]];
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

- (void)dealloc {
    NSLog(@"%@_%s", self.class, __func__);
}

2017-06-07 13:49:43.630398+0800 NSTimer&CADisplayLink[24317:476977] MYNSTimerBlockViewController_-[MYNSTimerBlockViewController dealloc]
```

### 三、CADisplayLink

接下来我们来使用 `CADisplayLink` 来实现定时器功能，`CADisplayLink` 可以添加到 `RunLoop` 中，每当屏幕需要刷新的时候，`runloop` 就会调用 `CADisplayLink` 绑定的 `target` 上的 `selector`，这时 `target` 可以读到 `CADisplayLink` 的每次调用的时间戳，用来准备下一帧显示需要的数据。例如一个视频应用使用时间戳来计算下一帧要显示的视频数据。在UI做动画的过程中，需要通过时间戳来计算UI对象在动画的下一帧要更新的大小等等。

可以设想一下，我们在动画的过程中，`runloop` 被添加进来了一个高优先级的任务，那么，下一次的调用就会被暂停转而先去执行高优先级的任务，然后在接着执行  `CADisplayLink` 的调用，从而造成动画过程的卡顿，使动画不流畅。

下方代码，为了不让屏幕的卡顿等引起的主线程所对应的 `RunLoop` 阻塞所造成的定时器不精确的问题。我们开启了一个新的线程，并且将 `CADisplayLink` 对象添加到这个子线程的 `RunLoop` 中，然后在主线程中更新UI即可。
具体代码如下：

```
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        dispatch_queue_t disqueue =  dispatch_queue_create("com.countdown", DISPATCH_QUEUE_CONCURRENT);
        dispatch_group_t disgroup = dispatch_group_create();
        dispatch_group_async(disgroup, disqueue, ^{
            self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(countDown)];
            [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        });
    }
    return self;
}

- (void)countDown {
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = @"HH:mm:ss";
    self.detailTextLabel.text = [NSString stringWithFormat:@"倒计时%@", [dateformatter stringFromDate:[NSDate date]]];
}

- (void)dealloc {
    [self.link invalidate];
    NSLog(@"%@_%s", self.class, __func__);
}

2017-06-07 13:49:43.630398+0800 NSTimer&CADisplayLink[24317:476977] MYNSTimerBlockViewController-[MYNSTimerBlockViewController dealloc]
```

## 得出结论

从上面的三种 `demo` 可以看出 `UITableViewCell` 没有被释放，由此得出结论，当 `UITableViewCell` 里面强引用了定时器，定时器又强引用了 `UITableViewCell`，这样两者的 `retainCount` 值一直都无法为0，于是内存始终无法释放，导致内存泄露。所谓的内存泄露就是本应该释放的对象，在其生命周期结束之后依旧存在。

## 原因

定时器的运行需要结合一个 `NSRunLoop`，同时 `NSRunLoop` 对该定时器会有一个强引用，这也是为什么我们不能对 `NSRunLoop` 中的定时器进行强引的原因。

由于 `NSRunLoop` 对定时器有引用，定时器怎样才能被释放掉。
> Removes the object from all runloop modes (releasing the receiver if it has been implicitly retained) and releases the target object.

据官方介绍可知，`- invalidate` 做了两件事，首先是把本身（定时器）从 `NSRunLoop` 中移除，然后就是释放对 `target` 对象的强引用，从而解决定时器带来的内存泄漏问题。

从上面的 `demo` 中看出，在 `UITableViewCell` 的 `dealloc` 方法中调用 `invalidate` 方法，并没有解决问题。

## 分析

这里使用下 `Xcode8` 调试黑科技 `Memory Graph` 来检测下内存泄漏：

![image.png](https://upload-images.jianshu.io/upload_images/588630-f2c2468c9ecf756f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

从图中可以看出：
```
NSRunLoop  ---> 定时器 ---> UITableViewCell
```
导致 `UITableViewCell` 中没有释放掉定时器。

```
self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(countDown)];
[self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
```
从代码中看出，`Target` 直接设置成 `self` 会造成内存泄， `CADisplayLink` 会强引用 `Target`。当 `CADisplayLink` 添加到 `NSRunLoop` 中，`NSRunLoop` 会强引用 `CADisplayLink`。如果仅仅在 `dealloc` 中调用 `CADisplayLink` 的 `invalidate` 方法是没用的，因为 `NSRunLoop` 的存在 `CADisplayLink` 不会被释放，`Target` 被强引用，`Target` 的 `dealloc` 方法不会被调用，`CADisplayLink` 的 `invalidate` 方法也不被调用，`CADisplayLink` 不会从 `NSRunLoop` 中移除，从而导致内存泄漏。

[NSRunLoop 的问题请查看这里](https://blog.ibireme.com/2015/05/18/runloop/)

## 解决方案
### 1、Target

为了解决定时器与 `Target` 之间类似死锁的问题，我们会将定时器中的 `target` 对象替换成定时器自己，采用分类实现。

```
#import "NSTimer+TimerTarget.h"

@implementation NSTimer (TimerTarget)

+ (NSTimer *)my_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
					repeat:(BOOL)yesOrNo 
					 block:(void (^)(NSTimer *))block {
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(startTimer:) userInfo:[block copy] repeats:yesOrNo];
}

+ (void)startTimer:(NSTimer *)timer {
    void (^block)(NSTimer *timer) = timer.userInfo;
    if (block) {
        block(timer);
    }
}
@end
```

### 2、Proxy

这种方式就是创建一个 `NSProxy` 子类 `TimerProxy`，`TimerProxy` 的作用是什么呢？就是什么也不做，可以说只会重载消息转发机制，如果创建一个 `TimerProxy` 对象将其作为定时器的 `target`，专门用于转发定时器消息至 `Target` 对象，那么问题是不是就解决了呢。

```
NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:[TimerProxy timerProxyWithTarget:self] selector:@selector(startTimer) userInfo:nil repeats:YES];

[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

self.timer = timer;
```

### 3、NSTimer Block

还有一种方式就是采用Block，iOS 10增加的API。

```
+ scheduledTimerWithTimeInterval:repeats:block:

NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.25 repeats:YES block:^(NSTimer * _Nonnull timer) {
    NSLog(@"MYNSTimerTargetController timer start");
}];

[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
self.timer = timer;
```

## Example 

[浅析NSTimer & CADisplayLink内存泄漏](https://github.com/iOS-Advanced/iOS-Advanced/tree/master/sourcecode/NSTimer%26CADisplayLink)
