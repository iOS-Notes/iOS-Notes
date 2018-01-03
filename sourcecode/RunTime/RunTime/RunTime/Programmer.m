//
//  Programmer.m
//  RunTime
//
//  Created by sunjinshuai on 2018/1/3.
//  Copyright © 2018年 MYSampleCode. All rights reserved.
//

#import "Programmer.h"
#import "NSObject+MYJSONModel.h"

@implementation Programmer

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self my_InitWithCoder:aDecoder];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self my_EncodeWithCoder:aCoder];
}

@end
