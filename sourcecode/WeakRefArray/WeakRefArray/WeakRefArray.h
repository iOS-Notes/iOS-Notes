//
//  WeakRefArray.h
//  WeakRefArray
//
//  Created by sunjinshuai on 2018/4/8.
//  Copyright © 2018年 WeakRefArray. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeakRefArray<ObjectType>: NSObject<NSCopying, NSSecureCoding, NSFastEnumeration>

- (instancetype)initWithCapacity:(NSUInteger)capacity;
+ (instancetype)array;
+ (instancetype)arrayWithCapacity:(NSUInteger)capacity;

- (void)addObject:(ObjectType)object;
- (void)insertObject:(ObjectType)object atIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(ObjectType)object;
- (void)removeObject:(ObjectType)object;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)removeAllObjects;
- (ObjectType)objectAtIndex:(NSUInteger)index;
- (ObjectType)firstObject;
- (ObjectType)lastObject;
- (NSUInteger)indexOfObject:(ObjectType)object;
- (NSUInteger)count;

@end
