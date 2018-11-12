//
//  IBookProtocol.h
//  DesignPatterns
//
//  Created by michael on 2018/11/12.
//  Copyright © 2018 michael. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IBookProtocol <NSObject>

/**
 获取书籍名称
 */
- (NSString *)bookName;

/**
 获取书籍售价
 */
- (CGFloat)bookPrice;

/**
 获取书籍作者
 */
- (NSString *)bookAuthor;

@end
