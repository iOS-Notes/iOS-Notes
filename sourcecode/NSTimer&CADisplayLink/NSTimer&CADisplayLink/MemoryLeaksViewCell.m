//
//  MemoryLeaksViewCell.m
//  NSTimer&CADisplayLink
//
//  Created by QMMac on 2018/6/7.
//  Copyright © 2018 NSTimer&CADisplayLink. All rights reserved.
//

#import "MemoryLeaksViewCell.h"

@interface MemoryLeaksViewCell()

@property (nonatomic, strong) CADisplayLink *link;

@end

@implementation MemoryLeaksViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        dispatch_queue_t disqueue =  dispatch_queue_create("com.countdown", DISPATCH_QUEUE_CONCURRENT);
        dispatch_group_t disgroup = dispatch_group_create();
        dispatch_group_async(disgroup, disqueue, ^{
            self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(countDown)];
            [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        });
    }
    return self;
}

- (void)countDown {
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = @"HH:mm:ss";
    self.detailTextLabel.text = [NSString stringWithFormat:@"倒计时%@", [dateformatter stringFromDate:[NSDate date]]];
}

- (void)removeTimer {
    [self.link invalidate];
}

- (void)dealloc {
    
    NSLog(@"%@_%s", self.class, __func__);
}

@end
