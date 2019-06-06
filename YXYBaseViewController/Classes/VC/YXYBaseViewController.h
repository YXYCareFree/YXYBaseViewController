//
//  YXYBaseViewController.h
//  Expecta
//
//  Created by apple on 2018/10/16.
//

#import <UIKit/UIKit.h>
#import "YXYLabel.h"
#import "MJRefresh.h"
#import "YXYTableView.h"

@protocol YXYBaseViewControlerRefreshDelegate <NSObject>

@required
- (void)loadData:(void(^)(BOOL success, id obj))completion isRefresh:(BOOL)refresh;

@optional
- (void)YXYVC_PullDownRefreshCompletion:(void(^)(BOOL success))block;

- (void)YXYVC_PullUpLoadMoreCompletion:(void(^)(BOOL success))block;

@end

#define YXYHideNavBar   @"YXYHideNavBar"
NS_ASSUME_NONNULL_BEGIN

@interface YXYBaseViewController : UIViewController<UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, weak) id<YXYBaseViewControlerRefreshDelegate> refreshDelegate;

/**
 GCD延迟函数的时间
 */
@property (nonatomic, assign) NSInteger gcdAfterTime;

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
 返回按钮的颜色
 */
@property (nonatomic, strong) UIColor *colorBack;



/**
 收起键盘
 */
- (void)endEditing;

@end

NS_ASSUME_NONNULL_END
