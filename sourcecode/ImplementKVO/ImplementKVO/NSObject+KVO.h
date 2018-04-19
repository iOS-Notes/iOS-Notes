//
//  NSObject+KVO.h
//  ImplementKVO
//
//  Created by sunjinshuai on 2018/4/19.
//  Copyright © 2018年 KVO. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ObservingBlock)(id observedObject, NSString *observedKey, id oldValue, id newValue);

@interface NSObject (KVO)

- (void)addObserver:(NSObject *)observer
                forKey:(NSString *)key
             withBlock:(ObservingBlock)block;

- (void)removeObserver:(NSObject *)observer forKey:(NSString *)key;


@end
