//
//  MYSingleton.h
//  Singleton
//
//  Created by sunjinshuai on 2018/5/21.
//  Copyright © 2018年 sunjinshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYSingleton : NSObject

+ (instancetype)sharedInstance;

- (void)testSingleton;

@end
