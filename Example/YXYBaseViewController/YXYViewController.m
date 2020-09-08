//
//  YXYViewController.m
//  YXYBaseViewController_Example
//
//  Created by yxy on 2020/8/6.
//  Copyright © 2020 YXYCareFree. All rights reserved.
//

#import "YXYViewController.h"
#import "YXYGCDTimer.h"
#import "YXYTimerProxy.h"
#import "YXYTimer.h"

@interface YXYViewController ()

@property (nonatomic, strong) YXYGCDTimer *gcdTimer;
@property (nonatomic, strong) NSTimer *sysTimer;
@property (nonatomic, strong) YXYTimer *yxyTimer;

@end

@implementation YXYViewController

- (void)dealloc
{
    NSLog(@"dealloc");
    [_sysTimer invalidate];
//    [_timer cancel];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [_timer cancel];
//    NSLog(@"cancel");
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.whiteColor;
    _gcdTimer = [YXYGCDTimer initWithSelector:@selector(run) target:self timeInterval:1];
    [_gcdTimer resume];
    
//    _sysTimer = [NSTimer timerWithTimeInterval:1 target:[YXYTimerProxy initWithTarget:self] selector:@selector(run) userInfo:nil repeats:YES];
//    __weak YXYViewController *w = self;
////  _sysTimer = [NSTimer timerWithTimeInterval:1 target:w selector:@selector(run) userInfo:nil repeats:YES];
//
//    [_sysTimer fire];
//    [NSRunLoop.currentRunLoop addTimer:_sysTimer forMode:NSRunLoopCommonModes];
    
    
//    _yxyTimer = [YXYTimer timerWithTarget:self sel:@selector(run) duration:1];
    
    [self.navigationController pushViewController:UIViewController.new animated:YES];
}

- (void)run{
    NSLog(@"run %@", self.title);
}


@end
