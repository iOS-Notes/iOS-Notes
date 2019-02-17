//
//  BookStore.m
//  DesignPatterns
//
//  Created by michael on 2018/11/12.
//  Copyright © 2018 michael. All rights reserved.
//

#import "BookStore.h"
#import "NovelBook.h"
#import "OffNovelBook.h"

@implementation BookStore

- (NSArray<IBookProtocol> *)bookArray {
    NSMutableArray<IBookProtocol> *tempArray = [NSMutableArray<IBookProtocol> array];
    
    NovelBook *book1 = [[NovelBook alloc] initWithBookName:@"天龙八部" price:30 author:@"金庸"];
    [tempArray addObject:book1];
    
    NovelBook *book2 = [[NovelBook alloc] initWithBookName:@"巴黎圣母院" price:70 author:@"雨果"];
    [tempArray addObject:book2];
    
    NovelBook *book3 = [[NovelBook alloc] initWithBookName:@"悲惨世界" price:80 author:@"雨果"];
    [tempArray addObject:book3];
    
    NovelBook *book4 = [[NovelBook alloc] initWithBookName:@"金瓶梅" price:40 author:@"兰陵王"];
    [tempArray addObject:book4];
    return tempArray;
}

- (NSArray<IBookProtocol> *)offBookArray {
    NSMutableArray<IBookProtocol> *tempArray = [NSMutableArray<IBookProtocol> array];
    
    OffNovelBook *book1 = [[OffNovelBook alloc] initWithBookName:@"天龙八部" price:30 author:@"金庸"];
    [tempArray addObject:book1];
    
    OffNovelBook *book2 = [[OffNovelBook alloc] initWithBookName:@"巴黎圣母院" price:70 author:@"雨果"];
    [tempArray addObject:book2];
    
    OffNovelBook *book3 = [[OffNovelBook alloc] initWithBookName:@"悲惨世界" price:80 author:@"雨果"];
    [tempArray addObject:book3];
    
    OffNovelBook *book4 = [[OffNovelBook alloc] initWithBookName:@"金瓶梅" price:40 author:@"兰陵王"];
    [tempArray addObject:book4];
    return tempArray;
}

@end
