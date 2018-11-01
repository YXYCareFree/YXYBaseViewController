//
//  YXYBaseViewController.m
//  Expecta
//
//  Created by apple on 2018/10/16.
//

#import "YXYBaseViewController.h"
#import "MJRefresh.h"
#import "Masonry.h"

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)

@interface YXYBaseViewController ()<UINavigationControllerDelegate>

@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation YXYBaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    BOOL hidden = [self checkNavBarHidden:self];
    //某些情况下隐藏和显示navbar会有一个动画，需要在该界面禁止此动画
//    [self.navigationController setNavigationBarHidden:hidden animated:![self isKindOfClass:NSClassFromString(@"OrderViewController")]];
    BOOL hidden = [self checkNavBarHidden:self];
    //animated设置NO会导致navBar出现黑色
    [self.navigationController setNavigationBarHidden:hidden animated:YES];
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
    
    [self setYXYNavBar];
}

- (void)setYXYNavBar{
    if ([self checkNavBarHidden:self]) {
        [self.view addSubview:self.btnBack];
        [self.btnBack mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.equalTo(@(STATUS_BAR_HEIGHT + 15));
            make.width.equalTo(@10);
            make.height.equalTo(@17);
        }];
        UIView *vBack = UIView.new;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClicked)];
        [vBack addGestureRecognizer:tap];
        [self.view addSubview:vBack];
        [vBack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.btnBack);
            make.width.height.equalTo(@25);
        }];
        [self.view addSubview:self.lblTitle];
        [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(STATUS_BAR_HEIGHT));
            make.centerX.equalTo(self.view);
            make.height.equalTo(@44);
        }];
    }
}

- (void)backClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)endEditing{
    [self.view.window endEditing:YES];
}
#pragma mark--UINavigationControllerDelegate
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
#pragma mark--PullDown  PullUp
- (void)pullDownRefresh{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(YXYVC_PullDownRefreshCompletion:)]) {
        [self.refreshDelegate YXYVC_PullDownRefreshCompletion:^(BOOL success) {
            [self.tableView.mj_header endRefreshing];
            if (success) {
                self.pageNum = 0;
            }
        }];
    }
}

- (void)pullUpLoadMore{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(YXYVC_PullUpLoadMore:completion:)]) {
        [self.refreshDelegate YXYVC_PullUpLoadMore:++self.pageNum completion:^(BOOL success) {
            [self.tableView.mj_footer endRefreshing];
            if (!success) {
                self.pageNum--;
            }
        }];
    }
}
#pragma mark--Setter  Getter
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

- (UIButton *)btnBack{
    if (!_btnBack) {
        _btnBack = [UIButton new];
        [_btnBack addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBack;
}

- (YXYLabel *)lblTitle{
    if (!_lblTitle) {
        _lblTitle = [YXYLabel new];
    }
    return _lblTitle;
}
@end
