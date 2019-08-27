//
//  main.m
//  SelfClass与SuperClass的区别
//
//  Created by aikucun on 2019/8/27.
//  Copyright © 2019 MYSampleCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Son.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Son *son = [[Son alloc] init];
        NSLog(@"%@", son);
    }
    return 0;
}
