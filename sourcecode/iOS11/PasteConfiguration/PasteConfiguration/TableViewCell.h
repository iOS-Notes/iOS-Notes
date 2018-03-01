//
//  TableViewCell.h
//  PasteConfiguration
//
//  Created by sunjinshuai on 2018/3/1.
//  Copyright © 2018年 PasteConfiguration. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TableViewCellModel;

@interface TableViewCell : UITableViewCell

@property (nonatomic, strong) TableViewCellModel *model;

@end
