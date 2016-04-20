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
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:15]};
    [[UINavigationBar appearance] setTitleTextAttributes:dic];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbar"] forBarMetrics:UIBarMetricsDefault];
    CGFloat statWidth = [[UIApplication sharedApplication] statusBarFrame].size.width;
    
    CGFloat statHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, statWidth, statHeight)];
    statusBarView.backgroundColor = [UIColor orangeColor];
    //状态栏添加view
    
    [self.view addSubview:statusBarView];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}



@end
