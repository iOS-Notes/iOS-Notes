//
//  MYDemoCollectionViewController.m
//  MYPushPopTransition
//
//  Created by sunjinshuai on 2018/3/21.
//  Copyright © 2018年 MYPushPopTransition. All rights reserved.
//

#import "MYDemoCollectionViewController.h"
#import "MYTestViewController.h"
#import "MYAnimatorPushPopTransition.h"

@interface MYDemoCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MYDemoCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(100, 150);
    
    CGRect frame = CGRectMake(0, 100, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 100);
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:_collectionView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.delegate = nil;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:((arc4random() % 255) / 255.0)
                                           green:((arc4random() % 255) / 255.0)
                                            blue:((arc4random() % 255) / 255.0)
                                           alpha:1.0f];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.contentView.frame];
    [cell.contentView addSubview:imageView];
    
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", (long)indexPath.item]];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MYTestViewController *itemVC = [[MYTestViewController alloc] init];
    itemVC.navigationItem.title = @"CollectionViewItemViewController";
    itemVC.imageIndex = indexPath.item;
    
    self.navigationController.delegate = self;
    [self.navigationController pushViewController:itemVC animated:YES];
}


#pragma mark - <UINavigationControllerDelegate>

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    // Push/Pop
    MYAnimatorPushPopTransition *pushPopTransition = [[MYAnimatorPushPopTransition alloc] init];
    
    if (operation == UINavigationControllerOperationPush) {
        pushPopTransition.animatorTransitionType = kAnimatorTransitionTypePush;
    } else {
        pushPopTransition.animatorTransitionType = kAnimatorTransitionTypePop;
    }
    
    
    NSArray *indexPaths = [_collectionView indexPathsForSelectedItems];
    if (indexPaths.count == 0) {
        return nil;
    }
    
    NSIndexPath *selectedIndexPath = indexPaths[0];
    UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:selectedIndexPath];
    
    // 一定要加上convertPoint:toView:操作
    pushPopTransition.itemCenter = [_collectionView convertPoint:cell.center toView:self.view];
    pushPopTransition.itemSize = cell.frame.size;
    pushPopTransition.imageName = [NSString stringWithFormat:@"%ld", (long)selectedIndexPath.item];
    
    return pushPopTransition;
}


@end
