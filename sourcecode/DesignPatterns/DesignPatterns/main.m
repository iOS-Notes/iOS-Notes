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
#import "Mother.h"
#import "Book.h"

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

//        Animal *herbivore = [Herbivore new];
//        [herbivore eatWithAnimalName:@"羊"];
//        [herbivore eatWithAnimalName:@"马"];
//        [herbivore eatWithAnimalName:@"牛"];
        
        Mother *mother = [Mother new];
        Book *book = [Book new];
        [mother tellStory:book];
    }
    return 0;
}

