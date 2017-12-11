//
//  Person.h
//  RunTime
//
//  Created by sunjinshuai on 2017/12/11.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Classes.h"
#import "Teacher.h"

@interface Person : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) Classes *classes; // 选课科目(只选一个科目)
@property (nonatomic, strong) Teacher *teachers; // 老师


@end
