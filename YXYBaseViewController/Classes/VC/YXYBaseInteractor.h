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

/**
 初始化pageNum
 */
@property (nonatomic, assign) NSInteger orignalPageNum;

/**
 当前的pageNum(NSString *)
 */
@property (nonatomic, strong) NSString *pageNum;

/**
 当前的页码pn（NSInteger）
 */
@property (nonatomic, assign) NSInteger pn;


/**
 持有的tableView
 */
@property (nonatomic, strong) UITableView *tableView;



@end

NS_ASSUME_NONNULL_END
