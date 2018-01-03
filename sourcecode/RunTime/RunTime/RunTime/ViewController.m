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
#import "City.h"
#import "Programmer.h"
#import "NSObject+MYJSONModel.h"

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
    
    testDemo1();
    
    testDemo2();
    
    testDemo3();
    
    testDemo4();
    
    testDemo5();
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

void testDemo1()
{
    Programmer *programmer = [[Programmer alloc] init];
    programmer.age = 20;
    programmer.name = @"yester";
    programmer.sex = @"女";
    programmer.tag = @(6);
    //person.height = @(168.8);
    programmer.weight = 46.6;
    
    NSString *path = NSTemporaryDirectory();
    path = [NSString stringWithFormat:@"%@Person.plist",path];
    // 归档
    [NSKeyedArchiver archiveRootObject:programmer toFile:path];
    NSLog(@"archive path : %@",path);
    
    // 解归档
    Programmer *programmer1 = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"person: age: %ld, name: %@, sex: %@ tag:%@ height:%@ weight:%f",programmer1.age,programmer1.name,programmer1.sex,programmer1.tag,programmer1.height,programmer1.weight);
}

void testDemo2()
{
    Programmer *programmer = [[Programmer alloc] init];
    programmer.age = 20;
    programmer.name = @"yester";
    programmer.sex = @"女";
    programmer.tag = @(6);
    //person.height = @(168.8);
    programmer.weight = 46.6;
    
    NSDictionary *dic = [programmer my_ModelToDictonary];
    NSLog(@"person dic : %@",dic);
    
    Programmer *person1 = [Programmer my_ModelWithDictonary:dic];
    NSLog(@"person: age: %ld, name: %@, sex: %@ tag:%@ height:%@ weight:%f",person1.age,person1.name,person1.sex,person1.tag,person1.height,person1.weight);
    
}

void testDemo3()
{
    City *city = [[City alloc]init];
    
    Programmer *mayor = [[Programmer alloc] init];
    mayor.age = 20;
    mayor.name = @"maey";
    mayor.sex = @"女";
    mayor.tag = @(6);
    //mayor.height = @(168.8);
    mayor.weight = 46.6;
    
    Programmer *deputie = [[Programmer alloc] init];
    deputie.age = 26;
    deputie.name = @"jack";
    deputie.sex = @"男";
    deputie.tag = @(8);
    //deputie.height = @(178.8);
    deputie.weight = 48.6;
    
    Programmer *deputie1 = [[Programmer alloc] init];
    deputie1.age = 28;
    deputie1.name = @"mark";
    deputie1.sex = @"男";
    deputie1.tag = @(7);
    //deputie1.height = @(178.8);
    deputie1.weight = 46.8;
    
    city.programmer = mayor;
    city.total = 66666666;
    city.deputies = @[mayor,deputie,deputie1];
    
    city.name = @"hancheng";
    city.level = @(1);
    city.area = 166666.6666;
    
    NSDictionary *dic = [city my_ModelToDictonary];
    NSLog(@"city dic : %@",dic);
    
    City *city1 = [City my_ModelWithDictonary:dic];
    NSLog(@"city: mayor: %@, name: %@, deputies: %@ total:%ld level:%@ area:%f",city1.programmer,city1.name,city1.deputies,city1.total,city1.level,city1.area);
    
    NSLog(@"city json: %@",[city my_ModelToJSONString]);
}

void testDemo4()
{
    City *city = [[City alloc]init];
    
    Programmer *mayor = [[Programmer alloc] init];
    mayor.age = 20;
    mayor.name = @"maey";
    mayor.sex = @"女";
    mayor.tag = @(6);
    //mayor.height = @(168.8);
    mayor.weight = 46.6;
    
    Programmer *deputie = [[Programmer alloc] init];
    deputie.age = 26;
    deputie.name = @"jack";
    deputie.sex = @"男";
    deputie.tag = @(8);
    //deputie.height = @(178.8);
    deputie.weight = 48.6;
    
    Programmer *deputie1 = [[Programmer alloc] init];
    deputie1.age = 28;
    deputie1.name = @"mark";
    deputie1.sex = @"男";
    deputie1.tag = @(7);
    //deputie1.height = @(178.8);
    deputie1.weight = 46.8;
    
    city.programmer = mayor;
    city.total = 66666666;
    city.deputies = @[mayor,deputie,deputie1];
    
    city.name = @"hancheng";
    city.level = @(1);
    city.area = 166666.6666;
    
    NSString *path = NSTemporaryDirectory();
    path = [NSString stringWithFormat:@"%@City.plist",path];
    // 归档
    [NSKeyedArchiver archiveRootObject:city toFile:path];
    NSLog(@"archive path : %@",path);
    
    // 解归档
    City *city1 = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"city: mayor: %@, name: %@, deputies: %@ total:%ld level:%@ area:%f",city1.programmer,city1.name,city1.deputies,city1.total,city1.level,city1.area);
    
}

void testDemo5()
{
    NSString *jsonString = @"{\"deputies\":[{\"age\":20,\"sex\":\"女\",\"weight\":46.6,\"name\":\"maey\",\"tag\":6,\"height\":168.8},{\"age\":26,\"sex\":\"男\",\"weight\":48.6,\"name\":\"jack\",\"tag\":8,\"height\":178.8},{\"age\":28,\"sex\":\"男\",\"weight\":46.8,\"name\":\"mark\",\"tag\":7,\"height\":178.8}],\"mayor\":{\"age\":20,\"sex\":\"女\",\"weight\":46.6,\"name\":\"maey\",\"tag\":6,\"height\":168.8},\"area\":166666.6666,\"level\":1,\"total_num\":66666666,\"name\":\"hancheng\"}";
    
    City *city1 = [City my_ModelWithJSON:jsonString];
    NSLog(@"city: mayor: %@, name: %@, deputies: %@ total:%ld level:%@ area:%f",city1.programmer,city1.name,city1.deputies,city1.total,city1.level,city1.area);
    
    NSLog(@"city : %@",[city1 my_ModelToJSONString]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
