//
//  HYMMallVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/20.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMMallVC.h"
#import "ScrollView.h"
#import "HYMStoreTableView.h"
@interface HYMMallVC ()

@property (nonatomic,strong)HYMStoreTableView *tableView;
@property (nonatomic,strong)ScrollView *scrollView;
@end

@implementation HYMMallVC

#pragma mark 懒加载
-(ScrollView *)scrollView{

    if (_scrollView == nil) {
        
        _scrollView = [[ScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth, 150)];
        _scrollView.backgroundColor = [UIColor grayColor];
    }
    
    return _scrollView;
}
-(HYMStoreTableView *)tableView{

    if (_tableView == nil) {
        _tableView = [[HYMStoreTableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = self.scrollView;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    [self initDefault];
    [self initWithView];
    
}

- (void)initDefault{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"薅羊毛商城";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    
    UIButton *newBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    newBtn.frame = CGRectMake(0, 0, 40, 40);
    newBtn.backgroundColor = [UIColor grayColor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:newBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

    
}
#pragma mark 初始化
- (void)initWithView{

    
    
    [self.view addSubview:self.tableView];
}

@end
