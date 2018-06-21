//
//  Message.m
//  ImplementKVO
//
//  Created by sunjinshuai on 2018/4/19.
//  Copyright © 2018年 KVO. All rights reserved.
//

#import "Message.h"

@implementation Message

- (instancetype)init {
    self = [super init];
    if (self) {
        self.text = @"hello word";
    }
    return self;
}

@end
