//
//  TestClass.h
//  MYSampleCode
//
//  Created by sunjinshuai on 2017/11/23.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TestClassDelegate <NSObject>

- (void)testProtocol1;
- (void)testProtocol2;

@end

@interface TestClass : NSObject

@property (nonatomic, strong) NSArray *publicProperty1;
@property (nonatomic, copy) NSString *publicProperty2;
@property (nonatomic, weak) id<TestClassDelegate> delegate;

+ (void)classMethod:(NSString *)value;
- (void)publicTestMethod1:(NSString *)value1 second:(NSString *)value2;
- (void)publicTestMethod2;

- (void)method1;

@end
