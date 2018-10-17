//
//  YXYBaseViewController.h
//  Expecta
//
//  Created by apple on 2018/10/16.
//

#import <UIKit/UIKit.h>

@protocol YXYBaseViewControlerRefreshDelegate <NSObject>

- (void)YXYVC_PullDownRefreshCompletion:(void(^)(BOOL success))block;

- (void)YXYVC_PullUpLoadMore:(NSInteger)page completion:(void(^)(BOOL success))block;

@end

#define YXYHideNavBar   @"YXYHideNavBar"
NS_ASSUME_NONNULL_BEGIN

@interface YXYBaseViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, weak) id<YXYBaseViewControlerRefreshDelegate> refreshDelegate;

@end

NS_ASSUME_NONNULL_END
