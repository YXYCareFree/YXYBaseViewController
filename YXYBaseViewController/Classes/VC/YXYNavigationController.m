//
//  YXYNavigationController.m
//  AFNetworking
//
//  Created by apple on 2018/11/5.
//

#import "YXYNavigationController.h"

@interface YXYNavigationController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@end

@implementation YXYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSMutableDictionary *testAttr = [NSMutableDictionary dictionary];
//    testAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    testAttr[NSFontAttributeName] = [UIFont systemFontOfSize:20];
//
//    [[UINavigationBar appearance] setTitleTextAttributes:testAttr];
//    [[UIBarButtonItem appearance] setTitleTextAttributes:testAttr forState:UIControlStateNormal];
//    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
//    [[UINavigationBar appearance] setTintColor:ThemeColor];
//    [[UINavigationBar appearance] setBarTintColor:ThemeColor];
//    [UINavigationBar appearance].translucent= NO;
    
//    self.navigationBar.translucent = YES;
    
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:nil action:nil];
    self.panGesture = pan;
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
    NSLog(@"pan==%p", pan);
    // 禁止之前手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (![self checkForbidPanGuesture]) {

        if (self.panGesture == gestureRecognizer) {
            CGPoint point = [self.panGesture velocityInView:self.panGesture.view];
            if (point.x > 0) {
                //右滑
                [self.panGesture addTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
            }else{
                //左滑
                [self.panGesture removeTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
            }
        }

        // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
        // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
        return self.childViewControllers.count > 1;
    }else{
        return NO;
    }
    return YES;
}

- (BOOL)checkForbidPanGuesture{
    BOOL hidden = NO;
    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"YXYForbidPanGesture"];
    for (NSString *str in arr) {
        if ([self.topViewController isKindOfClass:NSClassFromString(str)]) {
            hidden = YES;
            break;
        }
    }
    return hidden;
}

- (void)setTabbarTitle:(NSString *)title normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage{
    self.tabBarItem.title = title;
    self.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.btnBack];
    }
    [super pushViewController:viewController animated:YES];
}

- (void)back{
    [self popViewControllerAnimated:YES];
}

- (UIButton *)btnBack{
    if (!_btnBack) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 50, 50);
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -45, 0, 0);
        _btnBack = backButton;
    }
    return _btnBack;
}
@end
