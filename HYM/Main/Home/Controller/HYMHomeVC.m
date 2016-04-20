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
@property (nonatomic,strong)UIView *backgroudView;
@end

@implementation HYMHomeVC

-(UIView *)backgroudView{

    if (_backgroudView == nil) {
        
        _backgroudView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth, 44)];
        _backgroudView.backgroundColor = [UIColor orangeColor];
    }
    return _backgroudView;
}

#pragma mark 懒加载
-(HYMNoticeView *)noticeView{
    
    if (_noticeView == nil) {
        
        _noticeView = [[HYMNoticeView alloc] init];
        CGRectMake(0, 20, self.view.frame.size.width, 40);
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
    
    self.navigationItem.title = @"";

    //公告
    [self.navigationController.navigationBar addSubview:self.backgroudView];
    [self.backgroudView addSubview:self.noticeView];
   
    
    [self.view addSubview:self.tableView];

//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
////        
//        make.left.mas_equalTo(0);
//        make.right.mas_equalTo(-0);
//        make.bottom.mas_equalTo(0);
//        make.width.mas_equalTo(kScreenWitdth);
//        make.height.mas_equalTo(kScreenHeight);
//        make.top.mas_equalTo(0);
//    }];
//    
}


@end
