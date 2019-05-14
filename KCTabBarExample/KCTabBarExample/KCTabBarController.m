//
//  KCTabBarController.m
//  KCTabBarExample
//
//  Created by knowchatMac01 on 2019/5/14.
//  Copyright © 2019年 Hangzhou knowchat Information Technology Co., Ltd. All rights reserved.
//

#import "KCTabBarController.h"
#import "KCMidBtnTabBar.h"
#import "KCNormalTabBar.h"

static NSInteger tabBarItemTag = 100;

@interface KCTabBarController ()
@property (nonatomic, copy) NSString *tabBarNameStr;
@end

@implementation KCTabBarController

- (instancetype)initWithTabBarName:(NSString *)tabBarName {
    _tabBarNameStr = tabBarName;
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent = NO;
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.f]} forState:UIControlStateNormal];
    self.tabBar.tintColor = [UIColor colorWithRed:118 / 255.0 green:159 / 255.0 blue:255 / 255.0 alpha:1];
    
    UIViewController *messageVC = [[UIViewController alloc] init];
    messageVC.view.backgroundColor = [UIColor redColor];
    UIImage *messageNormalImg = [[UIImage imageNamed:@"tab_icon_news_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *messageSelectedImg = [[UIImage imageNamed:@"tab_icon_news_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *messageItem = [[UITabBarItem alloc] initWithTitle:@"消息" image:messageNormalImg selectedImage:messageSelectedImg];
    messageItem.tag = tabBarItemTag;
    messageVC.navigationItem.title = @"消息";
    messageVC.tabBarItem = messageItem;
    UINavigationController *messageNC = [[UINavigationController alloc] initWithRootViewController:messageVC];
    
    UIViewController *mineVC = [[UIViewController alloc] init];
    mineVC.view.backgroundColor = [UIColor greenColor];
    UIImage *mineNormalImg = [[UIImage imageNamed:@"tab_icon_me_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *mineSelectedImg = [[UIImage imageNamed:@"tab_icon_me_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *mineItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:mineNormalImg selectedImage:mineSelectedImg];
    mineItem.tag = tabBarItemTag + 2;
    mineVC.navigationItem.title = @"我的";
    mineVC.tabBarItem = mineItem;
    UINavigationController *mineNC = [[UINavigationController alloc] initWithRootViewController:mineVC];
    
    //区分
    if ([_tabBarNameStr isEqualToString:NSStringFromClass([KCMidBtnTabBar class])]) {
        KCMidBtnTabBar *tabBar = [[KCMidBtnTabBar alloc] initWithMidBtnNormalImage:[UIImage imageNamed:@"tab_icon_home_n"] selectedImage:[UIImage imageNamed:@"tab_icon_home_s"] titleStr:@"首页"];
        __weak KCTabBarController *weakSelf = self;
        tabBar.centerClickBlock = ^{
            UIViewController *vc = [[UIViewController alloc] init];
            vc.view.backgroundColor = [UIColor blueColor];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        self.viewControllers = @[messageNC, mineNC];
        [self setValue:tabBar forKey:@"tabBar"];
#warning - 修改tabBar后，直接selectedIndex = 0会失效（只有0会失效），需要先跳转到其他模块再跳转回来
        self.selectedIndex = 1;
        self.selectedIndex = 0;
    }else if ([_tabBarNameStr isEqualToString:NSStringFromClass([KCNormalTabBar class])]){
        UIViewController *mainVC = [[UIViewController alloc] init];
        mainVC.view.backgroundColor = [UIColor blueColor];
        UIImage *mainNormalImg = [[UIImage imageNamed:@"tab_icon_home_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *mainSelectedImg = [[UIImage imageNamed:@"tab_icon_home_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UITabBarItem *mainItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:mainNormalImg selectedImage:mainSelectedImg];
        mainItem.tag = tabBarItemTag + 1;
        mainVC.navigationItem.title = @"首页";
        mainVC.tabBarItem = mainItem;
        UINavigationController *mainNC = [[UINavigationController alloc] initWithRootViewController:mainVC];
        
        self.viewControllers = @[messageNC, mainNC ,mineNC];
        KCNormalTabBar *tabBar = [[KCNormalTabBar alloc] initWithMidBtnNormalImage:mainNormalImg selectedImage:mainSelectedImg titleStr:@"首页" titleToImgSpace:2];
        [self setValue:tabBar forKey:@"tabBar"];
        self.selectedIndex = 1;
    }
}

//监听点击事件可以做一些点击动画
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if ([_tabBarNameStr isEqualToString:NSStringFromClass([KCNormalTabBar class])]) {
        KCNormalTabBar *normalTabBar = (KCNormalTabBar *)tabBar;
        NSInteger tagIndex = item.tag - tabBarItemTag;
        UIView *tabBarBtn = normalTabBar.tabBarButtons[tagIndex];
        UIView *tabBarBtnIgv = nil;
        for (UIView *tabBarButtonSubview in tabBarBtn.subviews) {
            if ([tabBarButtonSubview isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                tabBarBtnIgv = tabBarButtonSubview;
                break;
            }
        }
        
        if (tabBarBtnIgv) {
            CABasicAnimation *animation = [CABasicAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.fromValue = @(1);
            animation.toValue = @(0.8);
            animation.fillMode = kCAAnimationLinear;
            animation.autoreverses = YES;
            animation.removedOnCompletion = NO;
            animation.fillMode = kCAFillModeRemoved;
            animation.duration = 0.15;
            [tabBarBtnIgv.layer addAnimation:animation forKey:@"tabbarAnimation"];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
