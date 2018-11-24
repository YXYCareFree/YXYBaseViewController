//
//  YXYTestInteractor.m
//  YXYBaseViewController_Example
//
//  Created by apple on 2018/10/31.
//  Copyright © 2018年 YXYCareFree. All rights reserved.
//

#import "YXYTestInteractor.h"

@implementation YXYTestInteractor{
    NSMutableArray *_dataSource;
}

- (instancetype)init{
    if (self = [super init]) {
        _dataSource = [NSMutableArray new];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = UITableViewCell.new;
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@", indexPath);
}

- (void)YXYVC_PullUpLoadMore:(NSInteger)page completion:(void (^)(BOOL))block{
    [_dataSource addObject:@"1"];
    block(YES);
}

- (void)YXYVC_PullDownRefreshCompletion:(void (^)(BOOL))block{
    block(YES);
}
@end
