//
//  MYClassInfo.h
//  RunTime
//
//  Created by sunjinshuai on 2018/1/3.
//  Copyright © 2018年 MYSampleCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYClassInfo : NSObject

/// 属性字典<NSString *,TYPropertyInfo *>
@property (nonatomic, strong, readonly) NSDictionary *propertyInfo;

/// class
@property (nonatomic, assign, readonly) Class cls;

- (instancetype)initWithClass:(Class)cls;

@end
