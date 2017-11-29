# Load&Initialize

```
+ (void)load;
+ (void)initialize;
```

## Load

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

## Initialize

* `initialize` 的调用是惰性的，它会在第一次调用当前类的方法时被调用。
* 与 `load` 不同，`initialize` 方法调用时，所有的类都已经加载到了内存中。
* `initialize` 的运行是线程安全的。
* 子类会继承父类的 `initialize` 方法。

#### 执行顺序

在项目中没有引用任何文件，当我们运行项目，会发现与 `load` 方法不同的是，虽然我们在 `initialize` 方法中调用了 `NSLog`。但是程序运行之后没有任何输出。

![image.png](http://upload-images.jianshu.io/upload_images/588630-1ed8f3a5cc66ad20.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

结果发现：
没有直接调用 `initialize` 方法。但是，这里也打印出了 `XXXX initialize` 字符串。

** `initialize` 只会在对应类的方法第一次被调用时，才会调用。**

由于子类会继承父类的 `initialize` 方法，即使子类没有实现 `initialize` 方法，也会调用父类的方法，这会导致一个很严重的问题：

![image.png](http://upload-images.jianshu.io/upload_images/588630-e7b192de1527d86f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

运行后发现父类的 `initialize` 方法竟然调用了两次：

虽然 `initialize` 方法对一个类而言只会调用一次，但这里由于出现了两个类，所以调用两次符合规则，但不符合我们的需求。正确使用initialize方法的姿势如下：

```
// In Parent.m
+ (void)initialize {
    if (self == [Parent class]) {
        NSLog(@"Initialize Parent, caller Class %@", [self class]);
    }
}
```

加上判断后，就不会因为子类而调用到自己的 `initialize` 方法了。

** 如果在分类中也实现了 `initialize`  方法，则会出现方法"覆盖"**。

在 `initialize` 方法中打一个断点，来查看这个方法的调用栈：

![image.png](http://upload-images.jianshu.io/upload_images/588630-4b45dbbbeceffd7d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

从runtime初始化开始

![image.png](http://upload-images.jianshu.io/upload_images/588630-9eca14718fb589ea.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

`lookUpImpOrForward` 方法只会在向对象发送消息，并且在类的缓存中没有找到消息的选择子时才会调用。

#### Initialize 方法的应用

由于 `initialize` 作用也非常局限，一般我们只会在 `initialize` 方法中进行一些常量的初始化。
