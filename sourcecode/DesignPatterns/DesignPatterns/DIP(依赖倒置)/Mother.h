//
//  Mother.h
//  DesignPatterns
//
//  Created by michael on 2018/11/9.
//  Copyright © 2018 michael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IReaderProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface Mother : NSObject

/**
 讲故事
 */
- (void)tellStory:(NSObject<IReaderProtocol> *)reading;

@end

NS_ASSUME_NONNULL_END
