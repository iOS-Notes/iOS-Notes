//
//  Parent.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/16.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "Parent.h"

@implementation Parent

//+ (void)load {
//    NSLog(@"%@ , %s", [self class], __FUNCTION__);
//}

+ (void)initialize {
    if (self == [Parent class]) {
        NSLog(@"Initialize %@ , %s", [self class], __FUNCTION__);
    }
}

@end
