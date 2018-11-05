//
//  YXYTestViewController.m
//  YXYBaseViewController_Example
//
//  Created by apple on 2018/10/17.
//  Copyright © 2018年 YXYCareFree. All rights reserved.
//

#import "YXYTestViewController.h"
#import "YXYLabel.h"
#import "Masonry.h"
#import "UIView+Helper.h"
#import "YXYTestInteractor.h"

@interface YXYTestViewController ()

@property (nonatomic, strong) YXYTestInteractor *interactor;

@end

@implementation YXYTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    void(^GlobalBlock)() = ^{
        
    };
    NSLog(@"%@", [GlobalBlock class]);
    
    
    
    
    self.view.backgroundColor = [UIColor yellowColor];
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
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"我是YXYLable";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor redColor];
    label.backgroundColor = [UIColor brownColor];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@40);
        make.left.equalTo(@30);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];

    YXYLabel *lbl = [YXYLabel new];
    lbl.title(@"我是YXYLable222").titleFont([UIFont systemFontOfSize:15]).color([UIColor redColor]);
    lbl.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label);
        make.width.equalTo(@200);
        make.height.equalTo(@30);
        make.left.equalTo(label.mas_right).offset(5);
    }];
}

- (void)test:(NSNumber *)str{
    NSLog(@"%@", str);
}

@end
