//
//  MYNavigationBar.h
//  MYPushPopTransition
//
//  Created by QMMac on 2018/4/23.
//  Copyright © 2018年 MYPushPopTransition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYNavigationBar : UINavigationBar

@property (nonatomic, strong, readonly) UIImageView *shadowImageView;
@property (nonatomic, strong, readonly) UIVisualEffectView *fakeView;

@end
