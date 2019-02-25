//
//  main.m
//  __attribute__
//
//  Created by michael on 2019/2/25.
//  Copyright © 2019 michael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Person.h"

__attribute__((constructor))
static void beforeMain(void) {
    NSLog(@"beforeMain");
}

__attribute__((destructor))
static void afterMain(void) {
    NSLog(@"afterMain");
}

int main(int args,char ** argv) {
    
    Person *p = [Person new];
    NSLog(@"%@", p);
    return EXIT_SUCCESS;
}
