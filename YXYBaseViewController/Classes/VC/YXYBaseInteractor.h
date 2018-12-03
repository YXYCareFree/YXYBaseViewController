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
@property (nonatomic, strong) NSString *pageNum;

- (void)loadData:(void(^)(BOOL success, id obj))completion;

@end

NS_ASSUME_NONNULL_END
