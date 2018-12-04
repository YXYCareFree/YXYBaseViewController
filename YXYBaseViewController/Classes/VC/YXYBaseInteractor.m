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

- (void)loadData:(void(^)(BOOL success, id obj))completion{
    NSAssert(1, @"___该方法必需在子类实现___");
}

- (void)YXYVC_PullDownRefreshCompletion:(void (^)(BOOL))block{
    NSString *temp = self.pageNum;
    self.pageNum = [NSString stringWithFormat:@"%ld", self.orignalPageNum];
    [self loadData:^(BOOL success, id obj) {
        if (success) {
            self.dataSource = [NSMutableArray arrayWithArray:obj];
        }else{
            self.pageNum = temp;
        }
        if (block) {
            block(success);
        }
    }];
}

- (void)YXYVC_PullUpLoadMore:(NSInteger)page completion:(void (^)(BOOL))block{
    self.pageNum = [NSString stringWithFormat:@"%ld", ++self.pn];
    [self loadData:^(BOOL success, id obj) {
        if (success) {
            if (![obj isKindOfClass:[NSArray class]] || !((NSArray *)obj).count) {
                self.pn--;
                if (block) {
                    block(success);
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
    }];
}

- (NSMutableArray *)dataSource1{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
@end
