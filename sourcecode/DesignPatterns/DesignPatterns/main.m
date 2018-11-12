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
#import "BookStore.h"
#import "NovelBook.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        单一职责
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
        
//        里氏替换
//        B *b = [[B alloc] init];
//        NSInteger sub = [b addition:100 b:50];
//        NSInteger difference = [b subtraction:sub b:100];
//        NSLog(@"100+50=%ld", sub);
//        NSLog(@"100+100+50=%ld", difference);
        
//        依赖倒置
//        Mother *mother = [Mother new];
//        Book *book = [Book new];
//        Newspaper *newspaper = [Newspaper new];
//        [mother tellStory:book];
//        [mother tellStory:newspaper];
        
//        迪米特法则
//        Company *company = [Company new];
//        SubCompany *subCompany = [SubCompany new];
//        [company printAllEmployeeWithSubCompany:subCompany];
        
//        开闭原则
//        模拟书店卖书
        BookStore *bookStore = [BookStore new];
        for (NovelBook *novelBook in bookStore.bookArray) {
            NSLog(@"书籍名称：%@ 书籍作者：%@ 书籍价格：%2f", [novelBook bookName], [novelBook bookAuthor], [novelBook bookPrice]);
        }
    }
    return 0;
}

