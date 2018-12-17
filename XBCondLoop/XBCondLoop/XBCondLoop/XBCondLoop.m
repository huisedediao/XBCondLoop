//
//  XBCondLoop.m
//  FFmpegDemo
//
//  Created by xxb on 2018/12/14.
//  Copyright © 2018年 谢贤彬. All rights reserved.
//

#import "XBCondLoop.h"
#import <pthread.h>

@interface XBCondLoop ()
{
    BOOL isNeedLoop;
    pthread_mutex_t lock;
    pthread_cond_t cond;
    pthread_t thread;
}
@end

@implementation XBCondLoop

- (instancetype)init
{
    if (self = [super init])
    {
        isNeedLoop = YES;
        [self initPthread];
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"XBCondLoop 销毁");
}

void * run(void *ptr)
{
    XBCondLoop *condThread = (__bridge XBCondLoop *)ptr;
    [condThread loopExecuteFun];
    return NULL;
}

- (void)loopExecuteFun
{
    while (isNeedLoop)
    {
        pthread_mutex_lock(&lock);
        pthread_cond_wait(&cond, &lock);
        pthread_mutex_unlock(&lock);
        if (self.delegate && [self.delegate respondsToSelector:@selector(executeCondFun)])
        {
            [self.delegate executeCondFun];
        }
    }
}

- (void)initPthread
{
    pthread_mutex_init(&lock, NULL);
    pthread_cond_init(&cond, NULL);
    pthread_create(&thread, NULL, run, (__bridge void *)(self));
}

- (void)destroy
{
    isNeedLoop = NO;
    void* status;
    pthread_mutex_lock(&lock);
    pthread_cond_signal(&cond);
    pthread_mutex_unlock(&lock);
    pthread_join(thread, &status);
    pthread_mutex_destroy(&lock);
    pthread_cond_destroy(&cond);
}

- (void)sendCond
{
    pthread_mutex_lock(&lock);
    pthread_cond_signal(&cond);
    pthread_mutex_unlock(&lock);
}

@end
