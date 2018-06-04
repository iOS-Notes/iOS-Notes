//
//  BinarySearchViewController.m
//  iOSSkills
//
//  Created by QMMac on 2018/6/4.
//  Copyright © 2018年 QMMac. All rights reserved.
//

#import "BinarySearchViewController.h"

@interface BinarySearchViewController ()

@end

@implementation BinarySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *numbers = @[@9, @5, @11, @3, @1];
    
    NSArray *sortedArray3 = [numbers sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    id searchObject = @5;
    NSRange searchRange = NSMakeRange(0, [sortedArray3 count]);
    NSUInteger findIndex = [sortedArray3 indexOfObject:searchObject inSortedRange:searchRange options:NSBinarySearchingInsertionIndex usingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    NSLog(@"findIndex：%lu",(unsigned long)findIndex);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
