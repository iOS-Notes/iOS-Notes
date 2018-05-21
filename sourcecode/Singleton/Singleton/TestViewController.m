//
//  TestViewController.m
//  Singleton
//
//  Created by sunjinshuai on 2018/5/21.
//  Copyright © 2018年 sunjinshuai. All rights reserved.
//

#import "TestViewController.h"
#import "MYSingleton.h"

@interface TestViewController ()

@property (nonatomic, strong) MYSingleton *singleton;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _singleton = [MYSingleton sharedInstance];
    
    [_singleton testSingleton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
