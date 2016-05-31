//
//  HYMMoneyVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/31.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMMoneyVC.h"
#import "HYMCenterMoneyTable.h"
@interface HYMMoneyVC ()
@property (nonatomic,strong)HYMCenterMoneyTable *tableView;

@end

@implementation HYMMoneyVC

- (HYMCenterMoneyTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[ HYMCenterMoneyTable alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initDefault];
    [self initView];
}

- (void)initDefault{

    self.title = @"推单中心资产";
    
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
}

- (void)initView{

   
    [self.view addSubview:self.tableView];
}



@end
