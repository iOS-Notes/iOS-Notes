iOS 开发中如何禁用第三方输入法

iOS 目前已允许使用第三方输入法，但在实际开发中，无论是出于安全的考虑，还是对某个输入控件限制输入法，都有禁用第三方输入法的需求。基于此，对禁用第三方输入法的方式做一个总结。
### 全局禁用

Objective-C 语言版本：
```
- (BOOL)application:(UIApplication *)application
  shouldAllowExtensionPointIdentifier:(UIApplicationExtensionPointIdentifier)extensionPointIdentifier
{
  // 禁用三方输入法
  // UIApplicationKeyboardExtensionPointIdentifier 等价于 @"com.apple.keyboard-service"
  if ([extensionPointIdentifier isEqualToString:UIApplicationKeyboardExtensionPointIdentifier]) {
    return NO;
  }
  return YES;
}
```

Swift 语言版本：
```
func application(
  _ application: UIApplication,
  shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier
) -> Bool {
  // 禁用三方输入法
  if extensionPointIdentifier == .keyboard {
    return false
  }
  return true
}
```

### 针对某个视图禁用

```
func application(
  _ application: UIApplication, 
  shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier
) -> Bool {
  // 遍历当前根控制器的所有子控制器，找到需要的子控制器
  for vc in self.window?.rootViewController?.childViewControllers ?? []
      where vc.isKind(of: BaseNavigationController.self)
  {
    // 如果首页禁止使用第三方输入法
    for vc1 in vc.childViewControllers where vc1.isKind(of: HomeViewController.self) {
      return false
    }
  }
  return true
}
```

### 针对某个 inputView 禁用

#### 自定义键盘
如果需求只是针对数字的输入，优先使用自定义键盘，将 inputView 绑定自定义键盘，不会出现第三方输入法。

#### 遍历视图内控件，找到需要设置的 inputView，专门设置
```
func application(
  _ application: UIApplication, 
  shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier
) -> Bool {
  // 遍历当前根控制器的所有子控制器，找到需要的子控制器
  for vc in self.window?.rootViewController?.childViewControllers ?? []
      where vc.isKind(of: BaseNavigationController.self)
  {
    // 如果想要禁用的 inputView 在首页上
    for vc1 in vc.childViewControllers where vc1.isKind(of: HomeViewController.self) {
      // 如果 inputView.tag == 6 的 inputView 禁止使用第三方输入法
      for view in vc1.view.subviews where view.tag == 6 {
        return false
      }
    }
  }
  return true
}
```
