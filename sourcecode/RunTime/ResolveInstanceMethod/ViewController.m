//
//  ViewController.m
//  ResolveInstanceMethod
//
//  Created by aikucun on 2019/9/9.
//  Copyright © 2019 MYSampleCode. All rights reserved.
//

#import "ViewController.h"
#import "Cat.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Cat *cat = [Cat new];
    [cat performSelector:@selector(run:) withObject:@10];
    [Cat performSelector:@selector(asleep)];
}


@end
