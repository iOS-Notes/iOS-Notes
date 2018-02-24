# 倒计时的实现

* 第一种就是直接在TableView的Cell上使用NSTimer。
* 第二种是将NSTimer添加到当前线程所对应的RunLoop中的commonModes中。
* 第三种是通过Dispatch中的TimerSource来实现定时器。
* 第四种是使用CADisplayLink来实现。

以 `UITableViewCell` 为例：

## 一、在Cell中直接使用NSTimer

首先我们按照常规做法，直接在 `UITableView` 的 `Cell` 上添加相应的 `NSTimer`, 并使用 `scheduledTimer` 执行相应的代码块，代码如下所示 ：

```
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setCountDownModel:(MYCountDownModel *)countDownModel {
    _countDownModel = countDownModel;
    
    self.textLabel.text = countDownModel.title;
}

- (void)countDown:(NSTimer *)timer {

    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = @"HH:mm:ss";
    self.detailTextLabel.text = [NSString stringWithFormat:@"倒计时:%@", [dateformatter stringFromDate:[NSDate date]]];
}

```

上述代码比较简单，就是在 `Cell` 上添加了一个定时器，然后每过1秒更新一次时间，并在 `Cel` l的 `timeLabel` 上显示。当我们滑动 `TableView` 时，该定时器就停止了工作。具体原因就是当前线程的 `RunLoop` 在 `TableView` 滑动时将 `DefaultMode` 切换到了 `TrackingRunLoopMode`。因为 `Timer` 默认是添加在 `RunLoop上` 的 `DefaultMode` 上的，当 `Mode` 切换后 `Timer` 就停止了运行。

但是当停止滑动后，`Mode` 又切换了回来，所以 `Timer` 有可以正常工作了。

为了进一步看一下 `Mode` 的切换，我们可以在相应的地方获取当前线程的 `RunLoop` 并且打印对应的 `Mode` 。下方代码就是在 `TableView` 所对应的控制器上添加的，我们在 `viewDidLoad()`、`viewDidAppear()` 以及 `scrollViewDidScroll()` 这个代理方法中对当前线程所对应的 `RunLoop` 下的 `currentMode` 进行了打印，其代码如下。

```
- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"初始化当前的runloopMode:%@",[NSRunLoop mainRunLoop].currentMode);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[MYCountDownViewCell class] forCellReuseIdentifier:identifier];
    
    NSLog(@"viewDidLoad当前的runloopMode:%@",[NSRunLoop mainRunLoop].currentMode);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"viewDidAppear当前的runloopMode:%@",[NSRunLoop mainRunLoop].currentMode);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollView滑动时当前的runloopMode:%@",[NSRunLoop mainRunLoop].currentMode);
}

```

