//
//  AppFluecyMonitor.h
//  AppFluecyMonitor
//
//  Created by michael on 2019/2/28.
//  Copyright © 2019 michael. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define SHAREDMONITOR [AppFluecyMonitor sharedMonitor]


/*!
 *  @brief  监听UI线程卡顿
 */
@interface AppFluecyMonitor : NSObject

+ (instancetype)sharedMonitor;

- (void)startMonitoring;
- (void)stopMonitoring;

@end

NS_ASSUME_NONNULL_END
