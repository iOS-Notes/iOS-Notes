//
//  Classes.m
//  RunTime
//
//  Created by sunjinshuai on 2017/12/11.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "Classes.h"

@implementation Classes

- (NSString *)description {

    return [NSString stringWithFormat:@"{className = %@, time = %@}", self.className , self.time];
}
@end
