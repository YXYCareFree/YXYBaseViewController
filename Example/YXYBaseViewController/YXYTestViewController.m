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

@interface YXYTestViewController ()<UITableViewDelegate, UITableViewDataSource, YXYBaseViewControlerRefreshDelegate>

@end

@implementation YXYTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor yellowColor];
    [[NSUserDefaults standardUserDefaults] setObject:@[@"qwe"] forKey:@"YXYHideNavBarVC"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.refreshDelegate = self;
    
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
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%f, %f, %f, %@", lbl.yxy_x, lbl.yxy_cy, lbl.center.x, NSStringFromCGRect(lbl.frame));
            NSLog(@"22==%f, %f, %f, %@", label.yxy_x, label.yxy_cy, label.center.x, NSStringFromCGRect(label.frame));
        });
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (void)YXYVC_PullUpLoadMore:(NSInteger)page completion:(void (^)(BOOL))block{
    block(YES);
}

- (void)YXYVC_PullDownRefreshCompletion:(void (^)(BOOL))block{
    block(YES);
}

@end
