//
//  Mother.m
//  DesignPatterns
//
//  Created by michael on 2018/11/9.
//  Copyright © 2018 michael. All rights reserved.
//

#import "Mother.h"
#import "Book.h"

@implementation Mother

- (void)tellStory:(Book *)book {
    NSLog(@"妈妈开始讲故事");
    [book theStoryContent];
}

@end
