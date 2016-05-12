//
//  HYMDetailsVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/5.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMDetailsVC.h"
#import "HYMDetailsTable.h"
#import "HYMDetailsBottom.h"
@interface HYMDetailsVC ()

@property (nonatomic,strong)HYMDetailsTable *tableView;
@property (nonatomic,strong)HYMDetailsBottom *bottomView;
@end

@implementation HYMDetailsVC

- (HYMDetailsBottom *)bottomView{

    if (_bottomView == nil) {
        
        _bottomView = [[HYMDetailsBottom alloc] init];
        _bottomView.frame = CGRectMake(0, 0, kScreenWitdth, 125);
    }
    return _bottomView;
}

- (HYMDetailsTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMDetailsTable alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.tableFooterView = self.bottomView;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //数据
    [self loadData];
    //配置
    [self initDefault];
    //控件
    [self initWithView];
}

#pragma mark 数据
- (void)loadData{


}

#pragma mark 配置
- (void)initDefault{

    self.title = @"任务详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 35, 35);
    btn.backgroundColor = [UIColor brownColor];
    [btn addTarget:self action:@selector(rightAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:btn];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark 控件
- (void)initWithView{

    
    [self.view addSubview:self.tableView];
    
}

#pragma mark 事件
- (void)rightAct:(UIButton *)btn{

    
}
@end
