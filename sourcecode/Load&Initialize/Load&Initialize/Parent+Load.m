//
//  Parent+Load.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/16.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "Parent+Load.h"

@implementation Parent (Load)

//+ (void)load {
//    NSLog(@"%@ , %s", [self class], __FUNCTION__);
//}

+ (void)initialize {
    if (self == [Parent class]) {
        NSLog(@"Initialize %@ , %s", [self class], __FUNCTION__);
    }
}

@end
