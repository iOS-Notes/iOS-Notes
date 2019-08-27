//
//  Person.m
//  RunTime
//
//  Created by sunjinshuai on 2017/12/11.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "Person.h"

@implementation Person

- (NSString *)description {

    return [NSString stringWithFormat:@"name = %@, userId = %@, [classes = %@], [teachers = %@]", self.name, self.userId, self.classes, self.teachers];
}

@end
