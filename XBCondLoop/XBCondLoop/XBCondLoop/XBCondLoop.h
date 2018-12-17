//
//  XBCondLoop.h
//  FFmpegDemo
//
//  Created by xxb on 2018/12/14.
//  Copyright © 2018年 谢贤彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XBCondLoopDelegate <NSObject>

- (void)executeCondFun;

@end

NS_ASSUME_NONNULL_BEGIN

@interface XBCondLoop : NSObject

@property (nonatomic,weak) id<XBCondLoopDelegate>delegate;

- (void)destroy;

- (void)sendCond;

@end

NS_ASSUME_NONNULL_END
