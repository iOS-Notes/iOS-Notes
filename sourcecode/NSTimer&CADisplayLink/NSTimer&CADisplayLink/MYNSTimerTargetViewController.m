//
//  MYNSTimerTargetViewController.m
//  NSTimer&CADisplayLink
//
//  Created by sunjinshuai on 2018/2/24.
//  Copyright © 2018年 NSTimer&CADisplayLink. All rights reserved.
//

#import "MYNSTimerTargetViewController.h"
#import "NSTimer+TimerTarget.h"

@interface MYNSTimerTargetViewController ()

@end

@implementation MYNSTimerTargetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addTimerBlock];
}

- (void)addTimerBlock {
    
    // 解决self循环引用问题
    __weak typeof(self) weakSelf = self;
    NSTimer *timer = [NSTimer my_scheduledTimerWithTimeInterval:0.25
                                                         repeat:YES
                                                          block:^(NSTimer *timer) {
        MYNSTimerTargetViewController *strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf startTimer];
        }
    }];
    self.timer = timer;
}

- (void)startTimer {
    NSLog(@"MYNSTimerTargetController timer start");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
