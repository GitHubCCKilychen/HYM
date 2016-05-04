//
//  HYMPayMoneyVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/3.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPayMoneyVC.h"
#import "HYMPayTableView.h"
#import "HYMPayView.h"
@interface HYMPayMoneyVC ()

@property (nonatomic,strong)HYMPayTableView *tableView;
@property (nonatomic,strong)HYMPayView *payView;
@end

@implementation HYMPayMoneyVC

-(HYMPayView *)payView{

    if (_payView == nil) {
        
        _payView = [[HYMPayView alloc] init];
        _payView.frame = CGRectMake(0, 0, kScreenWitdth, 30);
        _payView.backgroundColor = [UIColor lightGrayColor];
    }
    return _payView;
}

-(HYMPayTableView *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMPayTableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = self.payView;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initDefault];
    [self initWithView];
}

- (void)initDefault{
    
    self.title = @"预付金额";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    
}

- (void)initWithView{


    [self.view  addSubview:self.tableView];
    
}


@end
