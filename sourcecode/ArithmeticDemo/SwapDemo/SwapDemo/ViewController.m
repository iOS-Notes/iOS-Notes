//
//  ViewController.m
//  SwapDemo
//
//  Created by QMMac on 2018/9/17.
//  Copyright © 2018 QMMac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger a = 10;
    NSInteger b = 15;
    
    [self swapA:a b:b];
}

- (void)swapA:(NSInteger)a b:(NSInteger)b {
    
    a = a ^ b;
    b = a ^ b;
    a = a ^ b;
    
    NSLog(@"A:%ld--- B:%ld", a, b);
}


@end
