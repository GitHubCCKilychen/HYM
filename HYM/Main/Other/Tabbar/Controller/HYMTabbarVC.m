//
//  HYMTabbarVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTabbarVC.h"

#import "HYMTaskVC.h"
#import "HYMHomeVC.h"
#import "HYMCommunityVC.h"
#import "HYMContactsVC.h"
#import "HYMPersonalVC.h"
#import "UIImage+Image.h"
#import "HYMTabbarView.h"
#import "HYMNavigationVC.h"
@interface HYMTabbarVC ()<HYMTabbarViewDelegate>

@property (nonatomic,strong)HYMTabbarView *tabbarView;

@property (nonatomic,strong)NSMutableArray *items;//tabbaritem的个数
@end

@implementation HYMTabbarVC


- (NSMutableArray *)items{

    if (_items == nil) {
        
        _items = [NSMutableArray array];
    }
    return _items;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    //创建控制器
    [self createChildViewController];
    
    //创建tabbarView
    [self createTabbarView];
    //状态栏设置
    [self initSetStatus];
}

- (void)initSetStatus{

    CGFloat statWidth = [[UIApplication sharedApplication] statusBarFrame].size.width;
    
    CGFloat statHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, statWidth, statHeight)];
    statusBarView.backgroundColor = [UIColor orangeColor];
    //状态栏添加view
    
    [self.view addSubview:statusBarView];
    
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:15]};
    [[UINavigationBar appearance] setTitleTextAttributes:dic];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
#pragma mark 创建控制器
- (void)createChildViewController{

    //首页
    HYMHomeVC *homeVC = [[HYMHomeVC alloc] init];
    [self setViewControllers:homeVC image:[UIImage imageNamed:@"tab1_0"] selectedImage:[UIImage imageNamed:@"tab1_1"] title:@"首页"];
    //任务
    HYMTaskVC *taskVC = [[HYMTaskVC alloc] init];
    [self setViewControllers:taskVC image:nil selectedImage:nil title:@"任务"];

    //社区
    HYMCommunityVC *communityVC = [[HYMCommunityVC alloc] init];
    [self setViewControllers:communityVC image:nil selectedImage:nil title:@"社区"];

    
    //人脉
    HYMContactsVC *contactsVC = [[HYMContactsVC alloc] init];
    [self setViewControllers:contactsVC image:nil selectedImage:nil title:@"人脉"];
    
    //个人中心
    HYMPersonalVC *personalCenterVC = [[HYMPersonalVC alloc] init];
    [self setViewControllers:personalCenterVC image:nil selectedImage:nil title:@"个人中心"];
    
}


#pragma mark tabbarView
- (void)createTabbarView{

    [self.tabBar removeFromSuperview];
    _tabbarView = [[HYMTabbarView alloc] initWithFrame:self.tabBar.frame];
    _tabbarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bottombg"]];
    
    _tabbarView.tabbarDelegate = self;
    _tabbarView.itemsCount = self.items;
    [self.view addSubview:_tabbarView];
    
    
    
}

#pragma mark 设置VC的图片
- (void)setViewControllers:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title{

    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage ;
    vc.title = title;
    [self.items addObject:vc.tabBarItem];
    
    HYMNavigationVC *nc = [[HYMNavigationVC alloc] initWithRootViewController:vc];
 
}

#pragma mark 切换顺序
- (void)tabBar:(HYMTabbarView *)tabBar didClickButton:(NSInteger)index{

    self.selectedIndex = index;
}
@end
