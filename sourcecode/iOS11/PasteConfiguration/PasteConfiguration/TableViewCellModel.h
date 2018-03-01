//
//  TableViewCellModel.h
//  PasteConfiguration
//
//  Created by sunjinshuai on 2018/3/1.
//  Copyright © 2018年 PasteConfiguration. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableViewCellModel : NSObject <NSItemProviderReading, NSCoding>

- (instancetype)initTitleString:(NSString *)title;

@property (nonatomic, copy) NSString *titleString;

@end
