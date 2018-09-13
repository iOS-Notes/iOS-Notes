//
//  TestViewController.m
//  AutoreleasePool
//
//  Created by QMMac on 2018/9/13.
//  Copyright © 2018 QMMac. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

__weak NSString *string_weak_ = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 场景 1
    __autoreleasing NSArray *string = [NSArray array];
    
    
    // 场景 2
    //    @autoreleasepool {
    //        NSString *string = [NSString stringWithFormat:@"leichunfeng"];
    //        string_weak_ = string;
    //    }
    
    // 场景 3
    //    NSString *string = nil;
    //    @autoreleasepool {
    //        string = [NSString stringWithFormat:@"leichunfeng"];
    //        string_weak_ = string;
    //    }
    
    NSLog(@"string: %@", string);
    
    NSNotification *notif = [[NSNotification alloc]init];
    NSLog(@"%@", notif);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
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
