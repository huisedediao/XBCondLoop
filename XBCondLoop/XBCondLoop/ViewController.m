//
//  ViewController.m
//  XBCondLoop
//
//  Created by xxb on 2018/12/17.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "ViewController.h"
#import "XBCondLoop.h"

@interface ViewController ()<XBCondLoopDelegate>
@property (nonatomic,strong) XBCondLoop *condLoop;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.condLoop = [[XBCondLoop alloc] init];
    self.condLoop.delegate = self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.condLoop sendCond];
}

- (void)executeCondFun
{
    NSLog(@"executeCondFun");
}

@end
