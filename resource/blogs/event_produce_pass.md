![image.png](https://upload-images.jianshu.io/upload_images/588630-b84bb8008b7bd101?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

# 事件的产生
* 当有触摸或者其他事件产生，将事件交由 `IOKit.framework` 处理。
* `IOKit.framework` 将事件封装成一个 `IOHIDEvent` 对象，并通过 `mach port` 传递给 `SpringBoad`。
* `SpringBoard` 会接收这个对象并通过 `mach port` 转发给当前 `App` 的进程；
* 唤醒 `runloop`，触发了 `source1` 回调，其回调函数为 `__IOHIDEventSystemClientQueueCallback()`。
* `source1` 回调触发 `source0` 回调，将接收到的 `IOHIDEvent` 对象封装成 `UIEvent` 对象进行处理或分发。

注意：
**`SpringBoard` 其实是一个标准的应用程序，这个应用程序用来管理 `iOS` 的主屏幕；**
**`source1` 是苹果用来监听 `mach port` 传来的系统事件的，`source0` 是用来处理用户事件的。**
**`source1` 收到系统事件后，会回调 `source0`，所以最终这些事件都是由 `source0` 处理的。**

# 事件传递的流程
* 当用户点击屏幕时，会产生一个触摸事件，系统会将该事件加入到一个由 `UIApplication` 管理的事件队列中。
* `UIApplication` 会从事件队列中取出最前面的事件，并将事件分发下去以便处理，通常先发送事件给应用程序的主窗口 `keyWindow`。
* 主窗口会调用 `hitTest:withEvent:` 方法在视图 `View` 层次结构中找到一个最合适的 `View` 来处理触摸事件。
* 最终，这个触摸事件交给主窗口的 `hitTest:withEvent:` 方法返回的视图对象去处理。

注意：如果父控件不能接受触摸事件，那么子控件就不可能接收到触摸事件。

#### View 不能接收触摸事件的三种情况：

* 不允许交互：`userInteractionEnabled = NO`；
* 隐藏：如果把父控件隐藏，那么子控件也会隐藏，隐藏的控件不能接受事件；
* 透明度：如果设置一个控件的透明度<0.01，会直接影响子控件的透明度，0.0~0.01 为透明。

注意：
默认 `UIImageView` 不能接受触摸事件，因为不允许交互，即 `userInteractionEnabled = NO`。所以如果希望 `UIImageView` 可以交互，需要设置 `UIImageView` 的 `userInteractionEnabled = YES`。

#### 如何找到最合适的控件来处理事件？

* 首先判断主窗口 `keyWindow` 自己是否能接受触摸事件。
* 调用当前视图的 `pointInside:withEvent:` 方法判断触摸点是否在当前视图内。
* 若 `pointInside:withEvent:` 方法返回 `NO`，说明触摸点不在当前视图内，则当前视图的 `hitTest:withEvent:` 返回 `nil`。
* 若 `pointInside:withEvent:` 方法返回 `YES`，说明触摸点在当前视图内，则遍历当前视图的所有子视图 `subviews`，调用子视图的 `hitTest:withEvent:` 方法重复前面的步骤，子视图的遍历顺序是从上到下，即从 `subviews` 数组的末尾向前遍历，直到有子视图的 `hitTest:withEvent:` 方法返回非空对象或者全部子视图遍历完毕。
* 若第一次有子视图的 `hitTest:withEvent:` 方法返回非空对象，则当前视图的 `hitTest:withEvent:` 方法就返回此对象，处理结束。
* 若所有子视图的 `hitTest:withEvent:` 方法都返回 `nil`，则当前视图的 `hitTest:withEvent:` 方法返回当前视图自身。

# 查找第一响应者
#### hitTest:withEvent:方法
```
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event;
```
控件通过重写 `hitTest:withEvent:` 方法，来判断点击区域是否在视图上，是则返回 `YES`，不是则返回 `NO`，寻找并返回最合适的 `view` (能够响应事件的那个最合适的 `view`)。

**应用程序接收到事件后，将事件交给 `keyWindow` 并转发给根视图，根视图按照视图层级逐级遍历子视图，并且遍历的过程中不断判断视图范围，并最终找到第一响应者。**

事件传递给窗口或控件的后，就递归调用 `hitTest:withEvent:` 方法寻找更合适的 `view`。
在 `hitTest:withEvent:` 方法中，会从上到下遍历子视图，并调用 `subViews` 的 `pointInside:withEvent:` 方法，通过重写 `pointInside:withEvent:` 方法，返回点击区域是否在视图上。如果找到子视图则不断调用其 `hitTest:withEvent:` 方法，以此类推。

#### 在 hitTest:withEvent: 方法中返回 nil 的含义：
在 `hitTest:withEvent:` 方法中返回 `nil` 的意思是调用当前 `hitTest:withEvent:` 方法的 `view` 不是合适的 `view`，子控件也不是合适的 `view`，如果同级的兄弟控件也没有合适的 `view`，那么最合适的 `view` 就是父控件。

#### pointInside:withEvent: 方法

`pointInside:withEvent:` 方法判断子控件的点在不在当前 `view` 上（方法调用者的坐标系上）如果返回 `YES`，代表点在方法调用者的坐标系上；返回 `NO` 代表点不在方法调用者的坐标系上，那么方法调用者也就不能处理事件。

# 查找第一响应者传递过程:

* 如果当前 `view` 是控制器的 `view`，那么控制器就是上一个响应者，事件就传递给控制器；
* 如果当前 `view` 不是控制器的 `view`，那么父视图就是当前 `view` 的上一个响应者，事件就传递给它的父视图。
* 在视图层次结构的最顶级视图，如果也不能处理收到的事件或消息，则其将事件或消息传递给 `window` 对象进行处理。
* 如果 `window` 对象也不处理，则其将事件或消息传递给 `UIApplication` 对象。
* 如果 `UIApplication` 也不能处理该事件或消息，则将其丢弃。

# 事件拦截
有时候想让指定视图来响应事件，不再向其子视图继续传递事件，可以通过重写 `hitTest:withEvent:` 方法。在执行到方法后，直接将该视图返回，而不再继续遍历子视图，这样响应者链的终端就是当前视图。
```
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return self;
}
```

实际开发中可能会遇到一些特殊的交互需求，需要定制视图对于事件的响应。例如下面 `Tabbar` 的这种情况，中间的圆形按钮是底部 `Tabbar `上的控件，而 `Tabbar` 是添加在控制器根视图中的。默认情况下我们点击图中红色方框中按钮的区域，会发现按钮并不会得到响应。
![image.png](https://upload-images.jianshu.io/upload_images/588630-1f27542e7e36f69a?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

很明显，图中红色方框中按钮是添加在 `Tabbar` 上面的，但是图中红色方框中按钮的位置又超出了 `Tabbar` 的区域，当点击红色方框区域后，会发现红色方框得不到响应。

分析：

* 生成的触摸事件首先传到了 `UIWindow`，然后 `UIWindow` 将事件传递给控制器的根视图 `UILayoutContainerView`；
* `UILayoutContainerView` 判断自己可以响应触摸事件，然后将事件传递给子视图 `Tabbar`；
* 子视图 `Tabbar` 判断触摸点并不在自己的坐标范围内，因此返回 `nil`；
* 这时 `UILayoutContainerView` 将事件传递其他子视图 `UINavigationTransitionView`，`UINavigationTransitionView` 判断自己可以响应事件，就将事件时间传递给其子视图 `UIViewControllerWrapperView`；
* `UIViewControllerWrapperView` 判断自己可以响应事件，就将事件传递给子视图 `UITableViewController` 控制器的 `TableView`；
* `TableView` 判断自己可以响应事件，所以 `UITableViewController` 控制器的 `TableView` 就是第一响应者；

整个过程，事件根本没有传递到图中红色方框中按钮；

因此我们需要做的就是修改 `Tabbar` 的 `hitTest:withEvent:` 函数里面判断点击位置是否在 `Tabbar` 坐标范围的的判断条件，也就是需要重写 `Tabbar` 的 
 `pointInside:withEvent:` 方法，判断如果当前触摸坐标在图中红色方框中按钮上面，就返回 `YES`，否则返回 `NO`；这样一来时间就会最终传递到图中红色方框中按钮上面，来响应事件。
```
// TabBar
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    // 将触摸点坐标转换到在 circleButton 上的坐标
    CGPoint pointTemp = [self convertPoint:point toView:_circleButton];
    // 若触摸点在 cricleButton 上则返回 YES
    if ([_circleButton pointInside:pointTemp withEvent:event]) {
        return YES;
    }
    // 否则返回默认的操作
    return [super pointInside:point withEvent:event];
}
```

# 事件转发
在开发过程中，经常会遇到子视图显示范围超出父视图的情况，这时候可以重写该视图的 `pointInside:withEvent:` 方法，将点击区域扩大到能够覆盖所有子视图。
```
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) return nil;
    
    CGFloat inset = 45.0f - 78.0f;
    CGRect touchRect = CGRectInset(self.bounds, inset, inset);
    
    if (CGRectContainsPoint(touchRect, point)) {
        for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
            CGPoint convertedPoint = [subview convertPoint:point fromView:self];
            UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
            if (hitTestView) {
                return hitTestView;
            }
        }
        return self;
    }
    return nil;
}
```
