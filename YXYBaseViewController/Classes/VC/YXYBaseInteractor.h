//
//  YXYBaseInteractor.h
//  AFNetworking
//
//  Created by apple on 2018/10/31.
//

#import <Foundation/Foundation.h>
#import "YXYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YXYBaseInteractor : NSObject<UITableViewDelegate, UITableViewDataSource, YXYBaseViewControlerRefreshDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) NSInteger orignalPageNum;
@property (nonatomic, strong) NSString *pageNum;
@property (nonatomic, assign) NSInteger pn;


- (void)loadData:(void(^)(BOOL success, id obj))completion isRefresh:(BOOL)refresh;

@end

NS_ASSUME_NONNULL_END
