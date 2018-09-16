//
//  ViewController.m
//  LinkedListDemo
//
//  Created by sunjinshuai on 2018/9/16.
//  Copyright © 2018年 sunjinshuai. All rights reserved.
//

#import "ViewController.h"
#import "LinkedList.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LinkedList *linkedList = [LinkedList new];
    
    for (int i = 0; i < 5; i++) {
        LinkedNode *node = [LinkedNode new];
        node.data = @(i);
        [linkedList insertNode:node];
    }
    
    
    
    LinkedNode *node = [LinkedNode new];
    node.data = @(10);
    
    [linkedList insertNode:node atIndex:2];
    
    [linkedList printLog];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
