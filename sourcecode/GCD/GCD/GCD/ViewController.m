//
//  ViewController.m
//  GCD
//
//  Created by sunjinshuai on 2017/12/6.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_queue_t queue = dispatch_queue_create("com.my.wangruih", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        
            NSLog(@"A");
        
    });
    
    dispatch_async(queue, ^{
        
            NSLog(@"B");
        
    });
    
    dispatch_barrier_async(queue, ^{
        
            NSLog(@"C");
        
    });
    
    dispatch_async(queue, ^{
        
            NSLog(@"D");
        
    });
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
