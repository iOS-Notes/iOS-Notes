//
//  MYTestViewController.m
//  NSNotificationTheory
//
//  Created by QMMac on 2018/5/27.
//  Copyright © 2018年 MYSampleCode. All rights reserved.
//

#import "MYTestViewController.h"
#import "MYNotificationCenter.h"

@interface MYTestViewController ()

@end

@implementation MYTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[MYNotificationCenter defaultCenter] addObserver:self selector:@selector(testNotification) name:@"" object:nil];
}

- (void)testNotification {
    
    NSLog(@"testNotification");
}

@end
