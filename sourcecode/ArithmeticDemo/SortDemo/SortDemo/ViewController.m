//
//  ViewController.m
//  SortDemo
//
//  Created by sunjinshuai on 2018/9/16.
//  Copyright © 2018年 sunjinshuai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *tempArray = @[@24, @17, @85, @13, @9, @54, @76, @45, @5, @63];
    [self bubbleAscendingOrderSortWithArray:[NSMutableArray arrayWithArray:tempArray]];
}

// 冒泡排序：
// 最差时间复杂度 O(n^2)
// 平均时间复杂度 O(n^2)
//　　实现思路
//　　1、每一趟比较都比较数组中两个相邻元素的大小
//　　2、如果i元素小于i-1元素，就调换两个元素的位置
//　　3、重复n-1趟的比较
#pragma mark - 冒泡降序排序
- (void)bubbleDescendingOrderSortWithArray:(NSMutableArray *)descendingArr {
    for (int i = 0; i < descendingArr.count; i++) {
        for (int j = 0; j < descendingArr.count - 1 - i; j++) {
            if ([descendingArr[j] intValue] < [descendingArr[j + 1] intValue]) {
                int tmp = [descendingArr[j] intValue];
                descendingArr[j] = descendingArr[j + 1];
                descendingArr[j + 1] = [NSNumber numberWithInt:tmp];
            }
        }
    }
    NSLog(@"冒泡降序排序后结果：%@", descendingArr);
}

#pragma mark - 冒泡升序排序
- (void)bubbleAscendingOrderSortWithArray:(NSMutableArray *)ascendingArr {
    for (int i = 0; i < ascendingArr.count; i++) {
        for (int j = 0; j < ascendingArr.count - 1 - i; j++) {
            if ([ascendingArr[j + 1] intValue] < [ascendingArr[j] intValue]) {
                int temp = [ascendingArr[j] intValue];
                ascendingArr[j] = ascendingArr[j + 1];
                ascendingArr[j + 1] = [NSNumber numberWithInt:temp];
            }
        }
    }
    NSLog(@"冒泡升序排序后结果：%@", ascendingArr);
}

// 选择排序：
// 实现思路：
//    1. 设数组内存放了n个待排数字，数组下标从1开始，到n结束。
//　　 2. i=1
//　　 3. 从数组的第i个元素开始到第n个元素，寻找最小的元素。（具体过程为:先设arr[i]为最小，逐一比较，若遇到比之小的则交换）
//　　 4. 将上一步找到的最小元素和第i位元素交换。
//　　 5. 如果i=n－1算法结束，否则回到第3步

// 平均时间复杂度：O(n^2)
// 平均空间复杂度：O(1)

#pragma mark - 选择升序排序
- (void)selectionAscendingOrderSortWithArray:(NSMutableArray *)ascendingArr {
    for (int i = 0; i < ascendingArr.count; i ++) {
        for (int j = i + 1; j < ascendingArr.count; j ++) {
            if ([ascendingArr[i] integerValue] > [ascendingArr[j] integerValue]) {
                int temp = [ascendingArr[i] intValue];
                ascendingArr[i] = ascendingArr[j];
                ascendingArr[j] = [NSNumber numberWithInt:temp];
            }
        }
    }
    NSLog(@"选择升序排序后结果：%@", ascendingArr);
}

#pragma mark - 选择降序排序
- (void)selectionDescendingOrderSortWithArray:(NSMutableArray *)descendingArr {
    for (int i = 0; i < descendingArr.count; i ++) {
        for (int j = i + 1; j < descendingArr.count; j ++) {
            if ([descendingArr[i] integerValue] < [descendingArr[j] integerValue]) {
                int temp = [descendingArr[i] intValue];
                descendingArr[i] = descendingArr[j];
                descendingArr[j] = [NSNumber numberWithInt:temp];
            }
        }
    }
    NSLog(@"选择降序排序后结果：%@", descendingArr);
}

@end
