//
//  TestClass+Exchange.m
//  MYSampleCode
//
//  Created by sunjinshuai on 2017/11/23.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "TestClass+Exchange.h"
#import "Runtime.h"

@implementation TestClass (Exchange)

- (void)exchangeMethod {
    
    [Runtime methodSwap:[self class] firstMethod:@selector(method1) secondMethod:@selector(method2)];
}

- (void)method2 {
    // 下方调用的实际上是method1的实现
    [self method2];
    NSLog(@"可以在Method1的基础上添加各种东西了");
}

@end
