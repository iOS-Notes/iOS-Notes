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

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
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
    [self.dataArray addObjectsFromArray:array];
    
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


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *data = [[MYStringFormatManager shareManager] orderArray:self.dataArray orderBy:@"stringFormatKey"];
    NSMutableArray *datasource = [data objectAtIndex:section];
    return datasource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSMutableArray *data = [[MYStringFormatManager shareManager] orderArray:self.dataArray orderBy:@"stringFormatKey"];
    NSMutableArray *sectionArray = [[MYStringFormatManager shareManager] getSectionArray:data orderBy:@"stringFormatKey"];
    return sectionArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 44.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSMutableArray *data = [[MYStringFormatManager shareManager] orderArray:self.dataArray orderBy:@"stringFormatKey"];
    NSArray *titleArray = [[MYStringFormatManager shareManager] getSectionArray:data orderBy:@"stringFormatKey"];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor lightGrayColor];
    titleLabel.textColor = [UIColor darkGrayColor];
    titleLabel.font = [UIFont systemFontOfSize:14.0f];
    titleLabel.text = [titleArray objectAtIndex:section];
    return titleLabel;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])
                                                            forIndexPath:indexPath];
    NSMutableArray *data = [[MYStringFormatManager shareManager] orderArray:self.dataArray orderBy:@"stringFormatKey"];
    NSMutableArray *datasource = [data objectAtIndex:indexPath.section];
    MYStringFormatModel *stringFormatModel = [datasource objectAtIndex:indexPath.row];
    cell.textLabel.text = stringFormatModel.stringFormatKey;
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *data = [[MYStringFormatManager shareManager] orderArray:self.dataArray orderBy:@"stringFormatKey"];
    return [[MYStringFormatManager shareManager] getSectionArray:data orderBy:@"stringFormatKey"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22;
}


#pragma mark - setter getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _tableView.sectionIndexColor = [UIColor lightGrayColor];
        [_tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        }
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
