//
//  ViewController+Attribute.m
//  CategoryDemo
//
//  Created by michael on 2019/2/18.
//  Copyright © 2019 sunjinshuai. All rights reserved.
//

#import "ViewController+Attribute.h"
#import <objc/runtime.h>

static char *attributeNameKey;

@implementation ViewController (Attribute)

- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, &attributeNameKey, name, OBJC_ASSOCIATION_COPY);
}

- (NSString *)name {
    return objc_getAssociatedObject(self, &attributeNameKey);
}

@end
