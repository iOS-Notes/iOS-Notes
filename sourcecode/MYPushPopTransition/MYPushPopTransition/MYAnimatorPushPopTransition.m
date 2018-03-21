//
//  MYAnimatorPushPopTransition.m
//  MYPushPopTransition
//
//  Created by sunjinshuai on 2018/3/21.
//  Copyright © 2018年 MYPushPopTransition. All rights reserved.
//

#import "MYAnimatorPushPopTransition.h"

@implementation MYAnimatorPushPopTransition

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    [super animateTransition:transitionContext];
}

- (void)animationPush {
    self.containerView.backgroundColor = self.toView.backgroundColor;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
    imageView.image = [UIImage imageNamed:_imageName];
    [self.containerView addSubview:imageView];
    imageView.center = _itemCenter;
    
    CGFloat initialScale = _itemSize.width / CGRectGetWidth(imageView.frame);
    imageView.transform = CGAffineTransformMakeScale(initialScale, initialScale);
    
    NSLog(@"y : %f", imageView.center.y);
    
    // toView在UIImageView到达最终位置，动画完成之后再显示出来
    self.toView.frame = [self.transitionContext finalFrameForViewController:self.to];
    [self.containerView addSubview:self.toView];
    CGPoint toViewFinalCenter = self.toView.center;
    self.toView.center = toViewFinalCenter;
    self.toView.alpha = 0.0f;
    
    
    NSTimeInterval duration = [self transitionDuration:self.transitionContext];
    typeof (&*self) __weak weakSelf = self;
    
    [UIView animateWithDuration:duration animations:^{
        imageView.transform = CGAffineTransformIdentity;
        imageView.center = toViewFinalCenter;
        
        self.fromView.alpha = 0.0f; // fromView 渐隐
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
        
        weakSelf.toView.alpha = 1.0f;
        weakSelf.fromView.alpha = 1.0f;
        
        [weakSelf.transitionContext completeTransition:![weakSelf.transitionContext transitionWasCancelled]];
    }];
}

- (void)animationPop {
    self.toView.frame = [self.transitionContext finalFrameForViewController:self.to];
    [self.containerView insertSubview:self.toView belowSubview:self.fromView];
    
    self.toView.alpha = 0.0f;
    
    self.fromView.backgroundColor = [UIColor clearColor];
    
    NSTimeInterval duration = [self transitionDuration:self.transitionContext];
    typeof (&*self) __weak weakSelf = self;
    
    
    [UIView animateWithDuration:duration animations:^{
        CGFloat initialScale = _itemSize.width / 200;
        weakSelf.fromView.transform = CGAffineTransformMakeScale(initialScale, initialScale);
        weakSelf.fromView.center = weakSelf.itemCenter;
        
        weakSelf.toView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        weakSelf.fromView.alpha = 0.0f;
        
        [weakSelf.transitionContext completeTransition:![weakSelf.transitionContext transitionWasCancelled]];
    }];
}

- (void)animationEnded:(BOOL) transitionCompleted {
    NSLog(@"%s", __func__);
}

@end
