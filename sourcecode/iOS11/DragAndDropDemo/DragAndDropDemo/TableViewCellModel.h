//
//  TableViewCellModel.h
//  DragAndDropDemo
//
//  Created by sunjinshuai on 2018/3/1.
//  Copyright © 2018年 DragAndDropDemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableViewCellModel : NSObject <NSItemProviderReading, NSItemProviderWriting>

- (instancetype)initWithTitleString:(NSString *)titleString;

@property (nonatomic, copy) NSString *titleString;

@end
