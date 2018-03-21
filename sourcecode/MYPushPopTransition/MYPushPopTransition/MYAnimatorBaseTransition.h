//
//  MYAnimatorBaseTransition.h
//  MYPushPopTransition
//
//  Created by sunjinshuai on 2018/3/21.
//  Copyright © 2018年 MYPushPopTransition. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AnimatorTransitionType) {
    kAnimatorTransitionTypePresent = 0,
    kAnimatorTransitionTypeDismiss,
    kAnimatorTransitionTypePush,
    kAnimatorTransitionTypePop,
};

@interface MYAnimatorBaseTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, assign) AnimatorTransitionType animatorTransitionType;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIViewController *from;
@property (nonatomic, strong) UIViewController *to;
@property (nonatomic, strong) UIView *fromView;
@property (nonatomic, strong) UIView *toView;

@end
