//
//  ClassA.m
//  DesignPatterns
//
//  Created by michael on 2018/11/10.
//  Copyright © 2018 michael. All rights reserved.
//

#import "ClassA.h"

@implementation ClassA

- (void)depend:(NSObject<InterfaceH> *)classB {
    
    if ([classB respondsToSelector:@selector(method1)]) {
        [classB method1];
    }
    if ([classB respondsToSelector:@selector(method2)]) {
        [classB method2];
    }
}

@end
