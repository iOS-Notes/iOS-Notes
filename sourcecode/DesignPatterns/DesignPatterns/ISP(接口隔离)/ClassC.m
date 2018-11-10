//
//  ClassC.m
//  DesignPatterns
//
//  Created by michael on 2018/11/10.
//  Copyright © 2018 michael. All rights reserved.
//

#import "ClassC.h"

@implementation ClassC

- (void)depend:(NSObject<InterfaceH> *)classD {
    
    if ([classD respondsToSelector:@selector(method3)]) {
        [classD method3];
    }
    if ([classD respondsToSelector:@selector(method4)]) {
        [classD method4];
    }
    if ([classD respondsToSelector:@selector(method5)]) {
        [classD method5];
    }
}

@end
