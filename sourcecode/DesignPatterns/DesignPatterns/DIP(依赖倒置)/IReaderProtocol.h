//
//  IReaderProtocol.h
//  DesignPatterns
//
//  Created by michael on 2018/11/9.
//  Copyright © 2018 michael. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IReaderProtocol <NSObject>

/**
 故事内容
 */
- (void)theStoryContent;

@end

NS_ASSUME_NONNULL_END
