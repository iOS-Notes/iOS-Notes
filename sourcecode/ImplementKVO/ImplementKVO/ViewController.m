//
//  ViewController.m
//  ImplementKVO
//
//  Created by sunjinshuai on 2018/4/19.
//  Copyright © 2018年 KVO. All rights reserved.
//

#import "ViewController.h"
#import "Message.h"
#import "NSObject+KVO.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UITextField *textfield;
@property (nonatomic, weak) IBOutlet UIButton *button;

@property (nonatomic, strong) Message *message;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.message = [[Message alloc] init];
    __weak typeof(self) weakSelf = self;
    [self.message addObserver:self forKey:NSStringFromSelector(@selector(text))
                       withBlock:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
                           NSLog(@"%@.%@ is now: %@", observedObject, observedKey, newValue);
                           dispatch_async(dispatch_get_main_queue(), ^{
                               weakSelf.textfield.text = newValue;
                           });
                           
                       }];
    
    [self changeMessage:nil];
}

- (IBAction)changeMessage:(id)sender {
    NSArray *msgs = @[@"Hello World!", @"Objective C", @"Swift", @"Peng Gu", @"peng.gu@me.com", @"www.gupeng.me", @"glowing.com"];
    NSUInteger index = arc4random_uniform((u_int32_t)msgs.count);
    self.message.text = msgs[index];
}

@end
