//
//  EnumeratorViewController.m
//  iOSSkills
//
//  Created by QMMac on 2018/6/4.
//  Copyright © 2018年 QMMac. All rights reserved.
//

#import "EnumeratorViewController.h"
#import "Header.h"

@interface EnumeratorViewController ()

@end

@implementation EnumeratorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *numbers = @[@9, @5, @11, @3, @1];
    NSMutableArray *mutableArray = [NSMutableArray array];
    /// 使用indexesOfObjectsWithOptions:passingTest:
    /// 2018-06-04 13:58:41.803708+0800 iOSSkills[18811:204816] Time: 0.000102
    NSIndexSet *indexes = [numbers indexesOfObjectsWithOptions:NSEnumerationConcurrent
                                                   passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
                                                       return YES;
                                                   }];
    NSArray *filteredArray = [numbers objectsAtIndexes:indexes];
    
    /// 传统的枚举
    /// 2018-06-04 14:00:19.563798+0800 iOSSkills[18869:206677] Time: 0.000023
    for (id obj in numbers) {
        [mutableArray addObject:obj];
    }
    
    /// block方式枚举
    /// 2018-06-04 14:01:36.164621+0800 iOSSkills[18925:208293] Time: 0.000013
    [numbers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [mutableArray addObject:obj];
    }];
    
    /// 通过下标objectAtIndex:
    /// 2018-06-04 14:02:43.130110+0800 iOSSkills[18972:209715] Time: 0.000012
    for (NSUInteger idx = 0; idx < numbers.count; idx++) {
        id obj = numbers[idx];
        [mutableArray addObject:obj];
    }
    
    /// 使用比较传统的学院派NSEnumerator
    /// 2018-06-04 14:03:37.260833+0800 iOSSkills[19008:210954] Time: 0.000026
    NSEnumerator *enumerator = [numbers objectEnumerator];
    id obj = nil;
    while ((obj = [enumerator nextObject]) != nil) {
        [mutableArray addObject:obj];
    }
    
    /// 使用predicate
    /// 2018-06-04 14:04:32.029312+0800 iOSSkills[19058:212303] Time: 0.000017
    TICK
    NSArray *filteredArray2 = [numbers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id obj, NSDictionary *bindings) {
        return YES;
    }]];
    TOCK
    NSLog(@"%@",filteredArray2);
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
