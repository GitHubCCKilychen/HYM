//
//  HYMInformationVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/20.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMInformationVC.h"
#import "HYMInfoTableView.h"
#import "HYMHeaderView.h"
@interface HYMInformationVC ()

@property (nonatomic,strong)HYMHeaderView *headerView;
@property (nonatomic,strong)HYMInfoTableView *infoTable;


@property (nonatomic,strong)NSArray *counts;
@property (nonatomic,strong)NSArray *count2;
@end

@implementation HYMInformationVC

- (HYMHeaderView *)headerView{

    if (_headerView == nil) {
        
        _headerView = [[HYMHeaderView alloc] init];
        _headerView.frame = CGRectMake(60, 0, kScreenWitdth-20, 44);
//        _headerView.backgroundColor = [UIColor grayColor];
    }
    return _headerView;
}

- (HYMInfoTableView *)infoTable{

    if (_infoTable == nil) {
        
        _infoTable = [[HYMInfoTableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _infoTable;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
    [self initWithView];
   
}


#pragma mark 数据
- (void)loadData{


    
}


#pragma nark 表格
- (void)initWithView{
    
    
    [self.view addSubview:self.infoTable];
    self.counts = @[@"张三",@"类似",@"网无",@"麻溜",@"lianxi",@"屋里",@"1234"];
    self.count2 = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    self.infoTable.count = self.counts;
    
}

- (void)viewWillAppear:(BOOL)animated{


    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar addSubview:self.headerView];
    
    
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    [self.headerView removeFromSuperview];
    
    
}


@end
