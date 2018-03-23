//
//  UINavigationController+PopGesture.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/21.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (PopGesture)<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@interface UIViewController (PopGesture)

/// 给view添加侧滑返回效果
- (void)my_addPopGestureToView:(UIView *)view;

/// 禁止该页面的侧滑返回
@property (nonatomic, assign) BOOL my_interactivePopDisabled;

@end
