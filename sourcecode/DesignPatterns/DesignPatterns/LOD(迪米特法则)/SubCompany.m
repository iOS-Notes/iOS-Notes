//
//  SubCompany.m
//  DesignPatterns
//
//  Created by michael on 2018/11/12.
//  Copyright © 2018 michael. All rights reserved.
//

#import "SubCompany.h"
#import "SubEmployeeModel.h"

@implementation SubCompany

- (NSArray *)getAllEmployee {
    NSMutableArray<SubEmployeeModel *> *employeeArray = [NSMutableArray<SubEmployeeModel *> array];
    for (int i =0; i < 3; i++) {
        SubEmployeeModel *employeeModel = [[SubEmployeeModel alloc] init];
        [employeeModel setSubemployee_id:[@(i) stringValue]];
        [employeeArray addObject:employeeModel];
    }
    return employeeArray.copy;
}

@end
