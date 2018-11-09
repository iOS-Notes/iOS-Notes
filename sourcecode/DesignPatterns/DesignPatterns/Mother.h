//
//  Mother.h
//  DesignPatterns
//
//  Created by michael on 2018/11/9.
//  Copyright © 2018 michael. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Book;

NS_ASSUME_NONNULL_BEGIN

@interface Mother : NSObject

/**
 讲故事
 */
- (void)tellStory:(Book *)book;

@end

NS_ASSUME_NONNULL_END
