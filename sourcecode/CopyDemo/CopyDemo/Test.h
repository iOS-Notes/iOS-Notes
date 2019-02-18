//
//  Test.h
//  CopyDemo
//
//  Created by michael on 2019/2/18.
//  Copyright © 2019 michael. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Test : NSObject

@property (nonatomic, strong) NSString *strongString;
@property (nonatomic, copy) NSString *copyedString;

@end

NS_ASSUME_NONNULL_END
