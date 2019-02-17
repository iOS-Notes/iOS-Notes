//
//  ViewController+GetSelf.m
//  CategoryDemo
//
//  Created by sunjinshuai on 2019/2/17.
//  Copyright © 2019年 sunjinshuai. All rights reserved.
//

#import "ViewController+GetSelf.h"
#import "CategoryManager.h"

@implementation ViewController (GetSelf)

- (void)test {
    NSLog(@"ViewController category (GetSelf)");
    [[CategoryManager shared] invokeOriginalMethod:self selector:_cmd];
}

@end
