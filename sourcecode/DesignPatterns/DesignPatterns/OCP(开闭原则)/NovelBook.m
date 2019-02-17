//
//  NovelBook.m
//  DesignPatterns
//
//  Created by michael on 2018/11/12.
//  Copyright © 2018 michael. All rights reserved.
//

#import "NovelBook.h"

@interface NovelBook ()

/**
 书籍名称
 */
@property (nonatomic, copy  ) NSString *name;


/**
 书籍的价格
 */
@property (nonatomic, assign) CGFloat price;


/**
 书籍的作者
 */
@property (nonatomic, copy  ) NSString *author;

@end

@implementation NovelBook

- (instancetype)initWithBookName:(NSString *)name
                           price:(CGFloat)price
                          author:(NSString *)author {
    self = [super init];
    if (self) {
        self.name   = name;
        self.price  = price;
        self.author = author;
    }
    return self;
}

- (NSString *)bookName {
    return self.name;
}

- (CGFloat)bookPrice {
    return self.price;
}

- (NSString *)bookAuthor {
    return self.author;
}

@end
