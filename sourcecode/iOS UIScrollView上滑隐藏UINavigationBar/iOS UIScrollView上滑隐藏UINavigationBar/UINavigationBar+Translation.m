//
//  UINavigationBar+Translation.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/14.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "UINavigationBar+Translation.h"

@implementation UINavigationBar (Translation)

- (void)setTranslationY:(CGFloat)translationY {
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

@end
