//
//  ViewController.m
//  ThreadSafetyArray
//
//  Created by sunjinshuai on 2017/12/29.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "ViewController.h"
#import "ThreadSafetyArray.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ThreadSafetyArray *ary = [[ThreadSafetyArray alloc] init];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 10;
    for (int i = 0; i < 200; i++) {
        NSNumber *number = [NSNumber numberWithInt:i];
        [queue addOperationWithBlock:^{
            [ary addObject:number];
        }];
    }
    [queue waitUntilAllOperationsAreFinished];
    NSLog(@"%lu",(unsigned long)ary.count);
    NSLog(@"%@",ary);   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
