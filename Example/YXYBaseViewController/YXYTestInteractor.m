//
//  YXYTestInteractor.m
//  YXYBaseViewController_Example
//
//  Created by apple on 2018/10/31.
//  Copyright © 2018年 YXYCareFree. All rights reserved.
//

#import "YXYTestInteractor.h"

@implementation YXYTestInteractor

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = UITableViewCell.new;
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (void)YXYVC_PullUpLoadMore:(NSInteger)page completion:(void (^)(BOOL))block{
    block(YES);
}

- (void)YXYVC_PullDownRefreshCompletion:(void (^)(BOOL))block{
    block(YES);
}
@end
