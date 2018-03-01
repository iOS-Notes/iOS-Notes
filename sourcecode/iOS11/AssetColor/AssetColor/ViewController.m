//
//  ViewController.m
//  AssetColor
//
//  Created by sunjinshuai on 2018/3/1.
//  Copyright © 2018年 AssetColor. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *assetColorView = [[UIView alloc] init];
    assetColorView.frame = CGRectMake((self.view.bounds.size.width - 100)/2, (self.view.bounds.size.height - 100)/2, 100, 100);
    
    assetColorView.backgroundColor = [UIColor colorNamed:@"otherColor"];
    [self.view addSubview:assetColorView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
