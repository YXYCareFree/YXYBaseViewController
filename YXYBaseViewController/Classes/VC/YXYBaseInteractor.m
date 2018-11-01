//
//  YXYBaseInteractor.m
//  AFNetworking
//
//  Created by apple on 2018/10/31.
//

#import "YXYBaseInteractor.h"

@implementation YXYBaseInteractor

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCell.new;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (void)YXYVC_PullUpLoadMore:(NSInteger)page completion:(void (^)(BOOL))block{
    block(YES);
}

- (void)YXYVC_PullDownRefreshCompletion:(void (^)(BOOL))block{
    block(YES);
}
@end
