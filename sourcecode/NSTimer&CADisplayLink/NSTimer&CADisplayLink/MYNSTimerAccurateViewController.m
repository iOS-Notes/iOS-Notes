//
//  MYNSTimerAccurateViewController.m
//  NSTimer&CADisplayLink
//
//  Created by sunjinshuai on 2018/9/15.
//  Copyright © 2018年 NSTimer&CADisplayLink. All rights reserved.
//

#import "MYNSTimerAccurateViewController.h"

@interface MYNSTimerAccurateViewController ()

@end

@implementation MYNSTimerAccurateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NSTimer 是否精确";
    self.view.backgroundColor = [UIColor whiteColor];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] run];
    });
}

- (void)countDown {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        int count = 0;
        for (int i = 0; i < 1000000000; i++) {
            count += i;
        }
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"timer test");
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
