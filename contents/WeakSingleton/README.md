## weak singleton

```
+ (instancetype)sharedInstance {
    static __weak MYSingleton *_weakInstance;
    __block MYSingleton *_strongInstance = _weakInstance;
    @synchronized(self) {
        if (!_strongInstance) {
            _strongInstance = [[MYSingleton alloc] init];
            _weakInstance = _strongInstance;
        }
    };
    return _strongInstance;
}
```
场景：

`Controller A`，`B`，`C` 都可以持有 `MYSingleton` 的强引用，一旦 `A`，`B`，`C` 都销毁后，`MYSingleton` 的单例对象也会随之销毁。
`weak singleton` 简单而巧妙的利用了 `weak` 特性，在无人使用 `_strongInstance` 之后就自动销毁当 `sharedInstance` 再次被调用时，`_strongInstance` 又会重新被创建。


## `__weak` 底层原理 `template` 函数

* `template` 模板的概念

对重载函数(`Overloading`)而言，`C++` 的检查机制能通过函数参数的不同及所属类的不同，正确的调用重载函数。
例如，为求两个数的最大值，我们定义 `MAX()` 函数需要对不同的数据类型分别定义不同重载(`Overload`)版本。

```
int max(int x, int y) {
    return (x>y)?x:y;
 }

float max(float x, float y) {
    return (x>y)?x:y;
}

double max(double x,double y) {
    return (c>y)?x:y;
}
```

如果定义了 `char a` 和 `char b`，那么在调用 `max(a,b)` 时程序就会出错，因为我们没有定义 `char` 类型的重载版本。

为解决上述问题 `C++` 引入模板机制，模板定义：模板就是实现代码重用机制的一种工具，它可以实现类型参数化，即把类型定义为参数，从而实现了真正的代码可重用性。
模版可以分为两类，一个是函数模版，另外一个是类模版。

* `template` 函数模板的写法

函数模板的一般形式如下：

```
Template <class或者也可以用typename T>

返回类型 函数名 (形参表) {
    //函数定义体
}
```

## `reinterpret_cast`

`reinterpret_cast` 作用为： 
**允许将任何指针转换为任何其他指针类型，也允许将任何整数类型转换为任何指针类型以及反向转换。**


