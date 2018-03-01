//
//  ViewController.m
//  iOS11
//
//  Created by sunjinshuai on 2018/2/26.
//  Copyright © 2018年 iOS11. All rights reserved.
//

#import "ViewController.h"
#import "MYPresentationViewController.h"
#import "TestViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UIViewControllerPreviewingDelegate, UISearchResultsUpdating>

@property (nonatomic, assign) BOOL hidden;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) CGRect sourceRect;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"iOS11的效果";
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        searchController.searchResultsUpdater = self;
        self.navigationItem.searchController = searchController;
    }
    
    self.tableView.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.tableView.refreshControl addTarget:self
                                      action:@selector(refreshControllerAction)
                            forControlEvents:UIControlEventValueChanged];
    
    // 注册Peek和Pop方法
    [self registerForPreviewingWithDelegate:self sourceView:self.view];
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    
    NSLog(@"%f", self.view.safeAreaInsets.top);
    NSLog(@"%f", self.view.safeAreaInsets.left);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.backgroundColor = self.tableView.backgroundColor;
    cell.backgroundColor = self.tableView.backgroundColor;
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", indexPath.row + 1];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TestViewController *test = [[TestViewController alloc] init];
    
    [self.navigationController pushViewController:test
                                         animated:YES];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}

#pragma mark peek(preview)
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location NS_AVAILABLE_IOS(9_0) {
    // 获取用户手势点所在cell的下标。同时判断手势点是否超出tableView响应范围。
    if (![self getShouldShowRectAndIndexPathWithLocation:location]) {
        return nil;
    }
    previewingContext.sourceRect = self.sourceRect;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)[previewingContext sourceView]];
    NSString *str = [NSString stringWithFormat:@"%@",self.dataSource[indexPath.row]];
    
    //创建要预览的控制器
    MYPresentationViewController *presentationVC = [[MYPresentationViewController alloc] init];
    presentationVC.arrData = (NSMutableArray *)self.dataSource;
    presentationVC.index = indexPath.row;
    presentationVC.strInfo = str;
    
    previewingContext.sourceRect = self.sourceRect;;
    
    return presentationVC;
}

#pragma mark pop(push)
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit NS_AVAILABLE_IOS(9_0) {
    
    [self showViewController:viewControllerToCommit sender:self];
}

// 获取用户手势点所在cell的下标。同时判断手势点是否超出tableView响应范围。
- (BOOL)getShouldShowRectAndIndexPathWithLocation:(CGPoint)location {
    NSInteger row = location.y/50;
    self.sourceRect = CGRectMake(0, row * 50, [UIScreen mainScreen].bounds.size.width, 50);
    self.indexPath = [NSIndexPath indexPathForItem:row inSection:0];
    // 如果row越界了，返回NO 不处理peek手势
    return row >= self.dataSource.count ? NO : YES;
}

- (void)refreshControllerAction {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView.refreshControl endRefreshing];
    });
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 30; i++) {
            [array addObject:@(i)];
        }
        _dataSource = array;
    }
    return _dataSource;
}

@end
