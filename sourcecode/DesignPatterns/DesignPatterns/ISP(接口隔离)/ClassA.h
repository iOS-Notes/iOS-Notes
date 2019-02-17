//
//  ClassA.h
//  DesignPatterns
//
//  Created by michael on 2018/11/10.
//  Copyright © 2018 michael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InterfaceH.h"

@interface ClassA : NSObject

- (void)depend:(NSObject<InterfaceH1> *)classB;

@end
