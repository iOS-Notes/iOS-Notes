//
//  ViewController.m
//  AutoreleasePool
//
//  Created by QMMac on 2018/5/19.
//  Copyright © 2018年 QMMac. All rights reserved.
//

#import "ViewController.h"
#import "TestObject.h"

@interface ViewController ()

@end

@implementation ViewController

__weak id _testObject = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TestObject *testObject = [TestObject instanceWithNumber:10];
    _testObject = testObject;

    NSLog(@"TestObject : %@", _testObject);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"TestObject : %@", _testObject);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
