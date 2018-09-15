//
//  main.m
//  ThreadSafetyArray
//
//  Created by sunjinshuai on 2017/12/29.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#include <stdio.h>

int main(int argc, char * argv[]) {
    static int i = 10;
    void (^blk)(void) = ^{
        i = 30;
        printf("%d", i);
    };
    blk();
    return 0;
}
