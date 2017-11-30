//
//  MYStringFormatManager.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/24.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYStringFormatManager.h"
#import <objc/runtime.h>

@implementation MYStringFormatManager

+ (instancetype)shareManager {
    static MYStringFormatManager *_shareManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareManager = [[MYStringFormatManager alloc] init];
    });
    return _shareManager;
}

- (NSArray *)allProperties:(id)obj {
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        [propertiesArray addObject:name];
    }
    free(properties);
    return propertiesArray;
}


- (NSMutableArray *)orderArray:(NSMutableArray *)array orderBy:(NSString *)attributeName {
    if (![[self allProperties:[array firstObject]] containsObject:attributeName]) {
        return array;
    }
    
    for (id objModel in array) {
        if (![objModel valueForKey:attributeName]) {
            [objModel setValue:@"" forKey:attributeName];
        }
    }
    
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    NSUInteger numberOfSections = [[collation sectionTitles] count];
    NSMutableArray *newSectionArray = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < numberOfSections; index++) {
        [newSectionArray addObject:[[NSMutableArray alloc] init]];
    }
    for (id model in array) {
        NSUInteger sectionIndex = [collation sectionForObject:model collationStringSelector:NSSelectorFromString(attributeName)];
        [newSectionArray[sectionIndex] addObject:model];
    }
    for (NSUInteger index = 0; index < numberOfSections; index++) {
        NSMutableArray *personsForSection = newSectionArray[index];
        NSArray *sortedPersonsForSection = [collation sortedArrayFromArray:personsForSection collationStringSelector:NSSelectorFromString(attributeName)];
        newSectionArray[index] = sortedPersonsForSection;
    }
    NSMutableArray *backAry = [NSMutableArray array];
    for (NSMutableArray *muary in newSectionArray) {
        if (muary.count != 0) {
            [backAry addObject:muary];
        }
    }
    return backAry;
}

- (NSMutableArray *)getSectionArray:(NSMutableArray *)array orderBy:(NSString *)attributeName {
    if (![[array firstObject] isKindOfClass:[NSArray class]]) {
        return array;
    }
    
    if (![[self allProperties:[[array firstObject] firstObject]] containsObject:attributeName]) {
        return array;
    }
    
    NSMutableArray *section = [[NSMutableArray alloc] init];
    for (NSArray *item in array) {
        if (![item isKindOfClass:[NSArray class]]) {
            return nil;
        }
        if (item.count == 0) {
            return nil;
        }
        id obj = [item objectAtIndex:0];
        char c;
        if ([obj isKindOfClass:[NSString class]]) {
            c = [[self pinyinWithString:(NSString *)obj] characterAtIndex:0];
        } else {
            NSString *name;
            name = (NSString *)[obj valueForKey:attributeName];
            if (name.length == 0) {
                c = '#';
            } else {
                c = [[self pinyinWithString:name] characterAtIndex:0];
            }
        }
        if (!isalpha(c)) {
            c = '#';
        }
        [section addObject:[NSString stringWithFormat:@"%c", toupper(c)]];
    }
    return section;
}

- (NSString *)pinyinWithString:(NSString *)string {
    NSMutableString *backStr = [string mutableCopy];
    if (backStr == nil) {
        backStr = [NSMutableString string];
    }
    CFStringTransform((CFMutableStringRef)backStr, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)backStr, NULL, kCFStringTransformStripDiacritics, NO);
    return [[backStr stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
}

@end
