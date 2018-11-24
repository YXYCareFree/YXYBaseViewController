//
//  YXYNavigationController.m
//  AFNetworking
//
//  Created by apple on 2018/11/5.
//

#import "YXYNavigationController.h"

@interface YXYNavigationController ()

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
    UIPanGestureRecognizer  *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
    // 禁止之前手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (void)setTabbarTitle:(NSString *)title normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage{
    self.tabBarItem.title = title;
    self.tabBarItem.image = normalImage;
    self.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 50, 50);
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        self.btnBack = backButton;
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -45, 0, 0);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    [super pushViewController:viewController animated:YES];
}

- (void)back{
    [self popViewControllerAnimated:YES];
}

@end
