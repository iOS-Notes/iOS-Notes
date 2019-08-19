//
//  ViewController.m
//  KVCTest
//
//  Created by michael on 2019/2/22.
//  Copyright © 2019 michael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BankAccount.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        BankAccount *account = [BankAccount new];
        NSLog(@"name:%@", [account valueForKey:@"name"]);
        NSLog(@"age:%@", [account valueForKey:@"age"]);
    }
    return 0;
}
