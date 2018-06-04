//
//  ViewController.m
//  iOSSkills
//
//  Created by QMMac on 2018/6/4.
//  Copyright © 2018年 QMMac. All rights reserved.
//

#import "ViewController.h"

#define TICK   NSDate *startTime = [NSDate date];
#define TOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow]);

@interface ViewController ()

@end

@implementation ViewController

NSInteger sortByID (id obj1, id obj2, void *context) {
    
    NSNumber *number1 = (NSNumber *)obj1;
    NSNumber *number2 = (NSNumber *)obj2;
    
    return [number1 compare:number2];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *numbers = @[@9, @5, @11, @3, @1];
    
    /// selector
    /// 2018-06-04 11:22:47.557443+0800 iOSSkills[16806:108705] Time: 0.000013
    NSArray *sortedArray1 = [numbers sortedArrayUsingSelector:@selector(compare:)];
    
    /// 使用函数指针sortedArrayUsingFunction
    /// 2018-06-04 11:22:47.557443+0800 iOSSkills[16806:108705] Time: 0.000014
    NSArray *sortedArray2 = [numbers sortedArrayUsingFunction:sortByID context:nil];
    
    /// 基于block的排序方法
    /// 2018-06-04 11:27:20.351388+0800 iOSSkills[16954:114040] Time: 0.000010
    NSArray *sortedArray3 = [numbers sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    NSLog(@"%@",sortedArray3);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
