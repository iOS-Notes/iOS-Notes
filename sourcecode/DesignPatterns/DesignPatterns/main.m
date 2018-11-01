//
//  main.m
//  DesignPatterns
//
//  Created by michael on 2018/10/27.
//  Copyright © 2018 michael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Animal.h"
#import "Carnivore.h"
#import "Herbivore.h"
#import "A.h"
#import "B.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        Animal *animal = [Animal new];
//        [animal eatMeatWithAnimalName:@"狼"];
//        [animal eatMeatWithAnimalName:@"豹"];
//        [animal eatMeatWithAnimalName:@"虎"];
//        [animal eatGrassWithAnimalName:@"羊"];
        
//        Animal *carnivore = [Carnivore new];
//        [carnivore eatWithAnimalName:@"狼"];
//        [carnivore eatWithAnimalName:@"豹"];
//        [carnivore eatWithAnimalName:@"虎"];
//        NSLog(@"\n");
//        Animal *herbivore = [Herbivore new];
//        [herbivore eatWithAnimalName:@"羊"];
//        [herbivore eatWithAnimalName:@"马"];
//        [herbivore eatWithAnimalName:@"牛"];
        
        B *b = [[B alloc] init];
        NSInteger sub = [b addition:100 b:50];
        NSInteger difference = [b subtraction:sub b:100];
        NSLog(@"100+50=%ld", sub);
        NSLog(@"100+100+50=%ld", difference);
    }
    return 0;
}

