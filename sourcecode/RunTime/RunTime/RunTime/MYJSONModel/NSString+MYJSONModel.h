//
//  NSString+MYJSONModel.h
//  RunTime
//
//  Created by sunjinshuai on 2018/1/3.
//  Copyright © 2018年 MYSampleCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MYJSONModel)

/**
 *  驼峰转下划线（loveYou -> love_you）
 */
- (NSString *)my_underlineFromCamel;
/**
 *  下划线转驼峰（love_you -> loveYou）
 */
- (NSString *)my_camelFromUnderline;
/**
 * 首字母变大写
 */
- (NSString *)my_firstCharUpper;
/**
 * 首字母变小写
 */
- (NSString *)my_firstCharLower;

- (BOOL)my_isPureInt;

- (NSURL *)my_url;

@end
