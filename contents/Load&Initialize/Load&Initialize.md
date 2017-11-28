# Load&Initialize

```
+ (void)load;
+ (void)initialize;
```

如果你实现了 `+ load` 方法，那么当类被加载到内存时，它会自动被调用，并且是在 `main` 函数调用之前被调用。

#### load 方法的调用栈

首先分析一下 `load` 方法是如何被调用的

![image.png](http://upload-images.jianshu.io/upload_images/588630-79f9a27a6fad634c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

从控制台的打印可以看出，运行之后，依然打印了 `XXXX load` 字符串，也就是说调用了 `+ load` 方法。

#### 执行顺序

`load` 方法的调用顺序其实有迹可循，我们看到 `demo` 的项目设置如下：

![image.png](http://upload-images.jianshu.io/upload_images/588630-578317d4cc2d9920.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

在 `TARGETS -> Build Phases -> Compile Sources`中调整一下文件的加载顺序：

![image.png](http://upload-images.jianshu.io/upload_images/588630-0bdb3567814e7f69.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

结果发现：
* 在 `load` 方法的调用中会自动调用父类的方法，即**父类先于子类调用**。
* 在 `load` 方法的调用中，**文件的加载顺序靠前的类优先调用**。
* 在 `load` 方法的调用中，**类先于分类调用**。
* 在 `load` 方法的调用中，**文件的加载顺序靠前的分类优先调用**。

#### `load`方法如何加载到内存中

使用 `Xcode` 添加一个符号断点 `+[Parent load]`：

![image.png](http://upload-images.jianshu.io/upload_images/588630-fc3a92e363d99516.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

注意：
注意这里 `+` 和 `[` 之间没有空格

重新运行程序。这时，代码会停在 `NSLog(@"%@ , %s", [self class], __FUNCTION__);` 这一行的实现上：

左侧的调用栈很清楚的展示哪些方法被调用了：

```
0  +[Parent load]
1  call_load_methods
2  load_images
3  dyld::notifySingle(dyld_image_states, ImageLoader const*, ImageLoader::InitializerTimingList*)
...
13 _dyld_start
```

