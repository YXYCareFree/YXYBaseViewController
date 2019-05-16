//
//  YXYTestViewController.m
//  YXYBaseViewController_Example
//
//  Created by apple on 2018/10/17.
//  Copyright © 2018年 YXYCareFree. All rights reserved.
//

#import "YXYTestViewController.h"
#import "YXYLabel.h"
#import "YXYButton.h"
#import "Masonry.h"
#import "UIView+Helper.h"
#import "YXYTestInteractor.h"
#import "YXYActionSheet.h"
#import "YXYDefine.h"
#import "YXYAlertView.h"
#import "NSString+RegularExpressions.h"
#import "YXYRequest.h"
#import "YXYPickView.h"

@interface YXYTestViewController ()

@property (nonatomic, strong) YXYTestInteractor *interactor;

@end

@implementation YXYTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    YXYButton *btn = YXYButton.new;
    
    [[NSUserDefaults standardUserDefaults] setObject:@[@"qwe"] forKey:@"YXYHideNavBarVC"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self performSelector:@selector(test:) withObject:@12];
    _interactor = YXYTestInteractor.new;
    self.tableView.delegate = _interactor;
    self.tableView.dataSource = _interactor;
    self.refreshDelegate = _interactor;
    _interactor.vc = self;

    YXYActionSheet *sheet = [YXYActionSheet actionSheetWithDataSource:@[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20"] rowHeigh:50 completion:^(NSInteger idx) {
        [YXYAlertView customAlertMessage:@"xsad" confirmTitle:nil confirmColor:nil cancelTitle:nil cancelColor:nil completion:nil];
    }];
    [sheet.btnBottom setTitle:@"取消" forState:UIControlStateNormal];
    [sheet.btnBottom setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    sheet.color = [UIColor blueColor];
    
//    UILabel *label = [[UILabel alloc] init];
//    label.text = @"我是YXYLable";
//    label.font = [UIFont systemFontOfSize:15];
//    label.textColor = [UIColor redColor];
//    label.backgroundColor = [UIColor brownColor];
//    [self.view addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@40);
//        make.left.equalTo(@30);
//        make.width.equalTo(@100);
//        make.height.equalTo(@30);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"%f", label.yxy_w);
//        });
//    }];

//    YXYLabel *lbl = [YXYLabel new];
//    lbl.title(@"我是YXYLable222").titleFont([UIFont systemFontOfSize:15]).color([UIColor redColor]);
//    lbl.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:lbl];
//    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(label);
//        make.width.equalTo(@200);
//        make.height.equalTo(@30);
//        make.left.equalTo(label.mas_right).offset(5);
//        [lbl layoutIfNeeded];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"**%f", lbl.yxy_w);
//        });
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSLog(@"===%f", lbl.yxy_w);
//
//        });
//    }];
    NSLog(@"123");
}

- (void)test:(NSNumber *)str{
    NSLog(@"%@", str);
}

@end
