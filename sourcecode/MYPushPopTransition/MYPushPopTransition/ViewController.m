//
//  ViewController.m
//  MYPushPopTransition
//
//  Created by sunjinshuai on 2018/3/21.
//  Copyright © 2018年 MYPushPopTransition. All rights reserved.
//

#import "ViewController.h"
#import "MYDemoCollectionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 100)/2, 200, 100, 50);
    [button setTitle:@"小红书转场" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick {
    
    MYDemoCollectionViewController *demoVC = [[MYDemoCollectionViewController alloc] init];
    [self.navigationController pushViewController:demoVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
