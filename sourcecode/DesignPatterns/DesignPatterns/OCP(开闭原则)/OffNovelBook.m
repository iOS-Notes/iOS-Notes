//
//  OffNovelBook.m
//  DesignPatterns
//
//  Created by michael on 2018/11/12.
//  Copyright © 2018 michael. All rights reserved.
//

#import "OffNovelBook.h"

@implementation OffNovelBook

- (instancetype)initWithBookName:(NSString *)name
                           price:(CGFloat)price
                          author:(NSString *)author {
    return [super initWithBookName:name price:price author:author];
}

- (CGFloat)bookPrice {
    CGFloat originalPrice = [super bookPrice];
    CGFloat offPrice      = 0;
    if (originalPrice > 40) {
        offPrice = originalPrice * 0.8;
    } else {
        offPrice = originalPrice * 0.9;
    }
    return offPrice;
}

@end
