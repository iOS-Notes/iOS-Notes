//
//  City.m
//  RunTime
//
//  Created by sunjinshuai on 2018/1/3.
//  Copyright © 2018年 MYSampleCode. All rights reserved.
//

#import "City.h"
#import "Programmer.h"
#import "NSObject+MYJSONModel.h"

@implementation City

+ (NSDictionary *)modelClassInArrayOrDictonary {
    return @{
             @"deputies" : [Programmer class]
             
             };
}

+ (NSDictionary *)modelPropertyMapper {
    return @{@"total":@"total_num"};
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self my_InitWithCoder:aDecoder];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self my_EncodeWithCoder:aCoder];
}

@end
