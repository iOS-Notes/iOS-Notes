//
//  UINavigationController+PopGesture.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/21.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "UINavigationController+PopGesture.h"
#import "NSObject+AssociatedObject.h"
#import <objc/runtime.h>

@interface UINavigationController (PopGesturePrivate)

@property (nonatomic, weak, readonly) id my_naviDelegate;
@property (nonatomic, weak, readonly) id my_popDelegate;

@end

@implementation UINavigationController (PopGesture)

+ (void)load {
    Method originalMethod = class_getInstanceMethod(self, @selector(viewWillAppear:));
    Method swizzledMethod = class_getInstanceMethod(self, @selector(myPop_viewWillAppear:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)myPop_viewWillAppear:(BOOL)animated {
    [self myPop_viewWillAppear:animated];
    // 只是为了触发my_PopDelegate的get方法，获取到原始的interactivePopGestureRecognizer的delegate
    [self.my_popDelegate class];
    // 获取导航栏的代理
    [self.my_naviDelegate class];
    self.delegate = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.delegate = self.my_naviDelegate;
    });
}

- (id)my_popDelegate {
    id my_popDelegate = objc_getAssociatedObject(self, _cmd);
    if (!my_popDelegate) {
        my_popDelegate = self.interactivePopGestureRecognizer.delegate;
        objc_setAssociatedObject(self, _cmd, my_popDelegate, OBJC_ASSOCIATION_ASSIGN);
    }
    return my_popDelegate;
}

- (id)my_naviDelegate {
    id my_naviDelegate = objc_getAssociatedObject(self, _cmd);
    if (!my_naviDelegate) {
        my_naviDelegate = self.delegate;
        if (my_naviDelegate) {
            objc_setAssociatedObject(self, _cmd, my_naviDelegate, OBJC_ASSOCIATION_ASSIGN);
        }
    }
    return my_naviDelegate;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    if ([self.navigationController.transitionCoordinator isAnimated]) {
        return NO;
    }
    if (self.childViewControllers.count <= 1) {
        return NO;
    }
    UIViewController *vc = self.topViewController;
    if (vc.my_interactivePopDisabled) {
        return NO;
    }
    // 侧滑手势触发位置
    CGPoint location = [gestureRecognizer locationInView:self.view];
    CGPoint offSet = [gestureRecognizer translationInView:gestureRecognizer.view];
    BOOL ret = (0 < offSet.x && location.x <= 40);
    // NSLog(@"%@ %@",NSStringFromCGPoint(location),NSStringFromCGPoint(offSet));
    return ret;
}

/// 只有当系统侧滑手势失败了，才去触发ScrollView的滑动
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 转发给业务方代理
    if (self.my_naviDelegate && ![self.my_naviDelegate isEqual:self]) {
        if ([self.my_naviDelegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)]) {
            [self.my_naviDelegate navigationController:navigationController didShowViewController:viewController animated:animated];
        }
    }
    // 让系统的侧滑返回生效
    self.interactivePopGestureRecognizer.enabled = YES;
    if (self.childViewControllers.count > 0) {
        if (viewController == self.childViewControllers[0]) {
            self.interactivePopGestureRecognizer.delegate = self.my_popDelegate; // 不支持侧滑
        } else {
            self.interactivePopGestureRecognizer.delegate = nil; // 支持侧滑
        }
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 转发给业务方代理
    if (self.my_naviDelegate && ![self.my_naviDelegate isEqual:self]) {
        if ([self.my_naviDelegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)]) {
            [self.my_naviDelegate navigationController:navigationController willShowViewController:viewController animated:animated];
        }
    }
}

@end

@interface UIViewController (PopGesturePrivate)

@property (nonatomic, strong, readonly) UIPanGestureRecognizer *my_popGestureRecognizer;

@end

@implementation UIViewController (PopGesture)

- (void)my_addPopGestureToView:(UIView *)view {
    if (!view) return;
    if (!self.navigationController) {
        // 在控制器转场的时候，self.navigationController可能是nil,这里用GCD和递归来处理这种情况
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self my_addPopGestureToView:view];
        });
    } else {
        UIPanGestureRecognizer *pan = self.my_popGestureRecognizer;
        if (![view.gestureRecognizers containsObject:pan]) {
            [view addGestureRecognizer:pan];
        }
    }
}

- (UIPanGestureRecognizer *)my_popGestureRecognizer {
    UIPanGestureRecognizer *pan = objc_getAssociatedObject(self, _cmd);
    if (!pan) {
        // 侧滑返回手势 手势触发的时候，让target执行action
        id target = self.navigationController.my_popDelegate;
        SEL action = NSSelectorFromString(@"handleNavigationTransition:");
        pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
        pan.maximumNumberOfTouches = 1;
        pan.delegate = self.navigationController;
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        objc_setAssociatedObject(self, _cmd, pan, OBJC_ASSOCIATION_ASSIGN);
    }
    return pan;
}

- (BOOL)my_interactivePopDisabled {
    return ((NSNumber *)[self object:@selector(setMy_interactivePopDisabled:)]).boolValue;
}

- (void)setMy_interactivePopDisabled:(BOOL)my_interactivePopDisabled {
    [self setRetainNonatomicObject:@(my_interactivePopDisabled) withKey:@selector(setMy_interactivePopDisabled:)];
}

@end
