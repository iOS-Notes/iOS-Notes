//
//  ViewController.m
//  CopyDemo
//
//  Created by michael on 2019/2/18.
//  Copyright © 2019 michael. All rights reserved.
//

#import "ViewController.h"
#import "Test.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test1];
}

- (void)test1 {
    
    Test *test1 = [[Test alloc] init];
    NSMutableString *mutableStr = [NSMutableString stringWithFormat:@"iOS"];
    test1.strongString = mutableStr;
    NSLog(@"%@", test1.strongString);
    [mutableStr appendString:@" test copy"];
    NSLog(@"%@", test1.strongString);
}

@end
