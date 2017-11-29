//
//  ViewController.m
//  Load&Initialize
//
//  Created by sunjinshuai on 2017/11/28.
//  Copyright © 2017年 sunjinshuai. All rights reserved.
//

#import "ViewController.h"
#import "Child.h"
#import "Parent.h"
#import "Other.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __unused Child *child = [[Child alloc] init];
    __unused Parent *parent = [[Parent alloc] init];
    __unused Other *other = [[Other alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
