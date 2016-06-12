//
//  HYMMoneyVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/31.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMMoneyVC.h"
#import "HYMCenterMoneyTable.h"
#import "HYMMoneyModel.h"
@interface HYMMoneyVC ()
@property (nonatomic,strong)HYMCenterMoneyTable *tableView;
@property (nonatomic,strong)NSMutableArray *datalist;

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

    [self loadData];
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

#pragma mark 数据
- (void)loadData{

    self.datalist = [NSMutableArray array];
    
    NSDictionary *dic = @{@"token":@"1"};
    
    NSMutableDictionary *nsdic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/webservice/center/tdcenter" target:self selector:@selector(loadData:) parameter:nsdic];
}

- (void)loadData:(NSDictionary *)dic{

    NSDictionary *infor = [dic objectForKey:@"infor"];
    
    HYMMoneyModel *model = [[HYMMoneyModel alloc] initWithDictionary:infor];
    
    [self.datalist addObject:model];
    
    self.tableView.datalist = self.datalist;
    
//    NSLog(@"%@",dic);
    
}

@end
