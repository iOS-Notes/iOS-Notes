//
//  MYFoundation.m
//  RunTime
//
//  Created by sunjinshuai on 2018/1/3.
//  Copyright © 2018年 MYSampleCode. All rights reserved.
//

#import "MYFoundation.h"
#import <CoreData/CoreData.h>

static NSArray *foundations;

@implementation MYFoundation

+ (BOOL)isClassFromFoundation:(Class)class {
    if (class == [NSManagedObject class] || class == [NSObject class]) {
        return YES;
    }
    
    static dispatch_once_t onceToken;
    // 集合中没有NSObject，因为几乎所有的类都是继承自NSObject，具体是不是NSObject需要特殊判断
    dispatch_once(&onceToken, ^{
        foundations = @[[NSURL class],
                        [NSDate class],
                        [NSValue class],
                        [NSData class],
                        [NSError class],
                        [NSArray class],
                        [NSDictionary class],
                        [NSString class],
                        [NSAttributedString class]
                        ];
    });
    
    BOOL result = NO;
    for (Class foundationClass in foundations) {
        if ([class isSubclassOfClass:foundationClass]) {
            result = YES;
            break;
        }
    }
    return result;
}


@end
