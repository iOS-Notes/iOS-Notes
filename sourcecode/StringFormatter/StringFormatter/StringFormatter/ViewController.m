//
//  ViewController.m
//  StringFormatter
//
//  Created by sunjinshuai on 2017/11/30.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "ViewController.h"
#import "MYStringFormatModel.h"
#import "MYStringFormatManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *keyArray = @[
                          @"啊肉",
                          @"吖个",
                          @"吧饿",
                          @"呗套",
                          @"有瓜",
                          @"万的",
                          @"小啥",
                          @"有钱",
                          @"组饿",
                          @"哦怕",
                          @"钱玩",
                          @"万去",
                          @"鄂肉",
                          @"套额",
                          @"又号",
                          @"吗套",
                          @"买卖",
                          @"内的",
                          @"会有",
                          @"钱就",
                          @"家更好",
                          @"套吧",
                          @"快好",
                          @"奖吧",
                          @"房沟"
                          ];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *stringFormatKey in keyArray) {
        MYStringFormatModel *stringFormatModel = [[MYStringFormatModel alloc] init];
        stringFormatModel.stringFormatKey = stringFormatKey;
        [array addObject:stringFormatModel];
    }
    
    NSMutableArray *data = [[MYStringFormatManager shareManager] orderArray:array orderBy:@"stringFormatKey"];
    NSMutableArray *section = [[MYStringFormatManager shareManager] getSectionArray:data orderBy:@"stringFormatKey"];
    for (int i = 0; i < data.count; i++) {
        NSArray *sectionArray = data[i];
        for (int j = 0; j < sectionArray.count; j++) {
            MYStringFormatModel *stringFormatModel = sectionArray[j];
            NSLog(@"第%d组首字母%@，第%d个，%@",i,section[i],j,stringFormatModel.stringFormatKey);
        }
    }
    NSLog(@"section - %@",section);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
