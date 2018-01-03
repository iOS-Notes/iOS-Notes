//
//  Programmer.h
//  RunTime
//
//  Created by sunjinshuai on 2018/1/3.
//  Copyright © 2018年 MYSampleCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Programmer : NSObject <NSCoding>

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, strong) NSString *sex;

@property (nonatomic, strong) NSNumber *tag;

@property (nonatomic, strong, readonly) NSNumber *height;

@property (nonatomic, assign) double weight;

@end
