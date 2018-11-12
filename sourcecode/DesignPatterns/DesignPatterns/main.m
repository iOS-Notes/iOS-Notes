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
#import "Newspaper.h"
#import "A.h"
#import "B.h"
#import "SubCompany.h"
#import "Company.h"

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
        
//        B *b = [[B alloc] init];
//        NSInteger sub = [b addition:100 b:50];
//        NSInteger difference = [b subtraction:sub b:100];
//        NSLog(@"100+50=%ld", sub);
//        NSLog(@"100+100+50=%ld", difference);

//        Mother *mother = [Mother new];
//        Book *book = [Book new];
//        Newspaper *newspaper = [Newspaper new];
//        [mother tellStory:book];
//        [mother tellStory:newspaper];
        
        Company *company = [Company new];
        SubCompany *subCompany = [SubCompany new];
        [company printAllEmployeeWithSubCompany:subCompany];
    }
    return 0;
}

