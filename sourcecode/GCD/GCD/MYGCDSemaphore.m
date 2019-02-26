//
//  MYGCDSemaphore.m
//  GCD
//
//  Created by sunjinshuai on 2018/1/12.
//  Copyright © 2018年 MYSampleCode. All rights reserved.
//

#import "MYGCDSemaphore.h"
#import "MYNetworking.h"

@implementation MYGCDSemaphore

/**
 *  执行场景3:生产者，消费者
 *  生产者持续生产蛋糕，做完消费者立马拿
 */
- (void)testProductAndConsumer {
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    dispatch_queue_t producerQueue = dispatch_queue_create("producer", DISPATCH_QUEUE_CONCURRENT); // 生产者线程跑的队列
    dispatch_queue_t consumerQueue = dispatch_queue_create("consumer", DISPATCH_QUEUE_CONCURRENT); // 消费者线程跑的队列
    
    __block int cakeNumber = 0;
    
    dispatch_async(producerQueue, ^{ //生产者队列
        while (1) {
            if (!dispatch_semaphore_signal(sem)) {
                NSLog(@"Product:生产出了第%d个蛋糕",++cakeNumber);
                sleep(1); //wait for a while
                continue;
            }
        }
    });
    
    dispatch_async(consumerQueue, ^{//消费者队列
        while (1) {
            if (dispatch_semaphore_wait(sem, dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC))) {
                if (cakeNumber > 0) {
                    NSLog(@"Consumer:拿到了第%d个蛋糕",cakeNumber--);
                }
                continue;
            }
        }
    });
}

/**
 *  执行场景1:一个并发数为10的一个线程队列
 *  简单的介绍一下这一段代码，创建了一个初使值为10的semaphore，每一次for循环都会创建一个新的线程，线程结束的时候会发送一个信号，线程创建之前会信号等待，所以当同时创建了10个线程之后(使用Global Dispatch Queue创建的队列(例如下面的方法),其线程数目是不定的,是根据XNU内核决定的)，for循环就会阻塞，等待有线程结束之后会增加一个信号才继续执行，如此就形成了对并发的控制，如上就是一个并发数为10的一个线程队列。
 */
- (void)testSemaphore {
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10); // 信号总量是10
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 50; i++) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);//信号量-1
        dispatch_group_async(group, queue, ^{
            NSLog(@"%i",i);
            sleep(2);
            dispatch_semaphore_signal(semaphore);   //信号量＋1
        });
    }
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}

@end
