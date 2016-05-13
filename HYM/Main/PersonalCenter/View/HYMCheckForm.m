//
//  HYMCheckForm.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMCheckForm.h"
#import "HYMCheckTable.h"
#import "HYMCheckView.h"
@interface HYMCheckForm ()

@property (nonatomic,strong)HYMCheckTable *tableView;
@property (nonatomic,strong)HYMCheckView *headerView;
@end

@implementation HYMCheckForm

- (HYMCheckView *)headerView{

    if (_headerView == nil) {
        
        _headerView = [[HYMCheckView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth, 50)];
    }
    return _headerView;
}

- (HYMCheckTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMCheckTable alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDeault];
    [self initWithView];
    
}

- (void)initDeault{

    self.title = @"审核报单";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    
    UIButton *help = [UIButton buttonWithType:UIButtonTypeCustom];
    help.backgroundColor = [UIColor grayColor];
    help.frame = CGRectMake(0, 0, 30, 30);
    [self.navigationController.navigationBar addSubview:help];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:help];
    self.navigationItem.rightBarButtonItem = right;
    
}

- (void)initWithView{

    [self.view addSubview:self.tableView];
    
}




@end
