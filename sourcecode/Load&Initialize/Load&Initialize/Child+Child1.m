//
//  Child+Child1.m
//  Load&Initialize
//
//  Created by sunjinshuai on 2017/11/28.
//  Copyright © 2017年 sunjinshuai. All rights reserved.
//

#import "Child+Child1.h"

@implementation Child (Child1)

//+ (void)load {
//    NSLog(@"%@ , %s", [self class], __FUNCTION__);
//}

+ (void)initialize {
    NSLog(@"%@ , %s", [self class], __FUNCTION__);
}

@end
