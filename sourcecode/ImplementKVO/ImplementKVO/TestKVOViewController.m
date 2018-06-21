//
//  TestKVOViewController.m
//  ImplementKVO
//
//  Created by QMMac on 2018/6/21.
//  Copyright © 2018 KVO. All rights reserved.
//

#import "TestKVOViewController.h"
#import "Message.h"

@interface TestKVOViewController ()

@property (nonatomic, strong) Message *message;

@end

@implementation TestKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    Message *message = [[Message alloc] init];
    [message addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    message.text = @"hello object-c";
    self.message = message;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"text"]) {
        NSLog(@"%@", change);
    }
}

- (void)dealloc {
    [self.message removeObserver:self forKeyPath:@"text"];
//    [self.message removeObserver:self forKeyPath:@"text"];
}

@end
