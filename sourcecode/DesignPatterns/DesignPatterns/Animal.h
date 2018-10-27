//
//  Animal.h
//  DesignPatterns
//
//  Created by michael on 2018/10/27.
//  Copyright © 2018 michael. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Animal : NSObject

/**
 *  动物名称
 */
@property (nonatomic, copy) NSString *animalName;

/**
 *  吃草
 */
- (void)eatGrassWithAnimalName:(NSString *)animalName;

/**
 *  吃肉
 */
- (void)eatMeatWithAnimalName:(NSString *)animalName;

@end

NS_ASSUME_NONNULL_END
