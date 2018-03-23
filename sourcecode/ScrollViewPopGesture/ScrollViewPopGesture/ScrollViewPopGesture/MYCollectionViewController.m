//
//  MYCollectionViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/21.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYCollectionViewController.h"
#import "UINavigationController+PopGesture.h"

@interface MYCollectionViewController ()
@end

@implementation MYCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configCollectionView];
}

- (void)configCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.contentSize = CGSizeMake(1000, 0);
    collectionView.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:collectionView];
    
    // collectionView需要支持侧滑返回
    [self my_addPopGestureToView:collectionView];
}

@end
