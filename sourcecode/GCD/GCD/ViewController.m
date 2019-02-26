//
//  ViewController.m
//  GCD
//
//  Created by sunjinshuai on 2017/12/6.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "ViewController.h"
#import "MYNetworking.h"
#import "MYGCDSemaphore.h"
#import "MYGCDGroup.h"
#import "MYGCDApply.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 配置请求和响应类型，由于部分伙伴们的服务器不接收JSON传过去，现在默认值改成了plainText
    [MYNetworking configRequestType:kMYRequestTypePlainText
                       responseType:kMYResponseTypeJSON
                shouldAutoEncodeUrl:YES
            callbackOnCancelRequest:NO];
    
    [self testSemaphore];
}

- (void)testSemaphore {
    MYGCDSemaphore *gcdSemaphore = [MYGCDSemaphore new];
    [gcdSemaphore testHttpSemaphore];
}

- (void)testGCDGroup {
    MYGCDGroup *gcdGroup = [MYGCDGroup new];
    [gcdGroup testGCDGroup];
}

- (void)testApply {
    MYGCDApply *gcdApply = [[MYGCDApply alloc] init];
    [gcdApply testGCDApply];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
