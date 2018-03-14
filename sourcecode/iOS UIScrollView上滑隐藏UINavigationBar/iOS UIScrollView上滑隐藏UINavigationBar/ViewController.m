//
//  ViewController.m
//  iOS UIScrollView上滑隐藏UINavigationBar
//
//  Created by sunjinshuai on 2018/3/14.
//  Copyright © 2018年 sunjinshuai. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationBar+Translation.h"

#define SCREEN [UIScreen mainScreen].bounds.size

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, assign) CGFloat offsetY;
@property (nonatomic, weak) UIButton *bottomButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"11111";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, SCREEN.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    // UIScrollView的Content就不会自动偏移64(导航栏和状态栏的高度)
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    self.tableView = tableView;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    
    UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomButton.frame = CGRectMake(self.view.frame.size.width / 2 - 25, self.view.frame.size.height - 50, 50, 50);
    bottomButton.backgroundColor = [UIColor purpleColor];
    self.bottomButton = bottomButton;
    [self.view addSubview:self.bottomButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"text";
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //这里做一下说明  因为在iOS7之后  如果UIScrolView是第一个被 [self.view addSubview:scrollView] 添加到
    //当前的VC view上   那么之后添加到UIScrollView上的view都会在Y方向上 向下偏移64 这里加上64就是为了让UIScrollview的偏移量处于0  这样offsetY就是我们真正手势滑动的距离  如果不想要UIScrollView偏移，那么需要在VC上使用如下方法：
    //self.automaticallyAdjustsScrollViewInsets = NO 如果这样用  那么就需要在滑动时  改变TableView的frame 这样  我们移动NavigationBar的时候 才不会出现空白view
    CGFloat offsetY = scrollView.contentOffset.y+64;
    if (offsetY > 0) {
        if (offsetY >= 64) {
            [self setNavigationBarTransformProgress:1];
        } else {
            [self setNavigationBarTransformProgress:(offsetY/64)];
        }
    } else {
        [self setNavigationBarTransformProgress:0];
        self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
    }
    
    if (scrollView.contentOffset.y > self.offsetY && scrollView.contentOffset.y > 0) {//向上滑动
        //按钮消失
        [UIView transitionWithView:self.bottomButton duration:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
            self.bottomButton.frame = CGRectMake(SCREEN.width / 2 - 25, SCREEN.height, 50, 50);
        } completion:NULL];
    } else if (scrollView.contentOffset.y < self.offsetY ){//向下滑动
        //按钮出现
        [UIView transitionWithView:self.bottomButton duration:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
            self.bottomButton.frame = CGRectMake(SCREEN.width / 2 - 25, SCREEN.height - 50, 50, 50);
        } completion:NULL];
    }
    self.offsetY = scrollView.contentOffset.y;//将当前位移变成缓存位移
}

- (void)setNavigationBarTransformProgress:(CGFloat)progress {
    [self.navigationController.navigationBar setTranslationY:(-44 * progress)];
}
@end
