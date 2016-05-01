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
#import "HYMInfoCellModel.h"
#import "HYMTableViewCell.h"
#import "HYMTaskModel.h"
@interface HYMHomeVC ()
@property (nonatomic,strong)HYMTableView *tableView;
@property (nonatomic,strong)HYMTableHeader *headerView;
@property (nonatomic,strong)HYMNoticeView *noticeView;

@property (nonatomic,strong)NSMutableArray *infoArr;//资讯数组
@property (nonatomic,strong)NSMutableArray *taskArr;
@end

@implementation HYMHomeVC

#pragma mark 懒加载

-(NSMutableArray *)infoArr{

    if (_infoArr == nil) {
        
        _infoArr = [NSMutableArray array];
    }
    
    return _infoArr;
}

-(NSMutableArray *)taskArr{

    if (_taskArr == nil) {
        
        _taskArr = [NSMutableArray array];
    }
    return _taskArr;
}
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
    //任务精选
    [self loadDataTask];
    
    
    //tableView
    [self initWithTableView];
    
}

#pragma mark 数据 －今日资讯数据
- (void)loadData{

    NSMutableDictionary *infoDic = [NSMutableDictionary dictionary];
    //网络请求
    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/?m=base&a=blog_list_index" target:self selector:@selector(infoData:) parameter:infoDic];
}
- (void)infoData:(NSDictionary *)infoDic{
    
    
    if (1 == [[infoDic objectForKey:@"success"] intValue]) {
        
        NSDictionary *infor = [infoDic objectForKey:@"infor"];
        
        NSArray *listItems = [infor objectForKey:@"listItems"];
        
        for (NSDictionary *dic in listItems) {
            
            
            HYMInfoCellModel *model = [[HYMInfoCellModel alloc] initWithDictionary:dic];
            [self.infoArr addObject:model];
            
            
            self.tableView.infoArr = self.infoArr;
            [self.tableView reloadData];
            
            
        }
        
    }else{
        
        NSLog(@"错误");
    }
}
#pragma mark  数据－任务精选
- (void)loadDataTask{

    NSMutableDictionary *dics = [NSMutableDictionary dictionary];
    [XTomRequest requestWithURL:@"http://123.56.237.91/index.php/Webservice/?m=Base&a=task_select" target:self selector:@selector(taskData:) parameter:dics];
    
    
    
}


- (void)taskData:(NSDictionary *)taskDic{

    NSArray *infor = [taskDic objectForKey:@"infor"];
    
    for (NSDictionary *dic in infor) {
    
        HYMTaskModel *taskModel = [[HYMTaskModel alloc] initWithDictionary:dic];
        
        [self.taskArr addObject:taskModel];
        self.tableView.taskArr = self.taskArr;
        
        [self.tableView reloadData];
        
    }
//    NSLog(@"%@",taskDic);
    
}
#pragma mark tableView
- (void)initWithTableView{
    
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
