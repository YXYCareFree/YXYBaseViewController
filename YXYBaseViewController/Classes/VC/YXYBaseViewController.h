//
//  YXYBaseViewController.h
//  Expecta
//
//  Created by apple on 2018/10/16.
//

#import <UIKit/UIKit.h>
#import "YXYLabel.h"
#import "MJRefresh.h"

@protocol YXYBaseViewControlerRefreshDelegate <NSObject>

- (void)YXYVC_PullDownRefreshCompletion:(void(^)(BOOL success))block;

- (void)YXYVC_PullUpLoadMore:(NSInteger)page completion:(void(^)(BOOL success))block;

@end

#define YXYHideNavBar   @"YXYHideNavBar"
NS_ASSUME_NONNULL_BEGIN

@interface YXYBaseViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, weak) id<YXYBaseViewControlerRefreshDelegate> refreshDelegate;

/**
 当VC的navbar隐藏的时候才会加载在View上
 */
@property (nonatomic, strong) UIButton *btnBack;

/**
 默认不隐藏左上角返回按钮
 */
@property (nonatomic, assign) BOOL vBackHidden;
/**
 当VC的navbar隐藏的时候才会加载在View上
 */
@property (nonatomic, strong) YXYLabel *lblTitle;

/**
 自定义的navBar
 */
@property (nonatomic, strong) UIView *vNavBar;

/**
 需要分页加载时的当前页码
 */
@property (nonatomic, assign) NSInteger pageNum;

/**
 返回按钮的颜色
 */
@property (nonatomic, strong) UIColor *colorBack;

- (void)pullDownRefresh;

- (void)addEndEditingTapGesture;

- (void)endEditing;

@end

NS_ASSUME_NONNULL_END
