//
//  TestLayoutView1.m
//  MasonryDemo
//
//  Created by QMMac on 2018/6/8.
//  Copyright © 2018 QMMac. All rights reserved.
//

#import "TestLayoutView1.h"
#import <Masonry.h>

@implementation TestLayoutView1

- (instancetype)init {
    self = [super init];
    if (self) {
        [self testLayout];
    }
    return self;
}

- (void)testLayout {
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    [self addSubview:redView];
    
    // 设置约束
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(150, 80));
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"self.view 的尺寸%@，redView 的尺寸%@",self,redView);
    });
}

- (void)updateConstraints {
    [super updateConstraints];
    
}


@end
