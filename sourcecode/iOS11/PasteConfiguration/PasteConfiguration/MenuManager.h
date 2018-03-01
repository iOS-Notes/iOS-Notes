//
//  MenuManager.h
//  PasteConfiguration
//
//  Created by sunjinshuai on 2018/3/1.
//  Copyright © 2018年 PasteConfiguration. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuManager : NSObject

- (instancetype)initWithView:(UIView *)view;

@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGestureRecognizer;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@end
