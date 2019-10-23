//
//  ViewController.m
//  GCD
//
//  Created by sunjinshuai on 2017/12/6.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "ViewController.h"
#import "MYGCDSemaphore.h"
#import "MYGCDGroup.h"
#import "MYGCDApply.h"
#import "MYGCD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testGCD];
}

- (void)testSemaphore {
    MYGCDSemaphore *gcdSemaphore = [MYGCDSemaphore new];
    [gcdSemaphore testSemaphore];
}

- (void)testGCDGroup {
    MYGCDGroup *gcdGroup = [MYGCDGroup new];
    [gcdGroup testGCDGroup2];
}

- (void)testApply {
    MYGCDApply *gcdApply = [[MYGCDApply alloc] init];
    [gcdApply testGCDApply];
}

- (void)testGCD {
    MYGCD *gcd = [MYGCD new];
    [gcd dispatch_barrier_async];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
