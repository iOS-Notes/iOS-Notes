//
//  MYNSTimerProxyViewController.m
//  NSTimer&CADisplayLink
//
//  Created by sunjinshuai on 2018/2/24.
//  Copyright © 2018年 NSTimer&CADisplayLink. All rights reserved.
//

#import "MYNSTimerProxyViewController.h"
#import "MYTimerProxy.h"

@interface MYNSTimerProxyViewController ()

@end

@implementation MYNSTimerProxyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addTimerProxy];
}

- (void)addTimerProxy {
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.25
                                                      target:[MYTimerProxy timerProxyWithTarget:self]
                                                    selector:@selector(startTimer)
                                                    userInfo:nil
                                                     repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)startTimer {
    NSLog(@"MYNSTimerProxyController timer start");
}

-(void)dealloc {
    NSLog(@"dealloc");
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
