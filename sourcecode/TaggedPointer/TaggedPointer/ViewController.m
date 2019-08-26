//
//  ViewController.m
//  TaggedPointer
//
//  Created by aikucun on 2019/8/26.
//  Copyright © 2019 aikucun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSNumber *number1 = @7;
    NSNumber *number2 = @111;
    NSNumber *number3 = @555;
    NSNumber *bigNumber = @(0xEFFFFFFFFFFFFFFF);

    NSLog(@"number1 Tagged Pointer is %p", number1);
    NSLog(@"number2 Tagged Pointer is %p", number2);
    NSLog(@"number3 Tagged Pointer is %p", number3);
    NSLog(@"bigNumber Tagged Pointer is %p", bigNumber);
}

@end
