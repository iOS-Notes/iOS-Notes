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

