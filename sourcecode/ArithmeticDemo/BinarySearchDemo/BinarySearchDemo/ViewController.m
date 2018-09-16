//
//  ViewController.m
//  ArithmeticDemo
//
//  Created by QMMac on 2018/8/21.
//  Copyright © 2018 QMMac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 二分查找 又称折半查找，要求数组必须是有序的数列，是一种有序查找算法
    NSArray *tempArray = @[@5, @8, @9, @10, @19, @23, @25, @30];
    
    NSLog(@"二分法查找%lu", (unsigned long)[self binarySearch:tempArray number:@(9)]);
}

- (NSUInteger)binarySearch:(NSArray<NSNumber *> *)srcArray number:(NSNumber *)des {
    NSUInteger low = 0;
    NSUInteger high = srcArray.count - 1;
    NSInteger middle = 0;
    while (low <= high && low <= srcArray.count - 1 && high <= srcArray.count - 1) {
        middle = (low + high) >> 1;
        // 或者
        // middle = ((high - low) >> 1) + low;
        if ([des integerValue] == [srcArray[middle] integerValue]) {
            return middle;
        } else if ([des integerValue] < [srcArray[middle] integerValue]) {
            high = middle - 1;
        } else {
            low = middle + 1;
        }
    }
    return -1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
