//
//  StatusModel.h
//  RunTime
//
//  Created by sunjinshuai on 2017/12/11.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface StatusModel : NSObject

@property (nonatomic, assign) NSInteger attitudes_count;
@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) User *user;

@end
