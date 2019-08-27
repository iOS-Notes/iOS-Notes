//
//  NSString+MYJSONModel.m
//  RunTime
//
//  Created by sunjinshuai on 2018/1/3.
//  Copyright © 2018年 MYSampleCode. All rights reserved.
//

#import "NSString+MYJSONModel.h"

@implementation NSString (MYJSONModel)

- (NSString *)my_underlineFromCamel {
    if (self.length == 0) {
        return self;
    }
    NSMutableString *string = [NSMutableString string];
    for (NSUInteger i = 0; i<self.length; i++) {
        unichar c = [self characterAtIndex:i];
        NSString *cString = [NSString stringWithFormat:@"%c", c];
        NSString *cStringLower = [cString lowercaseString];
        if ([cString isEqualToString:cStringLower]) {
            [string appendString:cStringLower];
        } else {
            [string appendString:@"_"];
            [string appendString:cStringLower];
        }
    }
    return string;
}

- (NSString *)my_camelFromUnderline {
    if (self.length == 0) {
        return self;
    }
    NSMutableString *string = [NSMutableString string];
    NSArray *cmps = [self componentsSeparatedByString:@"_"];
    for (NSUInteger i = 0; i<cmps.count; i++) {
        NSString *cmp = cmps[i];
        if (i && cmp.length) {
            [string appendString:[NSString stringWithFormat:@"%c", [cmp characterAtIndex:0]].uppercaseString];
            if (cmp.length >= 2) {
                [string appendString:[cmp substringFromIndex:1]];
            }
        } else {
            [string appendString:cmp];
        }
    }
    return string;
}

- (NSString *)my_firstCharLower {
    if (self.length == 0) {
        return self;
    }
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"%c", [self characterAtIndex:0]].lowercaseString];
    if (self.length >= 2) {
        [string appendString:[self substringFromIndex:1]];
    }
    return string;
}

- (NSString *)my_firstCharUpper {
    if (self.length == 0) {
        return self;
    }
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"%c", [self characterAtIndex:0]].uppercaseString];
    if (self.length >= 2) {
        [string appendString:[self substringFromIndex:1]];
    }
    return string;
}

- (BOOL)my_isPureInt {
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (NSURL *)my_url {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    return [NSURL URLWithString:(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL,kCFStringEncodingUTF8))];
#pragma clang diagnostic pop
}

@end
