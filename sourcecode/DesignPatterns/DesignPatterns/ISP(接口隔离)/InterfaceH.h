//
//  InterfaceH.h
//  DesignPatterns
//
//  Created by michael on 2018/11/10.
//  Copyright © 2018 michael. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol InterfaceH <NSObject>

- (void)method5;

@end

@protocol InterfaceH1 <InterfaceH>

- (void)method1;
- (void)method2;

@end

@protocol InterfaceH2 <InterfaceH>

- (void)method3;
- (void)method4;

@end

