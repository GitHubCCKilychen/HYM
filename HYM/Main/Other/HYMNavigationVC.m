//
//  HYMNavigationVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMNavigationVC.h"

@interface HYMNavigationVC ()

@end

@implementation HYMNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWithNavigationBar];
}

- (void)initWithNavigationBar{
    
    //颜色字体大小
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:15]};
    [[UINavigationBar appearance] setTitleTextAttributes:dic];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    //navigationbar
    CGFloat statWidth = [[UIApplication sharedApplication] statusBarFrame].size.width;
    
    CGFloat statHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, statWidth, statHeight)];
    statusBarView.backgroundColor = [UIColor orangeColor];
    //状态栏添加view
    
    [self.view addSubview:statusBarView];
    
}

#pragma mark 状态栏
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}


#pragma mark push时tabbar移除
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated{

    return [super popViewControllerAnimated:animated];
}


#pragma mark 导航栏设置字体大小颜色值
+ (NSDictionary *)setTitle:(UIColor *)fontColor withFontSize:(CGFloat)fontSize withNavi:(UINavigationBar *)navi{

    NSDictionary *dic = @{NSForegroundColorAttributeName:fontColor,NSFontAttributeName:[UIFont systemFontOfSize:fontSize],};
    [navi setTitleTextAttributes:dic];
    return dic;
}

@end
