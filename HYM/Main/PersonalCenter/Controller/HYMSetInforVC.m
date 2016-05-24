//
//  HYMSetInforVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/14.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMSetInforVC.h"
#import "HYMSetInfoTableView.h"
#import "HYMIconView.h"
#import "HYMInfoBottom.h"
@interface HYMSetInforVC ()
@property (nonatomic,strong)HYMSetInfoTableView *tableView;
@property (nonatomic,strong)HYMIconView *iconView;
@property (nonatomic,strong)HYMInfoBottom *bottom;
@end

@implementation HYMSetInforVC

- (HYMInfoBottom *)bottom{

    if (_bottom == nil) {
        
        _bottom = [[HYMInfoBottom alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth, 140)];
    }
    return _bottom;
}

- (HYMIconView *)iconView{

    if (_iconView == nil) {
        
        _iconView = [[HYMIconView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth, 170)];
    }
    return _iconView;
}
- (HYMSetInfoTableView *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMSetInfoTableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = self.iconView;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDefault];
    [self initView];
}

- (void)initDefault{

    self.title = @"我要推单";
    self.view.backgroundColor = [UIColor clearColor];
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
 
    UIButton *help = [UIButton buttonWithType:UIButtonTypeCustom];
    [help setImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
    help.frame = CGRectMake(0, 0, 20, 20);
    [self.navigationController.navigationBar addSubview:help];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:help];
    self.navigationItem.rightBarButtonItem = right;

}

- (void)initView{

    [self.view addSubview:self.tableView];
}

@end
