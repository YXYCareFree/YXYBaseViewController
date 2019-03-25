//
//  YXYBaseViewController.m
//  Expecta
//
//  Created by apple on 2018/10/16.
//

#import "YXYBaseViewController.h"
#import "YXYDefine.h"
#import "YXYAlertView.h"

@interface YXYBaseViewController ()

@property (nonatomic, strong) UIView *vBack;
@property (nonatomic, assign) NSInteger originalPageNum;

@end

@implementation YXYBaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    BOOL hidden = [self checkNavBarHidden:self];
    //某些情况下隐藏和显示navbar会有一个动画，需要在该界面禁止此动画
//    [self.navigationController setNavigationBarHidden:hidden animated:![self isKindOfClass:NSClassFromString(@"OrderViewController")]];
    BOOL hidden = [self checkNavBarHidden:self];
    //animated设置NO会导致navBar出现黑色
//    self.navigationController.navigationBar.translucent = hidden;
    [self.navigationController setNavigationBarHidden:hidden animated:YES];

    if (_vBack || _lblTitle) {
        [self.view addSubview:self.vNavBar];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view.window endEditing:YES];

//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate = self;
}

- (void)setVBackHidden:(BOOL)vBackHidden{
    _vBackHidden = vBackHidden;
    self.vBack.hidden = vBackHidden;
}

- (void)backClicked{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)endEditing{
    [self.view.window endEditing:YES];
}

- (void)addEndEditingTapGesture{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
    [self.view addGestureRecognizer:tap];
}
#pragma mark--检测内存泄漏
- (void)popViewController{
    __weak YXYBaseViewController *weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (weakSelf) {
            NSString *title = [NSString stringWithFormat:@"%@没有被释放", NSStringFromClass(weakSelf.class)];
            [YXYAlertView alertWithTitle:title completion:nil];
        }
    });
    [self.navigationController popViewControllerAnimated:YES];
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
            if (success) {
                [self.tableView reloadData];
                if (_yxy_tableView) {
                    [self.yxy_tableView reloadData];
                }
            }
            [self.tableView.mj_header endRefreshing];
            if (_yxy_tableView) {
                [self.yxy_tableView.mj_header endRefreshing];
            }
        }];
    }
}

- (void)pullUpLoadMore{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(YXYVC_PullUpLoadMore:completion:)]) {
        [self.refreshDelegate YXYVC_PullUpLoadMore:1 completion:^(BOOL success) {
            if (success) {
                [self.tableView reloadData];
                if (_yxy_tableView) {
                    [self.yxy_tableView reloadData];
                }
            }
            [self.tableView.mj_footer endRefreshing];
            if (_yxy_tableView) {
                [self.yxy_tableView.mj_footer endRefreshing];
            }
        }];
    }
}
#pragma mark--Setter  Getter
- (void)setRefreshDelegate:(id<YXYBaseViewControlerRefreshDelegate>)refreshDelegate{
    if (!refreshDelegate) return;
    _refreshDelegate = refreshDelegate;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownRefresh)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUpLoadMore)];
    if (_yxy_tableView) {
        self.yxy_tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownRefresh)];
        self.yxy_tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUpLoadMore)];
    }
}

- (void)setColorBack:(UIColor *)colorBack{
    _colorBack = colorBack;
    self.btnBack.tintColor = colorBack;
    [self.btnBack setImage:[self.btnBack.currentImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (YXYTableView *)yxy_tableView{
    if (!_yxy_tableView) {
        _yxy_tableView = [YXYTableView new];
        _yxy_tableView.backgroundColor = [UIColor whiteColor];
        _yxy_tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _yxy_tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if (@available(iOS 11.0, *)) {
            _yxy_tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [self.view addSubview:_yxy_tableView];
    }
    return _yxy_tableView;
}

- (UIButton *)btnBack{
    if (!_btnBack) {
        _btnBack = [UIButton new];
        [_btnBack addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.vNavBar];
    }
    return _btnBack;
}

- (YXYLabel *)lblTitle{
    if (!_lblTitle) {
        _lblTitle = [YXYLabel new];
        [self.view addSubview:self.vNavBar];
    }
    return _lblTitle;
}

- (UIView *)vNavBar{
    if (!_vNavBar) {
        UIView *vNavBar = UIView.new;
        _vNavBar = vNavBar;
        [self.view addSubview:vNavBar];
        [vNavBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(0));
            make.left.right.equalTo(@0);
            make.height.equalTo(@(44 + STATUS_BAR_HEIGHT));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClicked)];
        [self.vBack addGestureRecognizer:tap];
        [vNavBar addSubview:self.vBack];
        [self.vBack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(STATUS_BAR_HEIGHT));
            make.left.equalTo(@(0));
            make.height.equalTo(@44);
            make.width.equalTo(@60);
        }];
        [self.vBack addSubview:self.btnBack];
        [self.btnBack mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.vBack);
            make.left.equalTo(@15);
        }];
        [vNavBar addSubview:self.lblTitle];
        [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(vNavBar);
            make.top.equalTo(@(STATUS_BAR_HEIGHT));
            make.height.equalTo(@44);
        }];
    }
    return _vNavBar;
}

- (UIView *)vBack{
    if (!_vBack) {
        _vBack = UIView.new;
    }
    return _vBack;
}

@end
