//
//  ViewController.m
//  __attribute__
//
//  Created by michael on 2019/2/25.
//  Copyright © 2019 michael. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person *p = [Person new];
    NSLog(@"%@", p);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
