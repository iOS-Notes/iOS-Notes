//
//  MYNavigationController.h
//  MYPushPopTransition
//
//  Created by QMMac on 2018/4/23.
//  Copyright © 2018年 MYPushPopTransition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYNavigationController : UINavigationController

- (void)updateNavigationBarForController:(UIViewController *)vc;
- (void)updateNavigationBarAlphaForViewController:(UIViewController *)vc;
- (void)updateNavigationBarColorForViewController:(UIViewController *)vc;
- (void)updateNavigationBarShadowImageAlphaForViewController:(UIViewController *)vc;

@end
