//
//  Company.h
//  DesignPatterns
//
//  Created by michael on 2018/11/12.
//  Copyright © 2018 michael. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SubCompany;

NS_ASSUME_NONNULL_BEGIN

@interface Company : NSObject

- (NSArray *)getAllEmployee;

- (void)printAllEmployeeWithSubCompany:(SubCompany *)subCompany;

@end

NS_ASSUME_NONNULL_END
