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
`Controller A`，`B`，`C` 都可以持有 `MYSingleton` 的强引用，一旦 `A`，`B`，`C` 都销毁后，`MYSingleton` 的单例对象也会随之销毁。当 `sharedInstance` 再次被调用时，`_strongInstance` 又会重新被创建。
