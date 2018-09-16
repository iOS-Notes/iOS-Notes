//
//  LinkedList.m
//  LinkedList
//
//  Created by sunjinshuai on 2018/9/16.
//  Copyright © 2018年 sunjinshuai. All rights reserved.
//

#import "LinkedList.h"

@interface LinkedNode ()

@end

@implementation LinkedNode

@end

@interface LinkedList ()

/**
 头节点
 */
@property (nonatomic, strong) LinkedNode *headNode;

@end

@implementation LinkedList

- (void)insertNode:(LinkedNode *)node {
    
    if ([self isNodeExists:node]) {
        return;
    }
    
    if (!_headNode) {
        _headNode = node;
        return;
    }
    
    LinkedNode *lastNode = [self lastNode];
    lastNode.next = node;
}

- (void)insertHeadNode:(LinkedNode *)node {
    
    if ([self isNodeExists:node]) {
        return;
    }
    
    if (_headNode) {
        node.next = _headNode;
        _headNode = node;
    } else {
        _headNode = node;
    }
}

- (void)insertNode:(LinkedNode *)node atIndex:(NSInteger)index {
    if (index < 0 || index > self.length) {
        @throw [NSException exceptionWithName:@"LinkedList is out of bounds" reason:@"Add failed. Illegal index." userInfo:nil];
        return;
    }
    
    
}

- (void)removeNode:(LinkedNode *)node atIndex:(NSInteger)index {
    
}

- (LinkedNode *)objectAtIndex:(NSInteger)index {
    if (index < 0 || index >= self.length) {
        @throw [NSException exceptionWithName:@"LinkedList is out of bounds" reason:@"Add failed. Illegal index." userInfo:nil];
        return nil;
    }
    
    LinkedNode *headNode = _headNode;
    LinkedNode *curNode = nil;
    int i = 0;
    while (headNode) {
        if (i == index) {
            curNode = headNode.next;
            break;
        }
        headNode = headNode.next;
        i++;
    }
    return curNode;
}

- (void)reverse {
    
    LinkedNode *headNode = _headNode;
    LinkedNode *prev = nil;
    LinkedNode *next = nil;
    
    while (headNode) {
        next = headNode.next;
        headNode.next = prev;
        prev = headNode;
        headNode = next;
    }
    _headNode = prev;
}

/**
 获取最后一个节点
 */
- (LinkedNode *)lastNode {
    LinkedNode *lastNode = _headNode;
    while (lastNode.next) {
        lastNode = lastNode.next;
    }
    return lastNode;
}

/**
 判断链表中是否包含当前节点
 */
- (BOOL)isNodeExists:(LinkedNode *)node {
    LinkedNode *tmpNode = _headNode;
    while (tmpNode) {
        if ([tmpNode isEqual:node]) {
            return YES;
        }
        tmpNode = tmpNode.next;
    }
    return NO;
}

- (void)printLog {
    LinkedNode *headNode = _headNode;
    while (headNode) {
        NSLog(@"%@", [NSString stringWithFormat:@"Node:%@", headNode.data]);
        headNode = headNode.next;
    }
}

- (NSInteger)length {
    NSInteger length = 0;
    LinkedNode *headNode = _headNode;
    while (headNode) {
        length++;
        headNode = headNode.next;
    }
    return length;
}

@end
