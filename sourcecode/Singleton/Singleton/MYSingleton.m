//
//  MYSingleton.m
//  Singleton
//
//  Created by sunjinshuai on 2018/5/21.
//  Copyright © 2018年 sunjinshuai. All rights reserved.
//

#import "MYSingleton.h"

@implementation MYSingleton

+ (instancetype)sharedInstance {
    static __weak MYSingleton *_weakInstance;
    __block MYSingleton *_strongInstance = _weakInstance;
    @synchronized(self) {
        if (!_strongInstance) {
            _strongInstance = [[MYSingleton alloc] init];
            _weakInstance = _strongInstance;
        }
    };
    return _strongInstance;
}

- (void)testSingleton {
    
}

- (void)dealloc {
    
    NSLog(@"--- 单例销毁 ---");
}

@end
