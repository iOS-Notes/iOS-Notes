//
//  TableViewCellModel.m
//  PasteConfiguration
//
//  Created by sunjinshuai on 2018/3/1.
//  Copyright © 2018年 PasteConfiguration. All rights reserved.
//

#import "TableViewCellModel.h"

@implementation TableViewCellModel

@dynamic readableTypeIdentifiersForItemProvider;

- (instancetype)initTitleString:(NSString *)title {
    self = [super init];
    if (self) {
        self.titleString = title;
    }
    return self;
}

+ (instancetype)objectWithItemProviderData:(NSData *)data
                            typeIdentifier:(NSString *)typeIdentifier
                                     error:(NSError * _Nullable __autoreleasing *)outError {
    
    if ([typeIdentifier isEqualToString:@"com.PasteConfiguration.cellType"]) {
        TableViewCellModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return [[self alloc] initTitleString:model.titleString];
    }
    return nil;
}

+ (NSArray *)readableTypeIdentifiersForItemProvider {
    return @[@"com.PasteConfiguration.cellType"];
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    
    [aCoder encodeObject:self.titleString forKey:@"titleString"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        
        self.titleString = [aDecoder decodeObjectForKey:@"titleString"];
    }
    return self;
}

@end
