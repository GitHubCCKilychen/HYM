//
//  HYMRemindVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/23.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMRemindVC.h"
#import "HYMSegmentView.h"
#import "HYMRemindTable.h"
#import "HYMRemindModel.h"
@interface HYMRemindVC ()<HYMSegmentViewDelegate>

@property (nonatomic,strong)HYMSegmentView *segmentView;
@property (nonatomic,strong)HYMRemindTable *tableView;
@property (nonatomic,strong)NSMutableArray *datalist;
@end

@implementation HYMRemindVC

- (HYMSegmentView *)segmentView{

    if (_segmentView == nil) {
        
        NSArray *titleArr = @[@"全部",@"返利",@"充值",@"提醒",@"支出"];
        _segmentView = [HYMSegmentView segmenFrame:CGRectMake(0, 64, kScreenWitdth, 40) titleDataSource:titleArr backgroundColor:[UIColor whiteColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:15] selectedColor:[UIColor orangeColor] buttonDownColor:[UIColor orangeColor] delegate:self];
    }
    return _segmentView;
}

- (HYMRemindTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMRemindTable alloc] initWithFrame:CGRectMake(0, 104, kScreenWitdth, kScreenHeight-104)];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self loadData];
    [self initDeafult];
    [self initView];
    
}
- (void)initDeafult{

    self.title = @"赎回提醒";
   [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initView{

    [self.view addSubview:self.segmentView];
    [self.view addSubview:self.tableView];
}


-(void)segumentSelectionChange:(NSInteger)selection{

    
}

#pragma mark 数据
- (void)loadData{
    
    
    self.datalist = [NSMutableArray array];
    NSDictionary *dic = @{@"page":@"1",@"token":@"1"};
    
    NSMutableDictionary *nsDic= [NSMutableDictionary dictionaryWithDictionary:dic];
    //网络请求
    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/center/investment_list" target:self selector:@selector(loadData:) parameter:nsDic];
    
    
}

- (void)loadData:(NSDictionary *)infor{
    
    
    NSDictionary *dd = [infor objectForKey:@"infor"];
    NSArray *listItems = [dd objectForKey:@"listItems"];
    
    
    for (NSDictionary *dic in listItems) {
        
        NSDictionary *task_info = [dic objectForKey:@"task_info"];
        
        HYMRemindModel *model = [[HYMRemindModel alloc] initWithDictionary:task_info];
        [self.datalist addObject:model];
     
        self.tableView.datalist = self.datalist;
//
         NSLog(@"%@",task_info);
    }
    
    
}

@end
