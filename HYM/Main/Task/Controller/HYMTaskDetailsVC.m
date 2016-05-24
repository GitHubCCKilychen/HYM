//
//  HYMTaskDetailsVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/28.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTaskDetailsVC.h"
#import "HYMTaskDeailsTableView.h"
#import "HYMTaskDetailModel.h"
#import "HYMTaskRecordView.h"
#import "HYMTaskBottom.h"
@interface HYMTaskDetailsVC ()

@property (nonatomic,strong)HYMTaskDeailsTableView *tableView;
@property (nonatomic,strong)HYMTaskBottom *taskBottom;
@property (nonatomic,strong)NSMutableArray *listArr;
@property (nonatomic,strong)HYMTaskRecordView *headerView;
@end

@implementation HYMTaskDetailsVC
#pragma mark 懒加载

- (HYMTaskBottom *)taskBottom{

    if (_taskBottom == nil) {
        
        _taskBottom =  [[[NSBundle mainBundle] loadNibNamed:@"HYMTaskBottom" owner:self options:nil]lastObject];
        _taskBottom.frame = CGRectMake(0, kScreenHeight-49, kScreenWitdth, 49);
    }
    return _taskBottom;
}
- (HYMTaskRecordView *)headerView{

    if (_headerView == nil) {
        
        _headerView = [[HYMTaskRecordView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth, 110)];
        
    }
    return _headerView;
}

- (NSMutableArray *)listArr{

    if (_listArr == nil) {
        
        _listArr = [NSMutableArray array];
    }
    return _listArr;
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

#pragma mark 任务列表ID值
-(void)setIndex:(NSInteger)index{

    _index = index;
    self.tableView.index = _index;
}

#pragma mark 新手单
- (void)setNewIndex:(NSInteger)newIndex{

    _newIndex = newIndex;
    
    self.tableView.newIndex = _newIndex;
}
#pragma mark 数据
- (void)loadData{

    NSString *url = [NSString stringWithFormat:@"%@%@",REQUEST_Root_Net,REQUEST_Task_Info];
    
    NSString *indexString = [NSString stringWithFormat:@"%ld",(long)self.index];
    
    NSDictionary *dic = @{@"id":indexString};
    NSMutableDictionary *nsDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [XTomRequest requestWithURL:url target:self selector:@selector(loadData:) parameter:nsDic];
}
#pragma mark 数据加载
- (void)loadData:(NSDictionary *)dic{
    
//    NSLog(@"%@-%@",dic,[dic objectForKey:@"msg"]);
    NSDictionary *infor = [dic objectForKey:@"infor"];
    
    HYMTaskDetailModel *taskDetailModel = [[HYMTaskDetailModel alloc] initWithDictionary:infor];
    self.headerView.model = taskDetailModel;
    [self.listArr addObject:taskDetailModel];
    self.tableView.datalist = self.listArr;
    [self.tableView reloadData];
    
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
