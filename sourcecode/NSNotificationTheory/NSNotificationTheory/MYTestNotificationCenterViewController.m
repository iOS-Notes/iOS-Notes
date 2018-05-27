//
//  MYTestNotificationCenterViewController.m
//  NSNotificationTheory
//
//  Created by QMMac on 2018/5/27.
//  Copyright © 2018年 MYSampleCode. All rights reserved.
//

#import "MYTestNotificationCenterViewController.h"
#import "MYTestNotificationViewController.h"

@interface MYTestNotificationCenterViewController ()

@end

@implementation MYTestNotificationCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 往通知中心添加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:@"MyNAME"
                                               object:nil];
    
    NSLog(@"register notifcation thread = %@", [NSThread currentThread]);
    
    // 创建子线程，在子线程中发送通知
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"post notification thread = %@", [NSThread currentThread]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MyNAME" object:nil userInfo:nil];
    });
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(self.view.center.x - 50, self.view.center.y, 100, 50);
    [button addTarget:self action:@selector(tapPushButton) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    [self.view addSubview:button];
}

/**
 处理通知的方法
 
 @param notification notification
 */
- (void)handleNotification:(NSNotification *)notification {
    //打印处理通知方法的线程
    NSLog(@"handle notification thread = %@", [NSThread currentThread]);
}

- (void)tapPushButton {
    MYTestNotificationViewController *testNotification = [[MYTestNotificationViewController alloc] init];
    [self.navigationController pushViewController:testNotification animated:YES];
}

@end
