# UIScrollView的原理

`UIKit` 坐标系每一个 `View` 都定义了他自己的坐标系，如下图所示，`x` 轴指向右方，`y` 轴指向下方：

![image.png](http://upload-images.jianshu.io/upload_images/588630-b4be73e8ede40f16.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

注意：
这个逻辑坐标系并不关注包含在其中 `View` 的宽度和高度，整个坐标系没有边界向四周无限延伸。
我们在坐标系中放置四个子 `View`，每一次色块代表一个 `View`：

![image.png](http://upload-images.jianshu.io/upload_images/588630-173b57f84345e191.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```
UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
redView.backgroundColor = [UIColor colorWithRed:0.815 green:0.007
blue:0.105 alpha:1];

UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(150, 160, 150, 200)];
greenView.backgroundColor = [UIColor colorWithRed:0.494 green:0.827
blue:0.129 alpha:1];

UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(40, 400, 200, 150)];
blueView.backgroundColor = [UIColor colorWithRed:0.29 green:0.564
blue:0.886 alpha:1];

UIView *yellowView = [[UIView alloc] initWithFrame:CGRectMake(100, 600, 180, 150)];
yellowView.backgroundColor = [UIColor colorWithRed:0.972 green:0.905
blue:0.109 alpha:1];

[mainView addSubview:redView];
[mainView addSubview:greenView];
[mainView addSubview:blueView];
[mainView addSubview:yellowView];
```

#### bounds

`Apple` 关于 `UIView` 的文档中是这样描述 `bounds` 属性的：

> bounds矩形…描述了该视图在其自身坐标系中的位置和大小。

一个 `View` 可以被看作是定义在其所在坐标系平面上的一个矩形的可视区域，`View` 的边界表明了这个矩形可视区域的位置和大小。

假设我们的 `View` 宽320像素，高480像素，原点在（0，0）。那么这个 `View` 就变成了整个坐标系平面的观察口，它展示的只是整个平面的一小部分。位于该 `View` 边界外的区域依然存在，只是被隐藏起来了。

![image.png](http://upload-images.jianshu.io/upload_images/588630-ce142480ad4ae548.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

一个 `View` 提供了其所在平面的一个观察口，`View` 的 `bounds` 矩形描述了这个可是区域的位置和大小。

接下来我们来试着修改 `bounds` 的原点坐标：

```
CGRect bounds = mainView.bounds;
bounds.origin = CGPointMake(0, 100);
mainView.bounds = bounds;
```

当我们把 `bound` 原点设为（0，100）后，整个画面看起来就像这样：

![image.png](http://upload-images.jianshu.io/upload_images/588630-615c7c579a14e6f6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

修改 `bounds` 的原点就相当与在平面上移动这个可视区域。

看起来好像是这个 `View` 向下移动了100像素，在这个 `View` 自己的坐标系中这确实没错。不过这个 `View` 真正位于屏幕上的位置（更准确的说在其父 `View` 上的位置）其实没有改变，因为这是由 `View` 的 `frame` 属性决定的，它并没有改变：

> frame矩形…定义了这个View在其父View坐标系中的位置和大小。

由于 `View` 的位置是相对固定的，你可以把整个坐标平面想象成我们可以上下拖动的透明幕布，把这个 `View` 想象成我们观察坐标平面的窗口。调整 `View` 的 `Bounds` 属性就相当于拖动这个幕布，那么下方的内容就能在我们 `View` 中被观察到：

![image.png](http://upload-images.jianshu.io/upload_images/588630-660f880bec22bb97.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

修改 `bounds` 的原点坐标也相当于把整个坐标系向上拖动，因为 `View` 的 `frame` 没由变过，所以它相对于父 `View` 的位置没有变化过。

其实这就是 `UIScrollView` 滑动时所发生的事情。注意从一个用户的角度来看，他以为时这个 `View` 中的子 `View` 在移动，其实他们的在坐标系中位置（他们的 `frame` ）没有发生过变化。

一个 `scroll view` 并不需要其中子 `View` 的坐标来使他们滚动，唯一要做的就是改变他的 `bounds` 属性。知道了这一点，实现一个简单的 `scroll view` 就没什么困难了。我们用一个 `gesture recognizer` 来识别用户的拖动操作，根据用户拖动的偏移量来改变 `bounds` 的原点：

和真正的 `UIScrollView` 一样，我们的类也有一个 `contentSize` 属性，你必须从外部来设置这个值来指定可以滚动的区域，当我们改变 `bounds` 的大小时我们要确保设置的值是有效的。
