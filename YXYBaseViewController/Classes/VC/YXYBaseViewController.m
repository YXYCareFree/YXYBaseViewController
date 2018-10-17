//
//  YXYBaseViewController.m
//  Expecta
//
//  Created by apple on 2018/10/16.
//

#import "YXYBaseViewController.h"
#import "MJRefresh.h"

@interface YXYBaseViewController ()<UINavigationControllerDelegate>

@property (nonatomic, assign) NSInteger pageNo;

@end

@implementation YXYBaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    BOOL hidden = [self checkNavBarHidden:self];
    //某些情况下隐藏和显示navbar会有一个动画，需要在该界面禁止此动画
//    [self.navigationController setNavigationBarHidden:hidden animated:![self isKindOfClass:NSClassFromString(@"OrderViewController")]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view.window endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate = self;
}

- (void)endEditing{
    [self.view.window endEditing:YES];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL hidden = [self checkNavBarHidden:viewController];
    [self.navigationController setNavigationBarHidden:hidden animated:YES];
}

- (BOOL)checkNavBarHidden:(UIViewController *)vc{
    BOOL hidden = NO;
    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"YXYHideNavBarVC"];
    for (NSString *str in arr) {
        if ([vc isKindOfClass:NSClassFromString(str)]) {
            hidden = YES;
            break;
        }
    }
    return hidden;
}

- (void)pullDownRefresh{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(YXYVC_PullDownRefreshCompletion:)]) {
        [self.refreshDelegate YXYVC_PullDownRefreshCompletion:^(BOOL success) {
            [self.tableView.mj_header endRefreshing];
            if (success) {
                self.pageNo = 0;
            }
        }];
    }
}

- (void)pullUpLoadMore{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(YXYVC_PullUpLoadMore:completion:)]) {
        [self.refreshDelegate YXYVC_PullUpLoadMore:++self.pageNo completion:^(BOOL success) {
            [self.tableView.mj_footer endRefreshing];
            if (!success) {
                self.pageNo--;
            }
        }];
    }
}

- (void)setRefreshDelegate:(id<YXYBaseViewControlerRefreshDelegate>)refreshDelegate{
    if (!refreshDelegate) return;
    _refreshDelegate = refreshDelegate;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownRefresh)];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUpLoadMore)];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
@end
