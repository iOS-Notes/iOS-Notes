//
//  UIViewController+CustomNavigationBar.m
//  MYPushPopTransition
//
//  Created by QMMac on 2018/4/23.
//  Copyright © 2018年 MYPushPopTransition. All rights reserved.
//

#import "UIViewController+CustomNavigationBar.h"
#import "MYNavigationController.h"
#import <objc/runtime.h>

@implementation UIViewController (CustomNavigationBar)

- (UIBarStyle)barStyle {
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return [obj integerValue];
    }
    return [UINavigationBar appearance].barStyle;
}

- (void)setBarStyle:(UIBarStyle)barStyle {
    objc_setAssociatedObject(self, @selector(barStyle), @(barStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)barTintColor {
    if (self.barHidden) {
        return UIColor.clearColor;
    }
    
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }
    
    if ([UINavigationBar appearance].barTintColor) {
        return [UINavigationBar appearance].barTintColor;
    }
    return [UINavigationBar appearance].barStyle == UIBarStyleDefault ? [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:0.8]: [UIColor colorWithRed:28/255.0 green:28/255.0 blue:28/255.0 alpha:0.729];
}

- (void)setBarTintColor:(UIColor *)barTintColor {
    objc_setAssociatedObject(self, @selector(barTintColor), barTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (float)barAlpha {
    id obj = objc_getAssociatedObject(self, _cmd);
    if (self.barHidden) {
        return 0;
    }
    return obj ? [obj floatValue] : 1.0f;
}

- (void)setBarAlpha:(float)barAlpha {
    objc_setAssociatedObject(self, @selector(barAlpha), @(barAlpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)barHidden {
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj ? [obj boolValue] : NO;
}

- (void)setBarHidden:(BOOL)barHidden {
    if (barHidden) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
        self.navigationItem.titleView = [UIView new];
    } else {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.titleView = nil;
    }
    objc_setAssociatedObject(self, @selector(barHidden), @(barHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (float)barShadowAlpha {
    return  self.barShadowHidden ? 0 : self.barAlpha;
}

- (BOOL)barShadowHidden {
    id obj = objc_getAssociatedObject(self, _cmd);
    return  self.barHidden || obj ? [obj boolValue] : NO;
}

- (void)setBarShadowHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, @selector(barShadowHidden), @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)backInteractive {
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj ? [obj boolValue] : YES;
}

- (void)setBackInteractive:(BOOL)interactive {
    objc_setAssociatedObject(self, @selector(backInteractive), @(interactive), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setNeedsUpdateNavigationBar {
    if (self.navigationController && [self.navigationController isKindOfClass:[MYNavigationController class]]) {
        MYNavigationController *nav = (MYNavigationController *)self.navigationController;
        [nav updateNavigationBarForController:self];
    }
}

- (void)setNeedsUpdateNavigationBarAlpha {
    if (self.navigationController && [self.navigationController isKindOfClass:[MYNavigationController class]]) {
        MYNavigationController *nav = (MYNavigationController *)self.navigationController;
        [nav updateNavigationBarAlphaForViewController:self];
    }
}

- (void)setNeedsUpdateNavigationBarColor {
    if (self.navigationController && [self.navigationController isKindOfClass:[MYNavigationController class]]) {
        MYNavigationController *nav = (MYNavigationController *)self.navigationController;
        [nav updateNavigationBarColorForViewController:self];
    }
}

- (void)setNeedsUpdateNavigationBarShadowImageAlpha {
    if (self.navigationController && [self.navigationController isKindOfClass:[MYNavigationController class]]) {
        MYNavigationController *nav = (MYNavigationController *)self.navigationController;
        [nav updateNavigationBarShadowImageAlphaForViewController:self];
    }
}

@end
