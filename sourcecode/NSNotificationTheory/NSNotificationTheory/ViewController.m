//
//  ViewController.m
//  NSNotificationTheory
//
//  Created by sunjinshuai on 2017/11/29.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "ViewController.h"
#import "MYTestNotificationViewController.h"
#import "MYTestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TESTNOTIFICATION" object:nil];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(self.view.center.x - 50, self.view.center.y, 100, 50);
    [button addTarget:self action:@selector(tapPushButton) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
}

- (void)tapPushButton {
    MYTestViewController *testNotification = [[MYTestViewController alloc] init];
    [self.navigationController pushViewController:testNotification animated:YES];
}

@end
