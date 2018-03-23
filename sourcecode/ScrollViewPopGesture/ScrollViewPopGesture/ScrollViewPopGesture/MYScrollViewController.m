//
//  MYScrollViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/21.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYScrollViewController.h"
#import "UINavigationController+PopGesture.h"

@interface MYScrollViewController ()
@end

@implementation MYScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configScrollView];
}

- (void)configScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(1000, 0);
    scrollView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:scrollView];
    
    // scrollView需要支持侧滑返回
    [self my_addPopGestureToView:scrollView];
    
    // 禁止该页面侧滑返回
     self.my_interactivePopDisabled = YES;
}

@end
