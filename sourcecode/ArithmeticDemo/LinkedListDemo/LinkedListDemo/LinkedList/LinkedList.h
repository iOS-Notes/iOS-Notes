//
//  LinkedList.h
//  LinkedList
//
//  Created by sunjinshuai on 2018/9/16.
//  Copyright © 2018年 sunjinshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LinkedNode : NSObject

/**
 下一个节点的引用
 */
@property (nonatomic, strong) LinkedNode *next;

/**
 节点的值
 */
@property (nonatomic, strong) id data;

@end

@interface LinkedList : NSObject

@property (nonatomic, assign, readonly) NSInteger length;

/**
 向链表中插入数据
 */
- (void)insertNode:(LinkedNode *)node;

/**
 向链表中头节点的位置插入数据
 */
- (void)insertHeadNode:(LinkedNode *)node;

- (LinkedNode *)objectAtIndex:(NSInteger)index;

/**
 根据 index 向链表中插入数据
 */
- (void)insertNode:(LinkedNode *)node atIndex:(NSInteger)index;

/**
 删除节点
 */
- (void)removeNode:(LinkedNode *)node atIndex:(NSInteger)index;

/**
 翻转链表
 */
- (void)reverse;

/**
 打印日志
 */
- (void)printLog;

@end
