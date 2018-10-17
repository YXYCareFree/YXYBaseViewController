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
    
    YXYLabel *lbl = [YXYLabel new];
    lbl.title(@"我是YXYLable").titleFont([UIFont systemFontOfSize:15]).color([UIColor redColor]);
    [self.view addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
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
