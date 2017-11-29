//
//  ViewController.m
//  Label&Compress&Hugging
//
//  Created by sunjinshuai on 2017/11/29.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *yellowLabel = [[UILabel alloc] init];
    yellowLabel.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowLabel];
    
    UILabel *bluelabel = [[UILabel alloc] init];
    bluelabel.backgroundColor = [UIColor blueColor];
    [self.view addSubview:bluelabel];
    
    /*
     * intrinsicContentSize: 这个是label的真实的大小size
     * 抗拉伸和抗压缩都是相对于intrinsicContentSize值来说的
     **/
    
    /*
     * 抗拉伸
     * 主要用在 yellowLabel、bluelabel 限制后还有空余空间，这个时候就需要谁来拉伸了，才能满足我们的限制
     * setContentHuggingPriority（值越高，越不容易拉伸，所以取名为‘抗拉伸’）
     **/
    yellowLabel.text = @"label";
    bluelabel.text = @"label2";
    /*
     * 保证label 不被拉伸，那么只能拉伸label2
     **/
    [yellowLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [bluelabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    /*
     * 抗压缩
     * 主要用在 yellowLabel、bluelabel限制后，没有空余空间，这个时候就 只能压缩某个label，才能满足我们的限制
     * setContentCompressionResistancePriority（值越高，越不容易压缩，所以取名为‘抗压缩’）
     **/
    yellowLabel.text = @"hello，我是第一个label，请多多！";
    bluelabel.text = @"hello，我是第二个label，谢谢";
    
    /*
     * 保证bluelabel 不被压缩，那么只能压缩label
     **/
    [yellowLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [bluelabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    [yellowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@100);
        make.right.equalTo(bluelabel.mas_left).offset(-20);
    }];
    
    [bluelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yellowLabel.mas_right).offset(20);
        make.top.equalTo(yellowLabel);
        make.right.equalTo(@(-10));
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
