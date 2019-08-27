//
//  NSObject+Model.h
//  RunTime
//
//  Created by sunjinshuai on 2017/12/11.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Model)

// 字典转模型
+ (instancetype)modelWithDict:(NSDictionary *)dict;

// 自动打印属性字符串
+ (void)resolveDict:(NSDictionary *)dict;

@end
