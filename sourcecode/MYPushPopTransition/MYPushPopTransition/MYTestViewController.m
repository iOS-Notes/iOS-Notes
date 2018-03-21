//
//  MYTestViewController.m
//  MYPushPopTransition
//
//  Created by sunjinshuai on 2018/3/21.
//  Copyright © 2018年 MYPushPopTransition. All rights reserved.
//

#import "MYTestViewController.h"

@interface MYTestViewController ()

@end

@implementation MYTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", (long)_imageIndex]];
    [self.view addSubview:imageView];
    
    imageView.center = self.view.center;
}

@end
