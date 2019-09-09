//
//  ViewController.m
//  TouchEventTest
//
//  Created by aikucun on 2019/9/5.
//  Copyright © 2019 aikucun. All rights reserved.
//

#import "ViewController.h"
#import "MYCustomButton.h"
#import "MYTableView.h"
#import "MYCustomView.h"
#import <Masonry/Masonry.h>

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) MYTableView *tableView;
@property (nonatomic, strong) MYCustomButton *customButton;
@property (nonatomic, strong) MYCustomView *customView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"手势冲突测试";
    self.view.backgroundColor = [UIColor whiteColor];

    self.tableView = [[MYTableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.dataSource = self;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }

    self.customButton = [MYCustomButton buttonWithType:UIButtonTypeCustom];
    self.customButton.backgroundColor = [UIColor blueColor];
    [self.customButton addTarget:self action:@selector(cutomButtonClick) forControlEvents:UIControlEventTouchUpInside];

    self.customView = [[MYCustomView alloc] init];
    self.customView.backgroundColor = [UIColor yellowColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapView)];
    tap.delegate = self;
    [self.customView addGestureRecognizer:tap];

    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.customView];
    [self.view addSubview:self.customButton];

    [self.customButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(150, 50));
    }];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.customButton.mas_top).offset(-20);
        make.top.left.right.equalTo(self.view);
    }];

    [self.customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.customButton.mas_top).offset(-40);
        make.right.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"点我~";

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"cell selected!");
}

- (void)actionTapView {
    NSLog(@"CustomView taped");
}

- (void)cutomButtonClick {
    NSLog(@"Button Click");
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([gestureRecognizer.view isDescendantOfView:self.tableView]) {
        NSLog(@"NO");
        return NO;
    }
    return YES;
}

@end
