//
//  BookStore.h
//  DesignPatterns
//
//  Created by michael on 2018/11/12.
//  Copyright © 2018 michael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBookProtocol.h"

@interface BookStore : NSObject

- (NSArray<IBookProtocol> *)bookArray;

- (NSArray<IBookProtocol> *)offBookArray;

@end
