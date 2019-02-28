//
//  BacktraceLogger.h
//  AppFluecyMonitor
//
//  Created by michael on 2019/2/28.
//  Copyright © 2019 michael. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  @brief  线程堆栈上下文输出
 */
@interface BacktraceLogger : NSObject

+ (NSString *)backtraceOfAllThread;
+ (NSString *)backtraceOfMainThread;
+ (NSString *)backtraceOfCurrentThread;
+ (NSString *)backtraceOfNSThread:(NSThread *)thread;

+ (void)logMain;
+ (void)logCurrent;
+ (void)logAllThread;

@end

NS_ASSUME_NONNULL_END
