# 手动实现 KVO

---

`KVO` 是 `Objective-C` 对观察者模式`(Observer Pattern)`的实现，当被观察对象的某个属性发生更改时，观察者对象会获得通知。

# KVO 实现机制

`KVO` 的实现也依赖于 `Objective-C` 强大的 `Runtime` ，`Apple` 的文档有简单提到过 `KVO` 的实现：
>Automatic key-value observing is implemented using a technique called isa-swizzling... When an observer is registered for an attribute of an object the isa pointer of the observed object is modified, pointing to an intermediate class rather than at the true class ...

被观察对象的 `isa` 指针会指向一个中间类，而不是原来真正的类。

#### 简单概述下 `KVO` 的实现：

当你观察一个对象时，一个新的类会动态被创建。这个类继承自该对象的原本的类，并重写了被观察属性的 `setter` 方法。自然，重写的 `setter` 方法会负责在调用原 `setter` 方法之前和之后，通知所有观察对象值的更改。最后把这个对象的 `isa` 指针 ( `isa` 指针告诉 `Runtime` 系统这个对象的类是什么 ) 指向这个新创建的子类，对象就神奇的变成了新创建的子类的实例。

# 手动实现 KVO

```
typedef void(^ObservingBlock)(id observedObject, NSString *observedKey, id oldValue, id newValue);

@interface NSObject (KVO)

- (void)addObserver:(NSObject *)observer
forKey:(NSString *)key
withBlock:(ObservingBlock)block;

- (void)removeObserver:(NSObject *)observer forKey:(NSString *)key;

@end
```

接下来，实现 `addObserver:forKey:withBlock:` 方法：

* 检查对象的类有没有相应的 `setter` 方法。如果没有抛出异常；
* 检查对象 `isa` 指向的类是不是一个 `KVO` 类。如果不是，新建一个继承原来类的子类，并把 `isa` 指向这个新建的子类；
* 检查对象的 `KVO` 类重写过没有这个 `setter` 方法。如果没有，添加重写的 `setter` 方法；
* 添加这个观察者；

```
- (void)addObserver:(NSObject *)observer
             forKey:(NSString *)key
          withBlock:(ObservingBlock)block {
    
    SEL setterSelector = NSSelectorFromString(setterForGetter(key));
    Method setterMethod = class_getInstanceMethod([self class], setterSelector);
    if (!setterMethod) {
        NSString *reason = [NSString stringWithFormat:@"Object %@ does not have a setter for key %@", self, key];
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:reason
                                     userInfo:nil];
        
        return;
    }
    
    Class clazz = object_getClass(self);
    NSString *clazzName = NSStringFromClass(clazz);
    
    // if not an KVO class yet
    if (![clazzName hasPrefix:kKVOClassPrefix]) {
        clazz = [self makeKvoClassWithOriginalClassName:clazzName];
        object_setClass(self, clazz);
    }
    
    // add our kvo setter if this class (not superclasses) doesn't implement the setter?
    if (![self hasSelector:setterSelector]) {
        const char *types = method_getTypeEncoding(setterMethod);
        class_addMethod(clazz, setterSelector, (IMP)kvo_setter, types);
    }
    
    ObservationInfo *info = [[ObservationInfo alloc] initWithObserver:observer Key:key block:block];
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void *)(kKVOAssociatedObservers));
    if (!observers) {
        observers = [NSMutableArray array];
        objc_setAssociatedObject(self, (__bridge const void *)(kKVOAssociatedObservers), observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [observers addObject:info];
}
```

第一步，先通过 `setterForGetter()` 方法获得相应的 `setter` 的名字 `(SEL)` 。也就是把 `key` 的首字母大写，然后前面加上 `set` 后面加上 `:` ，这样 `key` 就变成了 `setKey:` 。然后再用 `class_getInstanceMethod` 去获得 `setKey:` 的实现 `(Method)` 。如果没有，自然要抛出异常。

第二步，我们先看类名有没有我们定义的前缀。如果没有，我们就去创建新的子类，并通过 `object_setClass()` 修改 `isa` 指针。

```
- (Class)makeKvoClassWithOriginalClassName:(NSString *)originalClazzName {
    NSString *kvoClazzName = [kKVOClassPrefix stringByAppendingString:originalClazzName];
    Class clazz = NSClassFromString(kvoClazzName);
    
    if (clazz) {
        return clazz;
    }
    
    // class doesn't exist yet, make it
    Class originalClazz = object_getClass(self);
    Class kvoClazz = objc_allocateClassPair(originalClazz, kvoClazzName.UTF8String, 0);
    
    // grab class method's signature so we can borrow it
    Method clazzMethod = class_getInstanceMethod(originalClazz, @selector(class));
    const char *types = method_getTypeEncoding(clazzMethod);
    class_addMethod(kvoClazz, @selector(class), (IMP)kvo_class, types);
    
    objc_registerClassPair(kvoClazz);
    
    return kvoClazz;
}
```

当动态创建新的类需要调用 `objc/runtime.h` 中定义的 `objc_allocateClassPair()` 函数。传一个父类，类名，然后额外的空间（通常为 0），它返回给你一个类。然后就给这个类添加方法，也可以添加变量。这里，我们只重写了 `class` 方法。跟 `Apple` 一样，这时候我们也企图隐藏这个子类的存在。最后 `objc_registerClassPair()` 告诉 `Runtime` 这个类的存在。

第三步，重写 `setter` 方法。新的 `setter` 在调用原 `setter` 方法后，通知每个观察者（调用之前传入的 block ）：

```
static void kvo_setter(id self, SEL _cmd, id newValue) {
    NSString *setterName = NSStringFromSelector(_cmd);
    NSString *getterName = getterForSetter(setterName);
    
    if (!getterName) {
        NSString *reason = [NSString stringWithFormat:@"Object %@ does not have setter %@", self, setterName];
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:reason
                                     userInfo:nil];
        return;
    }
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superclazz = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    // cast our pointer so the compiler won't complain
    void (*objc_msgSendSuperCasted)(void *, SEL, id) = (void *)objc_msgSendSuper;
    
    // call super's setter, which is original class's setter method
    objc_msgSendSuperCasted(&superclazz, _cmd, newValue);
    
    // look up observers and call the blocks
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void *)(kKVOAssociatedObservers));
    for (ObservationInfo *each in observers) {
        if ([each.key isEqualToString:getterName]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                each.block(self, getterName, oldValue, newValue);
            });
        }
    }
}
```

在这里会对 `objc_msgSendSuper` 进行类型转换。因为在 `Xcode 6` 之后， `LLVM` 会对 `objc_msgSendSuper` 以及 `objc_msgSend` 做严格的类型检查，如果不做类型转换。`Xcode` 会提示有 `too many arguments` 的错误。（在 WWDC 2014 的视频 What new in LLVM 中有提到过这个问题。）

最后一步，把这个观察的相关信息存在 `associatedObject` 里。观察的相关信息(观察者，被观察的 `key` , 和传入的 `block` )封装在 `ObservationInfo` 类里。

```
@interface ObservationInfo : NSObject

@property (nonatomic, weak) NSObject *observer;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) ObservingBlock block;

@end

@implementation ObservationInfo

- (instancetype)initWithObserver:(NSObject *)observer
                             Key:(NSString *)key
                           block:(ObservingBlock)block {
    self = [super init];
    if (self) {
        _observer = observer;
        _key = key;
        _block = block;
    }
    return self;
}

@end
```
