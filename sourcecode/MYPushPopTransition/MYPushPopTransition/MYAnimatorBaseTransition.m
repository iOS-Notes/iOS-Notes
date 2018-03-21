//
//  MYAnimatorBaseTransition.m
//  MYPushPopTransition
//
//  Created by sunjinshuai on 2018/3/21.
//  Copyright © 2018年 MYPushPopTransition. All rights reserved.
//

#import "MYAnimatorBaseTransition.h"

@implementation MYAnimatorBaseTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5f;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    _transitionContext = transitionContext;
    
    _containerView = [transitionContext containerView];
    
    _from = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    _to = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // iOS8之后才有
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        _fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        _toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        _fromView = _from.view;
        _toView = _to.view;
    }
    
    if (self.animatorTransitionType == kAnimatorTransitionTypePresent) {
        [self animationPresent];
    } else if (self.animatorTransitionType == kAnimatorTransitionTypeDismiss) {
        [self animationDismiss];
    } else if (self.animatorTransitionType == kAnimatorTransitionTypePush) {
        [self animationPush];
    } else if (self.animatorTransitionType == kAnimatorTransitionTypePop) {
        [self animationPop];
    }
}

- (void)animationPresent {
    
}

- (void)animationDismiss {
    
}

- (void)animationPush {
    
}

- (void)animationPop {
    
}

// This is a convenience and if implemented will be invoked by the system when the transition context's completeTransition: method is invoked.
- (void)animationEnded:(BOOL) transitionCompleted {
    
}

@end
