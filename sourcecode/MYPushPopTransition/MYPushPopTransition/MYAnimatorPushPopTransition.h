//
//  MYAnimatorPushPopTransition.h
//  MYPushPopTransition
//
//  Created by sunjinshuai on 2018/3/21.
//  Copyright © 2018年 MYPushPopTransition. All rights reserved.
//

#import "MYAnimatorBaseTransition.h"

@interface MYAnimatorPushPopTransition : MYAnimatorBaseTransition

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGPoint itemCenter;
@property (nonatomic, copy) NSString *imageName;

@end
