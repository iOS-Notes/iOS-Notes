//
//  ViewController.m
//  ReverseDemo
//
//  Created by QMMac on 2018/9/18.
//  Copyright © 2018 QMMac. All rights reserved.
//

// 题目： 给定一个英文句子，每个单词之间都是由一个或多个空格隔开，请翻转句子中的单词顺序（包括空格的顺序），但单词内字符的顺序保持不变。例如输入"www google com "，则应输出" com google www"。

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str = @" www google com ";
    
    // 去掉两端空格
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // 反转整个字符串
    str = [self reverse:str];
    
    // 截取字符串
    NSArray *substrArray = [str componentsSeparatedByString:@" "];
    
    NSMutableString *tempString = [NSMutableString string];
    
    for (NSString *str in substrArray) {
        [tempString appendString:[self reverse:str]];
        [tempString appendString:@" "];
    }
    
    NSLog(@"%@", tempString);
}

- (NSString *)reverse:(NSString *)str {
    NSMutableString *reverseString = [NSMutableString stringWithCapacity:str.length];
    for (NSInteger i = str.length - 1 ; i >= 0; i--) {
        unichar c = [str characterAtIndex:i];
        NSString *s = [NSString stringWithCharacters:&c length:1];
        [reverseString appendString:s];
    }
    return reverseString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
