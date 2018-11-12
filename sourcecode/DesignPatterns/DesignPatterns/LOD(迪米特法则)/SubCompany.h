//
//  SubCompany.h
//  DesignPatterns
//
//  Created by michael on 2018/11/12.
//  Copyright © 2018 michael. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SubCompany : NSObject

/**
 获取所有分公司员工
 */
- (NSArray *)getAllEmployee;

/**
 打印分公司所有员工
 */
- (void)printAllEmployee;

@end

NS_ASSUME_NONNULL_END
