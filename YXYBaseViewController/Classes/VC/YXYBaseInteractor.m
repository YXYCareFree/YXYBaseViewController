//
//  YXYBaseInteractor.m
//  AFNetworking
//
//  Created by apple on 2018/10/31.
//

#import "YXYBaseInteractor.h"

@interface YXYBaseInteractor ()


@end

@implementation YXYBaseInteractor

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCell.new;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (void)loadData:(void (^)(BOOL, id _Nonnull))completion isRefresh:(BOOL)refresh{
    NSAssert(1, @"___该方法必需在子类实现___");
}

- (void)YXYVC_PullDownRefreshCompletion:(void (^)(BOOL))block{
    self.pageNum = [NSString stringWithFormat:@"%ld", self.orignalPageNum];
    self.pn = self.orignalPageNum;
    NSString *temp = self.pageNum;
    if (_tableView) {
        [self.tableView.mj_footer resetNoMoreData];
    }
    [self loadData:^(BOOL success, id  _Nonnull obj) {
        if (success) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:obj];
        }else{
            self.pageNum = temp;
        }
        if (block) {
            block(success);
        }
    } isRefresh:YES];
}

- (void)YXYVC_PullUpLoadMoreCompletion:(void (^)(BOOL))block{
    self.pageNum = [NSString stringWithFormat:@"%ld", ++self.pn];
    [self loadData:^(BOOL success, id  _Nonnull obj) {
        if (success) {
            if (![obj isKindOfClass:[NSArray class]] || !((NSArray *)obj).count) {
                self.pn--;
                if (block) {
                    block(success);
                }
                if (self->_tableView) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                return ;
            }
            
            [self.dataSource addObjectsFromArray:obj];
        }else{
            self.pn--;
        }
        
        if (block) {
            block(success);
        }
    } isRefresh:NO];
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
@end
