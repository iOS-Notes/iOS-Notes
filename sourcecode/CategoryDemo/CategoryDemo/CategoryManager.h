//
//  CategoryManager.h
//  CategoryDemo
//
//  Created by sunjinshuai on 2019/2/17.
//  Copyright © 2019年 sunjinshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CategoryManager : NSObject

+ (instancetype)shared;

- (void)invokeOriginalMethod:(id)target selector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
