//
//  ViewController.m
//  WeakRefArray
//
//  Created by sunjinshuai on 2018/4/8.
//  Copyright © 2018年 WeakRefArray. All rights reserved.
//

#import "ViewController.h"
#import "WeakRefArray.h"

@interface ViewController ()

@property (nonatomic, strong) WeakRefArray *weakArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSObject *str1 = [NSObject new];
    NSObject *str2 = [NSObject new];
    self.weakArr = [WeakRefArray array];
    [self.weakArr addObject:str1];
    [self.weakArr addObject:str2];
    
    NSLog(@"%@",self.weakArr);
}

- (IBAction)clickButton:(id)sender {
    NSLog(@"%@",self.weakArr);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
