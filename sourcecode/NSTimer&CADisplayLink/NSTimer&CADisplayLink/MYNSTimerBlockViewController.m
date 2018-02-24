//
//  MYNSTimerBlockViewController.m
//  NSTimer&CADisplayLink
//
//  Created by sunjinshuai on 2018/2/24.
//  Copyright © 2018年 NSTimer&CADisplayLink. All rights reserved.
//

#import "MYNSTimerBlockViewController.h"

@interface MYNSTimerBlockViewController ()

@end

@implementation MYNSTimerBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addTimerBlock];
}

- (void)addTimerBlock {
    // NSTimer Block(解决self内存泄露) 模拟器会崩溃
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.25
                                                     repeats:YES
                                                       block:^(NSTimer * _Nonnull timer) {
        NSLog(@"MYNSTimerBlockController timer start");
    }];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
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
