//
//  B.h
//  DesignPatterns
//
//  Created by sunjinshuai on 2018/11/1.
//  Copyright © 2018年 michael. All rights reserved.
//

#import "A.h"

NS_ASSUME_NONNULL_BEGIN

@interface B : A

/**
 加法
 
 @param a
 @param b
 @return 相加之后的和
 */
- (NSInteger)addition:(NSInteger)a b:(NSInteger)b;


/**
 减法
 
 @param a
 @param b
 @return 相加之后的和
 */
- (NSInteger)subtraction:(NSInteger)a b:(NSInteger)b;

@end

NS_ASSUME_NONNULL_END
