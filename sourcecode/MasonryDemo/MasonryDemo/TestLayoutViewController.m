//
//  TestLayoutViewController.m
//  MasonryDemo
//
//  Created by QMMac on 2018/6/8.
//  Copyright © 2018 QMMac. All rights reserved.
//

#import "TestLayoutViewController.h"
#import "TestLayoutView.h"
#import "TestLayoutView1.h"
#import <Masonry.h>

@interface TestLayoutViewController ()

@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) TestLayoutView1 *layoutView;

@end

@implementation TestLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.layoutView = [[TestLayoutView1 alloc] init];
    [self.view addSubview:self.layoutView];
    [self.layoutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
//    [self testLayout];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    NSLog(@"self.view 的尺寸%@，redView 的尺寸%@",self.view,self.redView);
}

- (void)testLayout {
    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    self.redView = redView;
    
    // 设置约束
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(150, 80));
    }];
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"self.view 的尺寸%@，redView 的尺寸%@",self.view,redView);
    });
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
//    NSLog(@"self.view 的尺寸%@，redView 的尺寸%@",self.view,self.redView);
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
}

@end
