//
//  YXYBaseInteractor.m
//  AFNetworking
//
//  Created by apple on 2018/10/31.
//

#import "YXYBaseInteractor.h"

@interface YXYBaseInteractor ()

@property (nonatomic, strong) NSString *orignalPageNum;

@end

@implementation YXYBaseInteractor

- (void)setPageNum:(NSString *)pageNum{
    _pageNum = pageNum;
    self.orignalPageNum = pageNum;
}

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
    [self loadData:^(BOOL success, id obj) {
        if (success) {
            self.dataSource = [NSMutableArray arrayWithArray:obj];
            self.pageNum = self.orignalPageNum;
        }
        if (block) {
            block(success);
        }
    }];
}

- (void)YXYVC_PullUpLoadMore:(NSInteger)page completion:(void (^)(BOOL))block{
    int pageNum = [self.pageNum intValue];
    self.pageNum = [NSString stringWithFormat:@"%d", ++pageNum];
    [self loadData:^(BOOL success, id obj) {
        if (success) {
            if (![obj isKindOfClass:[NSArray class]] || !((NSArray *)obj).count) {
                int pageNum = [self.pageNum intValue];
                self.pageNum = [NSString stringWithFormat:@"%d", --pageNum];
                if (block) {
                    block(success);
                }
                return ;
            }
            [self.dataSource addObjectsFromArray:obj];
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
