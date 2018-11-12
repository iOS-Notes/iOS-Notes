//
//  Company.m
//  DesignPatterns
//
//  Created by michael on 2018/11/12.
//  Copyright © 2018 michael. All rights reserved.
//

#import "Company.h"
#import "SubCompany.h"
#import "EmployeeModel.h"

@implementation Company

- (NSArray *)getAllEmployee {
    NSMutableArray<EmployeeModel *> *employeeArray = [NSMutableArray<EmployeeModel *> array];
    for (int i =0; i < 3; i++) {
        EmployeeModel *employeeModel = [[EmployeeModel alloc] init];
        [employeeModel setEmployee_id:[@(i) stringValue]];
        [employeeArray addObject:employeeModel];
    }
    return employeeArray.copy;
}

- (void)printAllEmployeeWithSubCompany:(SubCompany *)subCompany {
    // 分公司员工
    [subCompany printAllEmployee];
    
    // 总公司员工
    NSArray<EmployeeModel *> *employeeArray = self.getAllEmployee;
    for (EmployeeModel *employeeModel in employeeArray) {
        NSLog(@"总公司员工ID:%@", employeeModel.employee_id);
    }
}

@end
