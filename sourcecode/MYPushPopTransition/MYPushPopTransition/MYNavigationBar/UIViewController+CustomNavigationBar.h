//
//  UIViewController+CustomNavigationBar.h
//  MYPushPopTransition
//
//  Created by QMMac on 2018/4/23.
//  Copyright © 2018年 MYPushPopTransition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CustomNavigationBar)

@property (nonatomic, assign) UIBarStyle barStyle;
@property (nonatomic, strong) UIColor *barTintColor;
@property (nonatomic, assign) float barAlpha;
@property (nonatomic, assign) BOOL barHidden;
@property (nonatomic, assign, readonly) float barShadowAlpha;
@property (nonatomic, assign) BOOL barShadowHidden;
@property (nonatomic, assign) BOOL backInteractive;

- (void)setNeedsUpdateNavigationBar;
- (void)setNeedsUpdateNavigationBarAlpha;
- (void)setNeedsUpdateNavigationBarColor;
- (void)setNeedsUpdateNavigationBarShadowImageAlpha;

@end
