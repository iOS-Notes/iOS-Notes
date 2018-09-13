//
//  ViewController.m
//  AutoreleasePool
//
//  Created by QMMac on 2018/5/19.
//  Copyright © 2018年 QMMac. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

__weak id _testObject = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}


- (IBAction)pushToTestView:(UIButton *)sender {
    TestViewController *test = [[TestViewController alloc] init];
    [self.navigationController pushViewController:test animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
