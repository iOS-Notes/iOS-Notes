//
//  Teacher.m
//  RunTime
//
//  Created by sunjinshuai on 2017/12/11.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "Teacher.h"

@implementation Teacher

- (NSString *)description {
    
    return [NSString stringWithFormat:@"{teaName = %@, teaAge = %@}", self.teaName , self.teaAge];
}
@end
