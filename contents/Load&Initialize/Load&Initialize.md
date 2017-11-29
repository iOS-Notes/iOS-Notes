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

从runtime初始化开始

![image.png](http://upload-images.jianshu.io/upload_images/588630-9494f2a6913b9e0c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

当 `Objective-C` 运行时初始化的时候，会通过 `dyld_register_image_state_change_handler` 在每次有新的镜像加入运行时的时候，进行回调。

* `map_images` 主要是在 `image` 加载进内容后对其二进制内容进行解析，初始化里面的类的结构等。
* `load_images` 主要是调用 `call_load_methods`。按照继承层次依次调用 `Class` 的 `+load` 方法然后再是 `Category` 的 `+load` 方法。

![image.png](http://upload-images.jianshu.io/upload_images/588630-ab9a17fe1c457f6a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![image.png](http://upload-images.jianshu.io/upload_images/588630-ec529c4bedd7e4ba.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

从源码中可以看出，
* 通过 `_getObjc2NonlazyClassList` 获取所有的类的列表之后，会通过 `remapClass` 获取类对应的指针，然后调用 `schedule_class_load` 递归把当前类和没有调用 `+ load` 方法的父类，通过 `add_class_to_loadable_list(cls)` 方法添加到 `loadable_classes` 列表中，**保证父类在子类前调用 `+load` 方法**。
* 通过 `_getObjc2NonlazyCategoryList` 获取所有的分类的列表之后，会通过 `remapClass` 获取分类对应的指针，然后调用` add_category_to_loadable_list` 把当前分类添加到 `loadable_categories` 列表中。

在将镜像加载到运行时、对 `+load` 方法的准备就绪之后，执行 `call_load_methods`，开始调用 `+load` 方法：

![image.png](http://upload-images.jianshu.io/upload_images/588630-908e53a2462438c8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* 不停调用类的 `+load` 方法，直到 `loadable_classes` 为空。
* 然后调用一次 `call_category_loads` 加载分类。
* 如果有 `loadable_classes` 或者更多的分类，继续调用 `+load` 方法。
* **类先于分类调用**。

![image.png](http://upload-images.jianshu.io/upload_images/588630-5c3408d006682624.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

其中 `call_class_loads` 会从一个待加载的类列表 `loadable_classes` 中寻找对应的类，然后通过对应的 `SEL` ，找到 `IMP` 的实现并执行。

#### load 方法的应用

由于调用 `+load` 方法运行时间过早，环境很不安全，我们应该尽量减少 `+load` 方法的逻辑。另一个原因是load方法是线程安全的，它内部使用了锁，所以我们应该避免线程阻塞在 `+load` 方法中。不过在这个时间点，所有的 `framework` 都已经加载到了运行时中，所以调用 `framework` 中的方法都是安全的。
