# sunjinshuai Blog

iOS 开发学习笔记，涵盖 Objective-C、Runtime、UIKit、多线程、网络与工程实践。

[阅读仓库内正文](resource/blogs/) · [浏览示例源码](sourcecode/)

## 目录

- [iOS 开发](#ios-开发)
- [设计原则](#设计原则)
- [算法](#算法)
- [Mac 与工具](#mac-与工具)
- [示例代码](#示例代码)
- [关于](#关于)

## iOS 开发

### 基础与对象

- [浅谈 KVO 的实现原理](https://www.jianshu.com/p/5d4cc25165d5)
- [浅谈 KVC](https://www.jianshu.com/p/fd695319a7f8)
- [浅谈 NSUserDefaults](https://www.jianshu.com/p/d9c9537cb9cf)
- [浅谈 AutoreleasePool 的实现原理](https://www.jianshu.com/p/082adc9dc749)
- [浅谈 iOS NSNotification](https://www.jianshu.com/p/d3718f2b23c6)

### Runtime

- [iOS RunTime 之一：简介](https://www.jianshu.com/p/1312c8eb2381)
- [iOS RunTime 之二：类结构](https://www.jianshu.com/p/3fa276ed26f9)
- [iOS RunTime 之三：消息发送](https://www.jianshu.com/p/afc051dd84d8)
- [iOS RunTime 之四：消息转发](https://www.jianshu.com/p/8cd06cd496d5)
- [iOS RunTime 之五：Category 面试题](https://www.jianshu.com/p/ccbd2a07db1f)
- [iOS RunTime 之六：Category](https://www.jianshu.com/p/8b4432f5586e)
- [浅谈 Objective-C Associated Objects](https://www.jianshu.com/p/4cfad89174b7)
- [load 与 initialize](https://sunjinshuai.github.io/2016/09/19/Load-Initialize/)

### Block

- [Block 系列之 Block 基础](https://sunjinshuai.github.io/2015/07/05/block%E7%B3%BB%E5%88%97%E4%B9%8Bblock%E5%9F%BA%E7%A1%80/)
- [Block 系列之 Block 的存储域](https://sunjinshuai.github.io/2015/07/17/block%E7%B3%BB%E5%88%97%E4%B9%8Bblock%E7%9A%84%E5%AD%98%E5%82%A8%E5%9F%9F/)
- [Block 系列之 Block 的实现原理](https://sunjinshuai.github.io/2015/07/20/block%E7%B3%BB%E5%88%97%E4%B9%8Bblock%E7%9A%84%E5%AE%9E%E7%8E%B0%E5%8E%9F%E7%90%86/)

### 多线程与定时器

- [iOS 多线程之一：基本概念](https://www.jianshu.com/p/18ab9a7daef6)
- [iOS 多线程之二：NSThread 的使用](https://www.jianshu.com/p/0973c461de51)
- [iOS 多线程之三：GCD 的使用](https://www.jianshu.com/p/ed2753122f57) · [示例说明](sourcecode/Thread/GCD/README.md)
- [iOS 多线程之四：NSOperation 的使用](https://www.jianshu.com/p/dcf9b9c3a1fd)
- [RunLoop 的概念与运行流程](resource/blogs/runloop.md)
- [浅析 NSTimer 和 CADisplayLink 内存泄漏](resource/blogs/timer%26displayLink.md)
- [浅谈 NSTimer 是否精确？](https://www.jianshu.com/p/9e598abe684e)

### UIKit

- [iOS 中的事件的产生和传递](resource/blogs/event_produce_pass.md)
- [如何手动实现一个 UIScrollView](https://www.jianshu.com/p/f723336e49bb)
- [App 的生命周期](https://www.jianshu.com/p/6cf83e94c14c)
- [谈谈 Autolayout](https://www.jianshu.com/p/2056743a0090)
- [浅谈 iOS AutoLayout 中 Label 的抗拉伸和抗压缩](https://www.jianshu.com/p/8e68b82b471a)
- [iOS 开发中如何禁用第三方输入法](resource/blogs/keyboard.md)

### 网络

- [浅谈如何在项目中处理页面中的多个网络请求](https://www.jianshu.com/p/5c4b8b6aa44f)
- [HTTPS 之原理](https://www.jianshu.com/p/257634f46049)
- [HTTPS 之对称加密与非对称加密](https://www.jianshu.com/p/0e9e879cf75c)

### 工程与工具链

- [iOS 编译过程](https://www.jianshu.com/p/fda47fdc94de)
- [iOS 如何使用 TestFlight 进行 App Beta 版测试](https://www.jianshu.com/p/684e4b56b99a)
- [CocoaPods 的安装与使用](https://sunjinshuai.github.io/2016/08/08/CocoaPods%E7%9A%84%E5%AE%89%E8%A3%85%E4%B8%8E%E4%BD%BF%E7%94%A8/)
- [iOS 之创建 CocoaPods 公有库教程](https://www.jianshu.com/p/c852ab73ffa0)
- [iOS 之创建 CocoaPods 公有库采坑记](https://juejin.im/post/5a35f587f265da43294e2066)
- [浅谈第三方 SDK 和自定义 crash 上报冲突问题](https://www.jianshu.com/p/a1d02e2a9048)

## 设计原则

- [浅谈面向对象的六大设计原则](resource/blogs/design_principles.md) · [简书发布版本](https://www.jianshu.com/p/7b4633ada135)

## 算法

- [冒泡排序](https://github.com/sunjinshuai/Play-Leetcode/tree/master/Algorithm-Sort/BubbleSort)
- [选择排序](https://github.com/sunjinshuai/Play-Leetcode/tree/master/Algorithm-Sort/SelectionSort)
- [插入排序](https://github.com/sunjinshuai/Play-Leetcode/tree/master/Algorithm-Sort/InsertionSort)
- [快速排序](https://github.com/sunjinshuai/Play-Leetcode/tree/master/Algorithm-Sort/QuickSort)
- [希尔排序](https://github.com/sunjinshuai/Play-Leetcode/tree/master/Algorithm-Sort/ShellSort)
- [归并排序](https://github.com/sunjinshuai/Play-Leetcode/tree/master/Algorithm-Sort/MergeSort)
- [桶排序](https://github.com/sunjinshuai/Play-Leetcode/tree/master/Algorithm-Sort/BucketSort)
- [基数排序](https://github.com/sunjinshuai/Play-Leetcode/tree/master/Algorithm-Sort/RadixSort)

## Mac 与工具

- [Mac 安装软件提示软件已损坏解决办法](https://www.jianshu.com/p/c594c3d1167c)
- [Charles 之 http、https 配置](https://www.jianshu.com/p/e6dd256de239)
- [神器 iTools 的巧妙使用](https://www.jianshu.com/p/055abed45d12)
- [Mac iterm2 配色方案](https://www.jianshu.com/p/157ae1a4acaf)
- [Mac 上更新 Ruby](https://www.jianshu.com/p/d99b5662d8a0)
- [CornerStone 的使用](https://www.jianshu.com/p/7f5c019c528b)
- [Markdown 语法](https://github.com/iOS-Advanced/iOS-Advanced/wiki/MarkDown-%E8%AF%AD%E6%B3%95)

## 示例代码

示例工程保存在 [sourcecode](sourcecode/) 目录。按主题选择源码；包含工作区的示例可从对应 `.xcworkspace` 查看工程。

<details>
<summary>展开源码分组（27 个）</summary>


### Objective-C 与对象机制

- [CopyDemo](sourcecode/CopyDemo/)
- [ImplementKVO](sourcecode/ImplementKVO/)
- [KVCDemo](sourcecode/KVCDemo/)
- [Load & Initialize](sourcecode/Load%26Initialize/)
- [NSNotificationTheory](sourcecode/NSNotificationTheory/)
- [ObjectModel](sourcecode/ObjectModel/)
- [RunTime](sourcecode/RunTime/)
- [Singleton](sourcecode/Singleton/)
- [TaggedPointer](sourcecode/TaggedPointer/)
- [WeakRefArray](sourcecode/WeakRefArray/)
- [`__attribute__`](sourcecode/__attribute__/)

### UIKit 与布局

- [AddressBook](sourcecode/AddressBook/)
- [Label 布局](sourcecode/Label%26Compress%26Hugging/)
- [MYPushPopTransition](sourcecode/MYPushPopTransition/)
- [MasonryDemo](sourcecode/MasonryDemo/)
- [ScrollViewPopGesture](sourcecode/ScrollViewPopGesture/)
- [ScrollViewTheory](sourcecode/ScrollViewTheory/)
- [SudokuDemo](sourcecode/SudokuDemo/)
- [TouchEventTest](sourcecode/TouchEventTest/)
- [滚动隐藏导航栏](sourcecode/iOS%20UIScrollView%E4%B8%8A%E6%BB%91%E9%9A%90%E8%97%8FUINavigationBar/)

### RunLoop、定时器与多线程

- [NSTimer & CADisplayLink](sourcecode/NSTimer%26CADisplayLink/)
- [Runloop](sourcecode/Runloop/)
- [Thread（GCD / NSOperation）](sourcecode/Thread/)
- [ThreadSafetyArray](sourcecode/ThreadSafetyArray/)

### 设计原则、算法与网络

- [DesignPatterns](sourcecode/DesignPatterns/)
- [ArithmeticDemo](sourcecode/ArithmeticDemo/)
- [网络类型识别](sourcecode/iOS%E7%BD%91%E7%BB%9C%E5%8C%BA%E5%88%862%E3%80%813%E3%80%814G/)

</details>

示例写于不同的 iOS / Xcode 版本，运行前请结合自己的环境检查工程设置与依赖。

## 关于

[微博](https://weibo.com/u/5113807465) · [掘金](https://juejin.im/user/59c4495ef265da065b66b2a8) · [简书](https://www.jianshu.com/u/16d7ec797c31)

发现错误或有补充内容，欢迎提交 Issue 或 PR。感谢你的阅读与 Star。
