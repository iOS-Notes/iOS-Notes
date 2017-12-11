//
//  Cat.m
//  RunTime
//
//  Created by sunjinshuai on 2017/12/11.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "Cat.h"

@implementation Cat

- (void)run {
    NSLog(@"%@ %s", self, sel_getName(_cmd));
}

@end
