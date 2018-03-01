//
//  ViewController.m
//  UISwipeActionsConfiguration
//
//  Created by sunjinshuai on 2018/3/1.
//  Copyright © 2018年 UISwipeActionsConfiguration. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"UITableViewCell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"IndexPath: %ld", indexPath.row];
    return cell;
}

#pragma mark - Table View Swipe Actions Configuration
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIContextualAction *contextualAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal
                                                                                   title:@"Add"
                                                                                 handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
                                                                                     
                                                                                     NSLog(@"Add");
                                                                                 }];
    
    contextualAction.backgroundColor = [UIColor brownColor];
    
    UISwipeActionsConfiguration *swipeActionsCOnfiguration = [UISwipeActionsConfiguration configurationWithActions:@[contextualAction]];
    
    return swipeActionsCOnfiguration;
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIContextualAction *contextualAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal
                                                                                   title:@"Copy"
                                                                                 handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
                                                                                     
                                                                                     NSLog(@"Copy");
                                                                                 }];
    
    contextualAction.backgroundColor = [UIColor blackColor];
    
    UISwipeActionsConfiguration *swipeActionsCOnfiguration = [UISwipeActionsConfiguration configurationWithActions:@[contextualAction]];
    
    return swipeActionsCOnfiguration;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.dataSource = self;
        _tableView.delegate   = self;
    }
    return _tableView;
}

@end