![image.png](http://upload-images.jianshu.io/upload_images/588630-b3ff4f76a19500ea.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

在 `viewDidLoad()`、`viewDidAppear()` 以及刚开始调用 `scrollViewDidScroll()` 方法中打印的 `Current Mode` 为 `kCFRunLoopDefaultMode`, 当我们去滑动 `TableView`，然后在 `scrollViewDidScroll()` 代理方法中打印滑动时当前 `RunLoop` 所对应的 `currentModel` 为 `UITrackingRunLoopMode`。
 

## 二、将Timer添加到CommonMode中

上一部分的定时器是不能正常运行的，因为 `NSTimer` 对象默认添加到了当前 `RunLoop` 的 `DefaultMode` 中，而在切换成 `TrackingRunLoopMode` 时，定时器就停止了工作。解决该问题最直接方法是，将 `NSTimer` 在 `TrackingRunLoopMode` 中也添加一份。这样的话无论是在 `DefaultMode` 还是 `TrackingRunLoopMode` 中，定时器都会正常的工作。

如果对 `RunLoop` 比较熟悉的话，可以知道 `CommonModes` 就是 `DefaultMode` 和 `TrackingRunLoopMode` 的集合，所以我们只需要将 `NSTimer` 对象与当前线程所对应的 `RunLoop` 中的 `CommonModes` 关联即可，具体代码如下所示：


```
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
	[[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setCountDownModel:(MYCountDownModel *)countDownModel {
    _countDownModel = countDownModel;
    
    self.textLabel.text = countDownModel.title;
}

- (void)countDown:(NSTimer *)timer {

    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = @"HH:mm:ss";
    self.detailTextLabel.text = [NSString stringWithFormat:@"倒计时:%@", [dateformatter stringFromDate:[NSDate date]]];
}

```

当该 `TableView` 滚动式，其 `Cell` 上的定时器是可以正常工作的。但是当我们滑动右上角的这个 `TableView` 时，第一个的 `TableView` 中的定时器也是不能正常工作的，因为这些 `TableView` 都在主线程中工作，也就是说这些 `TableView` 所在的 `RunLoop` 是同一个。


## 三、DispatchTimerSource

接下来我们就在 `TableView` 的 `Cell` 上添加 `DispatchTimerSource`，然后看一下运行效果。当然下方代码片段我们是在全局队列中添加的 `DispatchTimerSource`，在主线程中进行更新。当然我们也可以在 `mainQueue` 中添加 `DispatchTimerSource`，这样也是可以正常工作的。当然我们不建议在 `MainQueue` 中做，因为在编程时尽量的把一些和主线程关联不太大的操作放到子线程中去做。代码如下所示：

```
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        
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
    return self;
}

```

## 四、CADisplayLink

接下来我们来使用 `CADisplayLink` 来实现定时器功能，`CADisplayLink` 可以添加到 `RunLoop` 中，每当屏幕需要刷新的时候， `runloop` 就会调用 `CADisplayLink` 绑定的 `target` 上的 `selector`，这时 `target` 可以读到 `CADisplayLink` 的每次调用的时间戳，用来准备下一帧显示需要的数据。例如一个视频应用使用时间戳来计算下一帧要显示的视频数据。在UI做动画的过程中，需要通过时间戳来计算UI对象在动画的下一帧要更新的大小等等。

可以设想一下，我们在动画的过程中， `runloop` 被添加进来了一个高优先级的任务，那么，下一次的调用就会被暂停转而先去执行高优先级的任务，然后在接着执行  `CADisplayLink` 的调用，从而造成动画过程的卡顿，使动画不流畅。


下方代码，为了不让屏幕的卡顿等引起的主线程所对应的 `RunLoop` 阻塞所造成的定时器不精确的问题。我们开启了一个新的线程，并且将 `CADisplayLink` 对象添加到这个子线程的 `RunLoop` 中，然后在主线程中更新UI即可。具体代码如下：

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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setCountDownModel:(MYCountDownModel *)countDownModel {
    _countDownModel = countDownModel;
    self.textLabel.text = countDownModel.title;
}

- (void)countDown {
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = @"HH:mm:ss";
    self.detailTextLabel.text = [NSString stringWithFormat:@"倒计时%@", [dateformatter stringFromDate:[NSDate date]]];
}
```

# 浅析NSTimer & CADisplayLink内存泄漏

## `NSRunLoop` 与定时器

定时器的运行需要结合一个 `NSRunLoop`，同时 `NSRunLoop` 对该定时器会有一个强引用，这也是为什么我们不对 `NSRunLoop` 中的定时器进行强引的原因。

## `- invalidate` 的作用

由于 `NSRunLoop` 对定时器有着牵引，那么问题就来了，那么定时器怎样才能被释放掉呢(先不考虑使用removeFromRunLoop:)，此时 `- invalidate` 函数的作用就来了，我们来看看官方就此函数的介绍：
> Removes the object from all runloop modes (releasing the receiver if it has been implicitly retained) and releases the target object.

据官方介绍可知，`- invalidate` 做了两件事，首先是把本身（定时器）从 `NSRunLoop` 中移除，然后就是释放对 `target` 对象的强引用。从而解决定时器带来的内存泄漏问题。

## 内存泄漏在哪？

![图1](https://github.com/iOS-Strikers/iOS-Analyze/blob/master/contents/CountDown/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202018-02-24%2012.10.38.png)

如图所示，在开发中，如果创建定时器只是简单的计时，不做其他引用，那么 `timer` 对象与 `myClock` 对象循环引用的问题就可以避免（即省略self.timer = timer，前文已经提到过，不再阐述），即图中箭头5可避免。

虽然孤岛问题已经避免了，但还是存在问题，因为 `myClock` 对象被 `UIViewController` 以及 `timer` 引用（`timer` 直接被 `NSRunLoop` 强引用着），当 `UIViewController` 控制器被 `UIWindow` 释放后，`myClock` 不会被销毁，从而导致内存泄漏。

如果对 `timer` 对象发送一个 `invalidate` 消息，这样 `NSRunLoop` 即不会对 `timer` 进行强引，同时 `timer` 也会释放对 `myClock` 对象的强引，这样不就解决了吗？没错，内存泄漏是解决了。

在开发中我们可能会遇到某些需求，只有在 `myClock` 对象要被释放时才去释放 `timer`（此处要注意释放的先后顺序及释放条件），如果提前向 `timer` 发送了 `invalidate` 消息，那么 `myClock` 对象可能会因为 `timer` 被提前释放而导致数据错了，就像闹钟失去了秒针一样，就无法正常工作了。所以我们要做的是在向 `myClock` 对象发送 `dealloc` 消息前在给 `timer` 发送 `invalidate` 消息，从而避免本末倒置的问题。这种情况就像一个死循环（因为如果不给 `timer` 发送 `invalidate` 消息， `myClock` 对象根本不会被销毁， `dealloc` 方法根本不会执行），那么该怎么做呢？

## 解决方案

### 1、NSTimer Target

![图2](https://github.com/iOS-Strikers/iOS-Analyze/blob/master/contents/CountDown/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202018-02-24%2012.13.21.png)

为了解决 `timer` 与 `myClock` 之间类似死锁的问题，我们会将定时器中的 `target` 对象替换成定时器自己，采用分类实现。

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

### 2、NSTimer Proxy

![图3](https://github.com/iOS-Strikers/iOS-Analyze/blob/master/contents/CountDown/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202018-02-24%2012.15.58.png)

这种方式就是创建一个 `NSProxy` 子类 `TimerProxy`，`TimerProxy` 的作用是什么呢？就是什么也不做，可以说只会重载消息转发机制，如果创建一个 `TimerProxy` 对象将其作为 `timer` 的 `target`，专门用于转发 `timer` 消息至 `myClock` 对象，那么问题是不是就解决了呢。

```
NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:[TimerProxy timerProxyWithTarget:self] selector:@selector(startTimer) userInfo:nil repeats:YES];

[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

self.timer = timer;
```

### 3、NSTimer Block

还有一种方式就是采用Block，iOS 10增加的API。

```
+ scheduledTimerWithTimeInterval:repeats:block:
```

# Example 

浅析NSTimer & CADisplayLink内存泄漏：<https://github.com/iOS-Strikers/iOS-Analyze/tree/master/sourcecode/NSTimer%26CADisplayLink>
