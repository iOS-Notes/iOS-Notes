//
//  ViewController.m
//  RunTime
//
//  Created by sunjinshuai on 2017/11/30.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "ViewController.h"
#import "TestClass+AssociatedObject.h"
#import "TestClass.h"
#import "Runtime.h"
#import "TestModel.h"
#import "StatusModel.h"
#import "Dog.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *className = [Runtime fetchClassName:[TestClass class]];
    NSLog(@"测试类的类名为：%@\n", className);
    
    NSArray *ivarList = [Runtime fetchIvarList:[TestClass class]];
    NSLog(@"\n获取TestClass的成员变量列表:%@", ivarList);
    
    NSArray *propertyList = [Runtime fetchPropertyList:[TestClass class]];
    NSLog(@"\n获取TestClass的属性列表:%@", propertyList);
    
    NSArray *methodList = [Runtime fetchMethodList:[TestClass class]];
    NSLog(@"\n获取TestClass的方法列表：%@", methodList);
    
    NSArray *protocolList = [Runtime fetchProtocolList:[TestClass class]];
    NSLog(@"\n获取TestClass的协议列表：%@", protocolList);
    
    TestClass *testClass = [[TestClass alloc] init];
    testClass.dynamicAddProperty = @"我是动态添加的属性";
    NSLog(@"%@", testClass.dynamicAddProperty);
    
    // 方法交换
    [testClass method1];
    
    // 测试消息转发
    [testClass performSelector:@selector(method3:) withObject:@"测试消息转发"];
    
    // 字典转模型
    [self keyValuesWithObject1];
    
    [self keyValuesWithObject2];
    
    // 动态转发
    [self dynamicMethod];
}
     
- (void)dynamicMethod {
    Dog *dog = [[Dog alloc] init];
    [dog run];
}

- (void)keyValuesWithObject2 {
    StatusModel *statusModel = [StatusModel modelWithDict:[self parsingWithFile:@"status2.plist"]];
    NSLog(@"%@--%@",statusModel,statusModel.user);
}


- (void)keyValuesWithObject1 {
    
    self.dataArray = @[@{@"name" : @"Jack",
                         @"userId" : @"11111",
                         @"classes" : @{@"className" : @"Chinese", @"time" : @"2016_03"},
                         @"teachers" : @[@{@"teaName" : @"Lisa1", @"teaAge" : @"21"},
                                         @{@"teaName" : @"Lisa2", @"teaAge" : @"22"},
                                         @{@"teaName" : @"Lisa3", @"teaAge" : @"23"}]},
                       @{@"name" : @"Rose",
                         @"userId" : @"22222",
                         @"classes" : @{@"className" : @"Math", @"time" : @"2016_04"},
                         @"teachers" : @[@{@"teaName" : @"Lisa1", @"teaAge" : @"21"},
                                         @{@"teaName" : @"Lisa2", @"teaAge" : @"22"},
                                         @{@"teaName" : @"Lisa3", @"teaAge" : @"23"}]}];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in self.dataArray) {
        TestModel *testModel = [TestModel modelWithDict:dict];
        [TestModel resolveDict:dict];
        [array addObject:testModel];
    }
    NSLog(@"数组：%@", array);
}

- (NSDictionary *)parsingWithFile:(NSString *)str{
    // 解析Plist文件
    NSString *filePath = [[NSBundle mainBundle] pathForResource:str ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    return dict;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
