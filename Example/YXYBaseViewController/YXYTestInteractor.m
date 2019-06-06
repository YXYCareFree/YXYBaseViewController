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
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@", indexPath);
}

- (void)loadData:(void (^)(BOOL, id))completion isRefresh:(BOOL)refresh{
    if (completion) {
        completion(YES, @[@"dasd"]);
    }
}
@end
