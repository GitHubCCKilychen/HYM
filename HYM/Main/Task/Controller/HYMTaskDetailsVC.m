//
//  HYMTaskDetailsVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/28.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTaskDetailsVC.h"
#import "HYMTaskDeailsTableView.h"
#import "HYMTaskHeadView.h"
#import "HYMTaskBottom.h"
#import "HYMTaskDetailModel.h"
@interface HYMTaskDetailsVC ()

@property (nonatomic,strong)HYMTaskDeailsTableView *tableView;
@property (nonatomic,strong)HYMTaskHeadView *headerView;
@property (nonatomic,strong)HYMTaskBottom *taskBottom;
@property (nonatomic,strong)NSMutableArray *listArr;
@end

@implementation HYMTaskDetailsVC
#pragma mark 懒加载

- (NSMutableArray *)listArr{

    if (_listArr == nil) {
        
        _listArr = [NSMutableArray array];
    }
    return _listArr;
}

-(HYMTaskBottom *)taskBottom{

    if (_taskBottom == nil) {
        
        _taskBottom = [[[NSBundle mainBundle] loadNibNamed:@"HYMTaskBottom" owner:self options:nil] lastObject];
        _taskBottom.frame = CGRectMake(0, kScreenHeight-49, kScreenWitdth, 49);
    }
    return _taskBottom;
}
-(HYMTaskHeadView *)headerView{

    if (_headerView == nil) {
        
        _headerView = [[HYMTaskHeadView alloc] init];
        _headerView.frame = CGRectMake(0, 0, kScreenWitdth, kScreenHeight+220);
    }
    
    return _headerView;
}
- (HYMTaskDeailsTableView *)tableView{

    if (_tableView == nil) {
        _tableView = [[HYMTaskDeailsTableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self initDefault];
    [self initWithView];
}

#pragma mark 数据
- (void)loadData{

    NSString *url = [NSString stringWithFormat:@"%@%@",REQUEST_Root_Net,REQUEST_Task_Info];
    NSDictionary *dic = @{@"id":@"1"};
    NSMutableDictionary *nsDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [XTomRequest requestWithURL:url target:self selector:@selector(loadData:) parameter:nsDic];
}
#pragma mark 数据加载
- (void)loadData:(NSDictionary *)dic{
    
    NSDictionary *infor = [dic objectForKey:@"infor"];
    
    HYMTaskDetailModel *taskDetailModel = [[HYMTaskDetailModel alloc] initWithDictionary:infor];
    [self.listArr addObject:taskDetailModel];
    
    NSLog(@"%@",[infor objectForKey:@"description"]);
}

#pragma mark default
- (void)initDefault{

    self.title = @"任务详情";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
  
}

#pragma mark 
- (void)initWithView{

   
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.taskBottom];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{

    [super  viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
}

@end
