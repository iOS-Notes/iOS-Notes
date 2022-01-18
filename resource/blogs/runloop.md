### RunLoop 的概念

`RunLoop` 就是一个调度任务和处理任务的事件循环。

`OSX/iOS` 系统中，提供了两个这样的对象：`NSRunLoop` 和 `CFRunLoopRef`。
`CFRunLoopRef` 是在 `CoreFoundation` 框架内的，它提供了纯 `C` 函数的 `API`，所有这些 `API` 都是线程安全的。
`NSRunLoop` 是基于 `CFRunLoopRef` 的封装，提供了面向对象的 `API`，但是这些 `API` 不是线程安全的。

### RunLoop 与线程的关系

```
/// 全局的Dictionary，key 是 pthread_t， value 是 CFRunLoopRef
static CFMutableDictionaryRef loopsDic;
/// 访问 loopsDic 时的锁
static CFSpinLock_t loopsLock;
 
/// 获取一个 pthread 对应的 RunLoop。
CFRunLoopRef _CFRunLoopGet(pthread_t thread) {
    OSSpinLockLock(&loopsLock);
    
    if (!loopsDic) {
        // 第一次进入时，初始化全局Dic，并先为主线程创建一个 RunLoop。
        loopsDic = CFDictionaryCreateMutable();
        CFRunLoopRef mainLoop = _CFRunLoopCreate();
        CFDictionarySetValue(loopsDic, pthread_main_thread_np(), mainLoop);
    }
    
    /// 直接从 Dictionary 里获取。
    CFRunLoopRef loop = CFDictionaryGetValue(loopsDic, thread));
    
    if (!loop) {
        /// 取不到时，创建一个
        loop = _CFRunLoopCreate();
        CFDictionarySetValue(loopsDic, thread, loop);
        /// 注册一个回调，当线程销毁时，顺便也销毁其对应的 RunLoop。
        _CFSetTSD(..., thread, loop, __CFFinalizeRunLoop);
    }
    
    OSSpinLockUnLock(&loopsLock);
    return loop;
}
 
CFRunLoopRef CFRunLoopGetMain() {
    return _CFRunLoopGet(pthread_main_thread_np());
}
 
CFRunLoopRef CFRunLoopGetCurrent() {
    return _CFRunLoopGet(pthread_self());
}
```

* `RunLoop` 与线程是一一对应的，其关系是保存在一个全局的 `Dictionary` 里。
* 主线程的 `RunLoop` 是由系统自动创建好的，而子线程中的 `RunLoop` 需要我们手动获取并启动。
* `RunLoop` 的销毁是发生在线程结束时。

