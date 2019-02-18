//
//  ViewController.m
//  CategoryDemo
//
//  Created by sunjinshuai on 2019/2/17.
//  Copyright © 2019年 sunjinshuai. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+Attribute.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test];
    
    self.name = @"ViewController+Attribute";
    NSLog(@"%@", self.name);
}

- (void)test {
    NSLog(@"ViewController");
}

@end
