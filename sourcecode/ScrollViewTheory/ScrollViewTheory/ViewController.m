//
//  ViewController.m
//  ScrollViewTheory
//
//  Created by sunjinshuai on 2017/11/29.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "ViewController.h"
#import "MYScrollView.h"

@interface ViewController ()

@property (nonatomic, strong) MYScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[MYScrollView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    self.scrollView.scrollHorizontal = NO;
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(150, 160, 150, 200)];
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(40, 400, 200, 150)];
    UIView *yellowView = [[UIView alloc] initWithFrame:CGRectMake(100, 600, 180, 150)];
    
    redView.backgroundColor = [UIColor colorWithRed:0.815 green:0.007 blue:0.105 alpha:1];
    greenView.backgroundColor = [UIColor colorWithRed:0.494 green:0.827 blue:0.129 alpha:1];
    blueView.backgroundColor = [UIColor colorWithRed:0.29 green:0.564 blue:0.886 alpha:1];
    yellowView.backgroundColor = [UIColor colorWithRed:0.972 green:0.905 blue:0.109 alpha:1];
    
    [self.scrollView addSubview:redView];
    [self.scrollView addSubview:greenView];
    [self.scrollView addSubview:blueView];
    [self.scrollView addSubview:yellowView];
    
    UIView *redView1 = [[UIView alloc] initWithFrame:CGRectMake(20, 500 + 20, 100, 100)];
    UIView *greenView1 = [[UIView alloc] initWithFrame:CGRectMake(150, 500 + 160, 150, 200)];
    UIView *blueView1 = [[UIView alloc] initWithFrame:CGRectMake(40, 500 + 400, 200, 150)];
    UIView *yellowView1 = [[UIView alloc] initWithFrame:CGRectMake(100, 500 + 600, 180, 150)];
    
    redView1.backgroundColor = [UIColor purpleColor];
    greenView1.backgroundColor = [UIColor redColor];
    blueView1.backgroundColor = [UIColor grayColor];
    yellowView1.backgroundColor = [UIColor blackColor];
    
    [self.scrollView addSubview:redView1];
    [self.scrollView addSubview:greenView1];
    [self.scrollView addSubview:blueView1];
    [self.scrollView addSubview:yellowView1];
    
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, CGRectGetMaxY(yellowView1.frame));
    [self.view addSubview:self.scrollView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
