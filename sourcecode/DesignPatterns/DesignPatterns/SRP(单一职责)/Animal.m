//
//  Animal.m
//  DesignPatterns
//
//  Created by michael on 2018/10/27.
//  Copyright © 2018 michael. All rights reserved.
//

#import "Animal.h"

@implementation Animal

//- (void)eatWithAnimalName:(NSString *)animalName {
//    if ([@"羊" isEqualToString:animalName]) {
//        NSLog(@"%@ 吃草", animalName);
//    } else {
//        NSLog(@"%@ 吃肉", animalName);
//    }
//}

- (void)eatGrassWithAnimalName:(NSString *)animalName {
    NSLog(@"%@ 吃草", animalName);
}

- (void)eatMeatWithAnimalName:(NSString *)animalName {
    NSLog(@"%@ 吃肉", animalName);
}

@end
