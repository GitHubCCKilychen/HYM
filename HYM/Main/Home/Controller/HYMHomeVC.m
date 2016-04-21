//
//  HYMHomeVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMHomeVC.h"
#import "HYMTableView.h"
#import "HYMTableHeader.h"
#import "HYMNoticeView.h"
@interface HYMHomeVC ()
@property (nonatomic,strong)HYMTableView *tableView;
@property (nonatomic,strong)HYMTableHeader *headerView;
@property (nonatomic,strong)HYMNoticeView *noticeView;
@end

@implementation HYMHomeVC

#pragma mark 懒加载
-(HYMNoticeView *)noticeView{
    
    if (_noticeView == nil) {
        
        _noticeView = [[HYMNoticeView alloc] init];
        _noticeView.frame = CGRectMake(0, 0, kScreenWitdth, 44);
        _noticeView.backgroundColor = [UIColor orangeColor];
        
    }
    
    return _noticeView;
}

- (HYMTableHeader *)headerView{
    
    if (_headerView ==nil) {
        
        _headerView = [[HYMTableHeader alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kScreenHeight/1.8)];
    }
    
    return _headerView;
}

- (HYMTableView *)tableView{
    
    if (_tableView == nil) {
        
        _tableView = [[HYMTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.headerView;
    }
    
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //数据
    [self loadData];
    
    
    //tableView
    [self initWithTableView];
    
}

#pragma mark 数据
- (void)loadData{

}

#pragma mark tableView
- (void)initWithTableView{
    

    //公告
//    [self.view addSubview:self.noticeView];
    
    [self.view addSubview:self.tableView];
    
    

    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar addSubview:self.noticeView];
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    [self.noticeView removeFromSuperview];
}
@end
