//
//  ViewController.m
//  MasonryDemo
//
//  Created by QMMac on 2018/5/29.
//  Copyright © 2018年 QMMac. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *masonryViewArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    for (int i = 0; i < 4; i ++) {
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor redColor];
        [self.view addSubview:view];
        [self.masonryViewArray addObject:view];
    }
    
    [self test_masonry_vertical_fixItemWidth];
}

/**
 水平方向排列、固定控件间隔、控件长度不定
 */
- (void)test_masonry_horizontal_fixSpace {
    
    // 实现masonry水平固定间隔方法
    [self.masonryViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:30 leadSpacing:10 tailSpacing:10];
    
    // 设置array的垂直方向的约束
    [self.masonryViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@150);
        make.height.equalTo(@80);
    }];
}

/**
 水平方向排列、固定控件长度、控件间隔不定
 */
- (void)test_masonry_horizontal_fixItemWidth {
    
    // 实现masonry水平固定控件宽度方法
    [self.masonryViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:80 leadSpacing:10 tailSpacing:10];
    
    // 设置array的垂直方向的约束
    [self.masonryViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@150);
        make.height.equalTo(@80);
    }];
}

/**
 垂直方向排列、固定控件间隔、控件高度不定
 */
- (void)test_masonry_vertical_fixSpace {
    
    // 实现masonry垂直固定控件高度方法
    [self.masonryViewArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:30 leadSpacing:10 tailSpacing:10];
    
    // 设置array的水平方向的约束
    [self.masonryViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@150);
        make.width.equalTo(@80);
    }];
}

/**
 垂直方向排列、固定控件高度、控件间隔不定
 */
- (void)test_masonry_vertical_fixItemWidth {
    
    // 实现masonry垂直方向固定控件高度方法
    [self.masonryViewArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:80 leadSpacing:10 tailSpacing:10];
    
    // 设置array的水平方向的约束
    [self.masonryViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@150);
        make.width.equalTo(@80);
    }];
}

- (NSMutableArray *)masonryViewArray {
    if (!_masonryViewArray) {
        _masonryViewArray = [NSMutableArray array];
    }
    return _masonryViewArray;
}

@end
