//
//  TableViewCellModel.m
//  DragAndDropDemo
//
//  Created by sunjinshuai on 2018/3/1.
//  Copyright © 2018年 DragAndDropDemo. All rights reserved.
//

#import "TableViewCellModel.h"

@implementation TableViewCellModel

- (instancetype)initWithTitleString:(NSString *)titleString {
    self = [super init];
    if (self) {
        
        self.titleString = titleString;
    }
    return self;
}

#pragma mark - Item Provider Reading Protocol
+ (nullable instancetype)objectWithItemProviderData:(NSData *)data
                                     typeIdentifier:(NSString *)typeIdentifier
                                              error:(NSError **)outError {
    if ([typeIdentifier isEqualToString:@"com.DragAndDropDemo.model"]) {
        
        TableViewCellModel *modelData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        return [[self alloc] initWithTitleString:modelData.titleString];
    }
    return nil;
}

+ (NSArray<NSString *> *)readableTypeIdentifiersForItemProvider {
    
    return @[@"com.DragAndDropDemo.model"];
}

#pragma mark - Item Provider Writing Protocol
- (nullable NSProgress *)loadDataWithTypeIdentifier:(NSString *)typeIdentifier
                   forItemProviderCompletionHandler:(void (^)(NSData * _Nullable data, NSError * _Nullable error))completionHandler {
    
    if ([typeIdentifier isEqualToString:@"com.DragAndDropDemo.model"]) {
        
        NSData *modelData = [NSKeyedArchiver archivedDataWithRootObject:self];
        
        completionHandler(modelData, nil);
    }
    return nil;
}

+ (NSArray<NSString *> *)writableTypeIdentifiersForItemProvider {
    
    return @[@"com.DragAndDropDemo.model"];
}

@end
