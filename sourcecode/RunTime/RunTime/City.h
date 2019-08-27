//
//  City.h
//  RunTime
//
//  Created by sunjinshuai on 2018/1/3.
//  Copyright © 2018年 MYSampleCode. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Programmer;

@interface City : NSObject <NSCoding>

@property (nonatomic, strong) Programmer *programmer;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSArray *deputies;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSNumber *level;

@property (nonatomic, assign) double area;

@end
