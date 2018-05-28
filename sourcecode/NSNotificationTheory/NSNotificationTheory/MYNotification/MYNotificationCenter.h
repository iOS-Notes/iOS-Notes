//
//  MYNotificationCenter.h
//  NSNotificationTheory
//
//  Created by QMMac on 2018/5/28.
//  Copyright © 2018年 MYSampleCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYNotification : NSObject <NSCopying, NSCoding>

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, weak, readonly) id object;
@property (nonatomic, copy, readonly) NSDictionary *userInfo;

- (instancetype)initWithName:(NSString *)name
                      object:(nullable id)object
                    userInfo:(nullable NSDictionary *)userInfo;

@end

@interface MYNotificationCenter : NSObject

@property (nonatomic, strong, class, readonly) MYNotificationCenter *defaultCenter;

- (void)addObserver:(id)observer
           selector:(SEL)aSelector
               name:(nullable NSString *)aName
             object:(nullable id)anObject;

- (void)postNotification:(MYNotification *)notification;
- (void)postNotificationName:(NSString *)aName
                      object:(nullable id)anObject;
- (void)postNotificationName:(NSString *)aName
                      object:(nullable id)anObject
                    userInfo:(nullable NSDictionary *)aUserInfo;

- (void)removeObserver:(id)observer;
- (void)removeObserver:(id)observer
                  name:(nullable NSString *)aName
                object:(nullable id)anObject;
- (void)removeObserverId:(NSString *)observerId;

- (id<NSObject>)addObserverForName:(nullable NSString *)name
                            object:(nullable id)obj
                             queue:(nullable NSOperationQueue *)queue
                        usingBlock:(void (^)(MYNotification *note))block;

@end