### RunLoop 的数据结构
```
struct __CFRunLoop {
    CFRuntimeBase _base;
    pthread_mutex_t _lock;			/* locked for accessing mode list */
    __CFPort _wakeUpPort;			// used for CFRunLoopWakeUp 
    Boolean _unused;
    volatile _per_run_data *_perRunData;              // reset for runs of the run loop
    pthread_t _pthread;
    uint32_t _winthread;
    CFMutableSetRef _commonModes;
    CFMutableSetRef _commonModeItems;
    CFRunLoopModeRef _currentMode;
    CFMutableSetRef _modes;
    struct _block_item *_blocks_head;
    struct _block_item *_blocks_tail;
    CFAbsoluteTime _runTime;
    CFAbsoluteTime _sleepTime;
    CFTypeRef _counterpart;
};

struct __CFRunLoopMode {
    CFRuntimeBase _base;
    pthread_mutex_t _lock;	/* must have the run loop locked before locking this */
    CFStringRef _name;
    Boolean _stopped;
    char _padding[3];
    CFMutableSetRef _sources0;
    CFMutableSetRef _sources1;
    CFMutableArrayRef _observers;
    CFMutableArrayRef _timers;
    CFMutableDictionaryRef _portToV1SourceMap;
    __CFPortSet _portSet;
    CFIndex _observerMask;
#if USE_DISPATCH_SOURCE_FOR_TIMERS
    dispatch_source_t _timerSource;
    dispatch_queue_t _queue;
    Boolean _timerFired; // set to true by the source when a timer has fired
    Boolean _dispatchTimerArmed;
#endif
#if USE_MK_TIMER_TOO
    mach_port_t _timerPort;
    Boolean _mkTimerArmed;
#endif
#if DEPLOYMENT_TARGET_WINDOWS
    DWORD _msgQMask;
    void (*_msgPump)(void);
#endif
    uint64_t _timerSoftDeadline; /* TSR */
    uint64_t _timerHardDeadline; /* TSR */
};
```
![image.png](https://github.com/iOS-Advanced/iOS-Advanced/blob/master/resource/RunLoop_0.png)

从 `CFRunLoopMode` 的源码不难看出，一个 `RunLoop` 包含若干个 `Mode`，每个 `Mode` 又包含若干个 `Source/Timer/Observer`。每次调用 `RunLoop` 的主函数时，只能指定其中一个 `Mode`，这个 `Mode` 被称作 `CurrentMode`。如果需要切换 `Mode`，只能退出 `RunLoop`，再重新指定一个 `Mode` 进入。这样做主要是为了分隔开不同组的 `Source/Timer/Observer`，让其互不影响。

### RunLoop 常用的 Mode
在 `iOS` 中公开暴露只有 `NSDefaultRunLoopMode` 和`NSRunLoopCommonModes`。

* `NSDefaultRunLoopMode`：`App` 的默认 `Mode`，通常主线程是在这个 `Mode` 下运行的。
* `UITrackingRunLoopMode`：界面跟踪 `Mode`，用于 `ScrollView` 追踪触摸滑动，保证界面滑动时不受其他 `Mode` 影响。
* `NSRunLoopCommonModes`：是一个占位的 `Mode`，可以标记为 `Common` 属性（通过将其 `ModeName` 添加到 `RunLoop` 的 `commonModes` 中）。每当 `RunLoop` 的内容发生变化时，`RunLoop` 都会自动将 `_commonModeItems` 里的 `Source/Observer/Timer` 同步到具有 `Common` 标记的所有 `Mode` 里。

应用场景举例：主线程的 `RunLoop` 里有两个预置的 `Mode`：`NSDefaultRunLoopMode` 和 `UITrackingRunLoopMode`。这两个 `Mode` 都已经被标记为 `Common` 属性。`DefaultMode` 是 `App` 平时所处的状态，`TrackingRunLoopMode` 是追踪 `ScrollView` 滑动时的状态。当你创建一个 `Timer` 并加到 `DefaultMode` 时，`Timer` 会得到重复回调，但此时滑动一个 `TableView` 时，`RunLoop` 会将 `mode` 切换为 `TrackingRunLoopMode`，这时 `Timer` 就不会被回调，并且也不会影响到滑动操作。

有时你需要一个 `Timer`，在两个 `Mode` 中都能得到回调，一种办法就是将这个 `Timer` 分别加入这两个 `Mode`。还有一种方式，就是将 `Timer` 加入到顶层的 `RunLoop` 的 `commonModeItems` 中。`commonModeItems` 被 `RunLoop `自动更新到所有具有 `Common` 属性的 `Mode` 里去。

### __CFRunLoopSource 
```
struct __CFRunLoopSource {
    CFRuntimeBase _base;
    uint32_t _bits;
    pthread_mutex_t _lock;
    CFIndex _order;			/* immutable */
    CFMutableBagRef _runLoops;
    union {
	CFRunLoopSourceContext version0;	/* immutable, except invalidation */
        CFRunLoopSourceContext1 version1;	/* immutable, except invalidation */
    } _context;
};
```

`CFRunLoopSourceRef` 是事件产生的地方，分为 `source0` 和 `source1` 两个版本。
* `source0`：是 `App` 内部事件，只包含一个函数指针回调，并不能主动触发事件，使用时，你需要先调用 `CFRunLoopSourceSignal(source)`，将这个 `source` 标记为待处理，然后手动调用 `CFRunLoopWakeUp(runloop)` 来唤醒 `RunLoop`，让其处理这个事件。
* `source1`：`source1` 包含一个 `mach_port` 和一个函数回调指针。`source1` 是基于 `port` 的，通过读取某个 `port` 上内核消息队列上的消息来决定执行的任务，然后再分发到 `sources0` 中处理的。`source1` 只供系统使用，并不对开发者开放。

`Source0` 和 `Source1` 都可用于线程(或进程)交互，但交互的形式有所不同，`Source1` 监听端口，当端口有消息到达时，响应的 `Source1` 就会被触发回调，完成响应的操作；而 `Source0` 并不监听端口，让 `Source0` 执行回调需要手动标记 `Source0` 为待处理状态，手动呼醒 `Source0` 所在的 `Runloop`。从`Source1` 和 `Source0` 的交互方式了解到，`Source1` 的交互会主动呼醒所在的 `Runloop`，而 `Source0` 的交互则需要依赖其他线程来呼醒 `Source0` 所在的 `Runloop`。一次 `Runloop` 只能执行一个 `Source1` 的回调，但可以执行多个待处理的 `Source0` 的回调。

### CFRunLoopObserverRef
`CFRunLoopObserverRef` 对应着 `__CFRunLoopObserver` 结构体，实现如下：
```
struct __CFRunLoopObserver {
    CFRuntimeBase _base;
    pthread_mutex_t _lock;
    CFRunLoopRef _runLoop;
    CFIndex _rlCount;
    CFOptionFlags _activities;		/* immutable */
    CFIndex _order;			/* immutable */
    CFRunLoopObserverCallBack _callout;	/* immutable */
    CFRunLoopObserverContext _context;	/* immutable, except invalidation */
};
```
每个 `Observer` 都包含了一个回调（函数指针 `CFRunLoopObserverCallBack _callout`），当 `RunLoop` 的状态发生变化时，观察者就能通过回调接受到这个变化。
`RunLoop` 有以下几种状态：
```
typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
    kCFRunLoopEntry = (1UL << 0), // 即将进入loop
    kCFRunLoopBeforeTimers = (1UL << 1), // 即将处理Timer
    kCFRunLoopBeforeSources = (1UL << 2), // 即将处理Source
    kCFRunLoopBeforeWaiting = (1UL << 5), // 即将进入休眠
    kCFRunLoopAfterWaiting = (1UL << 6), // 结束休眠或被唤醒
    kCFRunLoopExit = (1UL << 7), // 退出loop
    kCFRunLoopAllActivities = 0x0FFFFFFFU
};
```

### CFRunLoopTimerRef

`CFRunLoopTimerRef` 对应着 `__CFRunLoopTimer` 结构体，实现如下：
```
struct __CFRunLoopTimer {
    CFRuntimeBase _base;
    uint16_t _bits;
    pthread_mutex_t _lock;
    CFRunLoopRef _runLoop;
    CFMutableSetRef _rlModes;
    CFAbsoluteTime _nextFireDate;
    CFTimeInterval _interval;		/* immutable */
    CFTimeInterval _tolerance;          /* mutable */
    uint64_t _fireTSR;			/* TSR units */
    CFIndex _order;			/* immutable */
    CFRunLoopTimerCallBack _callout;	/* immutable */
    CFRunLoopTimerContext _context;	/* immutable, except invalidation */
};
```
`CFRunLoopTimerRef` 是基于时间的触发器，其包含一个时间长度和一个回调（函数指针）。当其加入到 `RunLoop` 时，`RunLoop` 会注册对应的时间点，当时间点到时，`RunLoop` 会被唤醒以执行那个回调。

### RunLoop 运行流程图
![image.png](https://github.com/iOS-Advanced/iOS-Advanced/blob/master/resource/RunLoop_run.png)

### 参考
[深入理解RunLoop](https://blog.ibireme.com/2015/05/18/runloop/)