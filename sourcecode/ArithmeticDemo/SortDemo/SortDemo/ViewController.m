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
    [self quickSortArray:[NSMutableArray arrayWithArray:tempArray] leftIndex:0 rightIndex:tempArray.count - 1];
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
    for (int i = 0; i < descendingArr.count - 1; i++) {
        for (int j = 0; j < descendingArr.count - i - 1; j++) {
            if ([descendingArr[j + 1] integerValue] > [descendingArr[j] integerValue]) {
                [descendingArr exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
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
                [ascendingArr exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
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
    for (int i = 0; i < descendingArr.count; i++) {
        for (int j = i + 1; j < descendingArr.count; j++) {
            if ([descendingArr[j] integerValue] < [descendingArr[i] integerValue]) {
                [descendingArr exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    NSLog(@"选择降序排序后结果：%@", descendingArr);
}

#pragma mark - 插入排序
- (void)insertOrderSortWithArray:(NSMutableArray *)array {
    NSInteger j;
    for (int i = 0; i < array.count; i++) {
        NSInteger temp = [array[i] integerValue];
        
        for (j = i - 1; j >= 0 && temp < [array[j] integerValue]; j--) {
            
            array[j + 1] = array[j];
            array[j] = @(temp);
        }
    }
    NSLog(@"插入排序后结果：%@", array);
}

#pragma mark - 快速排序
- (void)quickSortArray:(NSMutableArray *)array
             leftIndex:(NSInteger)left
            rightIndex:(NSInteger)right {
    
    if (left > right) {
        return;
    }
    
    NSInteger i = left;
    NSInteger j = right;
    
    // 记录基准数 pivoty
    NSInteger key = [array[i] integerValue];
    
    while (i < j) {
        
        // 首先从右边j开始查找(从最右边往左找)比基准数(key)小的值<---
        while (i < j && key <= [array[j] integerValue]) {
            j--;
        }
        
        // 如果从右边j开始查找的值[array[j] integerValue]比基准数小，则将查找的小值调换到i的位置
        if (i < j) {
            array[i] = array[j];
        }
        
        // 从i的右边往右查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 --->
        while (i < j && [array[i] integerValue] <= key) {
            i++;
        }
        // 如果从i的右边往右查找的值[array[i] integerValue]比基准数大，则将查找的大值调换到j的位置
        if (i < j) {
            array[j] = array[i];
        }
        
    }
    // 将基准数放到正确的位置，----改变的是基准值的位置(数组下标)---
    array[i] = @(key);
    // 递归排序
    // 将i左边的数重新排序
    [self quickSortArray:array leftIndex:left rightIndex:i - 1];
    // 将i右边的数重新排序
    [self quickSortArray:array leftIndex:i + 1 rightIndex:right];
    
    NSLog(@"快速排序后结果：%@", array);
}

@end
