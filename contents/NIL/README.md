# Objective-C中nil使用的最佳实践

首先要明白的是，`nil`、`Nil`、`NULL` 三个关键字和 `NSNull` 类都是表示空，只是用处不一样，具体的区别如下：

* NULL

```
#undef NULL
#ifdef __cplusplus
#  if !defined(__MINGW32__) && !defined(_MSC_VER)
#    define NULL __null
#  else
#    define NULL 0
#  endif
#else
#  define NULL ((void*)0)
#endif
```

其中 `__cplusplus` 表示是不是 `C++` 代码，所以对于普通的 `iOS` 开发者来说，通常 `NULL` 的定义就是：

```
#  define NULL ((void*)0)
```

因此，***NULL本质上是：(void*)0***

* nil

```
#ifndef nil
# if __has_feature(cxx_nullptr)
#   define nil nullptr
# else
#   define nil __DARWIN_NULL
# endif
```

其中 `__has_feature(cxx_nullptr)` 用于判断 `C++` 中是否有 `nullptr` 特性，对于普通 `iOS` 开发者来说，`nil` 的定义形式为：

```
#   define nil __DARWIN_NULL
```

就是说 `nil` 最终是 `__DARWIN_NULL` 的宏定义，`__DARWIN_NULL` 是定义在 `_types.h` 中的宏，其定义形式如下：

```
#ifdef __cplusplus
#ifdef __GNUG__
#define __DARWIN_NULL __null
#else /* ! __GNUG__ */
#ifdef __LP64__
#define __DARWIN_NULL (0L)
#else /* !__LP64__ */
#define __DARWIN_NULL 0
#endif /* __LP64__ */
#endif /* __GNUG__ */
#else /* ! __cplusplus */
#define __DARWIN_NULL ((void *)0)
#endif /* __cplusplus */
```

非 `C++` 代码的 `__DARWIN_NULL` 最终定义形式如下：

```
#define __DARWIN_NULL ((void *)0)
```

也就是说，***nil本质上是：(void *)0***

* Nil

```
#ifndef Nil
# if __has_feature(cxx_nullptr)
#   define Nil nullptr
# else
#   define Nil __DARWIN_NULL
# endif
```

和上面讲到的nil一样，***Nil本质上也是：(void *)0***

* NSNull

```
@interface NSNull : NSObject <NSCopying, NSSecureCoding>

+ (NSNull *)null;

@end
```

从定义中可以看出， `NSNull` 是一个 `Objective-C` 类，只不过这个类相当特殊，因为它表示的是空值，即什么都不存。它也只有一个单例方法  `+[NSUll null]` ，该类通常用于在集合对象中保存一个空的占位对象。


从前面的介绍可以看出，不管是 `NULL`、 `nil` 还是 `Nil`，它们本质上都是一样的，都是 `(void *)0`，只是写法不同。这样做的意义是为了区分不同的数据类型，比如你一看到用到了 `NULL` 就知道这是个 `C` 指针，看到nil就知道这是个 `Objective-C` 对象，看到 `Nil` 就知道这是个 `Class` 类型的数据。


#### 没有必要将nil作为初始值赋给变量

```
NSString *myString = nil;
```

上面的代码与不带 `nil` 效果相同，所以让我们保持简洁：

```
NSString *myString;
```

#### Delegate


```
if (self.delegate) {
    if ([self.delegate respondsToSelector:@selector(@"didFinish")]) {
        [self.delegate didFinish];
    }
}
```

这段代码也能被简化，当 `delegate` 为 `nil` 时，`nil` 只能够接收值为 `nil` 的消息，所以最外一层判断是不必要的，可以简化如下：

```
if ([self.delegate respondsToSelector:@selector(@"didFinish")]) {
    [self.delegate didFinish];
}
```

#### 简化条件句

```
if (myObj == nil)
```

能够被简化为：

```
if (!myObj)
```

同时也注意避免使用 `!=` ：

```
if (myObj != nil)
```

它难以阅读，看看下面功能相同的代码是如何简单的：

```
if (myObj)
```
