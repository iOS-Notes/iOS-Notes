//
//  ThreadSafetyObject.h
//  ThreadSafetyArray
//
//  Created by sunjinshuai on 2017/12/29.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThreadSafetyObject : NSObject

@property (nonatomic, strong) NSObject *container;

@end
