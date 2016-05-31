//
//  HYMTaskVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTaskVC.h"
#import "HYMSegmentView.h"
#import "HYMTaskTableView.h"
#import "HYMSortView.h"
#import "HYMRecordVC.h"
#import "HYMTaskDetailModel.h"
#import "HYMTaskModel.h"
#import "HYMFanliModel.h"
#import "HYMSelectedVC.h"

@interface HYMTaskVC ()<HYMSegmentViewDelegate,HYMSortViewDelegate>
@property (nonatomic,strong)HYMSegmentView *segmentView;
@property (nonatomic,strong)HYMTaskTableView *tableView;
@property (nonatomic,strong)HYMSortView *sortView;
@property (nonatomic,strong)NSMutableArray *listArr;
@property (nonatomic,strong)NSMutableArray *fanliArr;
@property (nonatomic,strong)UIView *lineView;


/**
 *  类型type
 */
@end

@implementation HYMTaskVC

#pragma mark 懒加载


- (UIView *)lineView{
    
    if (_lineView == nil) {
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWitdth-80,0, 0.5,44)];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _lineView;
}
- (NSMutableArray *)fanliArr{

    if (_fanliArr == nil) {
        
        _fanliArr = [NSMutableArray array];
    }
    return _fanliArr;
}
- (NSMutableArray *)listArr{

    if (_listArr == nil) {
        
        _listArr = [NSMutableArray array];
    }
    return _listArr;
}
-(HYMSortView *)sortView{

    if (_sortView == nil) {
        
        NSArray *title = @[@"默认",@"期限",@"收益",@"筛选"];
        _sortView = [HYMSortView setFrame:CGRectMake(0, 64, kScreenWitdth, 45) titleDataSource:title backgroudColor:[UIColor whiteColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:15] selectedColor:[UIColor colorWithRed:39/256.f green:165/256.f blue:225/256.f alpha:1] buttonDownColor:[UIColor orangeColor] delegate:self];
        
        _sortView.tag = 102;
        
        
    }
    
    return _sortView;
}
- (HYMSegmentView *)segmentView{

    if (_segmentView == nil) {
        
        NSArray *title = @[@"精选",@"返利单",@"新手单",@"银行单"];
        _segmentView = [HYMSegmentView segmenFrame:CGRectMake(0, 0, kScreenWitdth-90, 44) titleDataSource:title backgroundColor:[UIColor clearColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:15] selectedColor:[UIColor redColor] buttonDownColor:[UIColor redColor] delegate:self];
        _segmentView.tag = 101;
        
    }
    
    return _segmentView;
}

-(HYMTaskTableView *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMTaskTableView alloc] initWithFrame:CGRectMake(0, 120, kScreenWitdth, kScreenHeight-120-49)style:UITableViewStyleGrouped];
    
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //右上角
    [self initWithBarItem];
    [self loadData];
    [self initDefault];
    [self initWithView];
    
}


#pragma mark 默认数据
- (void)loadData{
    
    //精选
    [self segumentSelectionChange:0];
    [self selectedBtnChange:0];
    
}


#pragma mark initview
- (void)initDefault{
    
  
}

#pragma mark initview
- (void)initWithView{
    [self.view addSubview:self.sortView];
    [self.view addSubview:self.tableView];
    
}

#pragma mark 代理方法－－精选－－返利－－新手－－银行
- (void)segumentSelectionChange:(NSInteger)selection{
    
    NSLog(@"%ld",(long)selection);
    
    [self selectedData:selection];
    self.tableView.index = self.segmentView.tag;
    
    if (selection == 2) {
        
        self.tableView.index = 2;
    }
    
}


#pragma mark  精选－返利－新手－
- (void)selectedData:(NSInteger)index{

    
    NSString  *typeValue= [NSString stringWithFormat:@"%ld",(long)index];
    NSString *url = [NSString stringWithFormat:@"%@%@",REQUEST_Root_Net,REQUEST_Task_List];
    NSDictionary *dic = @{@"type":typeValue,@"order":@"1",@"sort":@"1",@"page":@"1",@"brand":@""};
    NSMutableDictionary *nsdic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [self.fanliArr removeAllObjects];
    [XTomRequest requestWithURL:url target:self selector:@selector(loadData:) parameter:nsdic];
    
    
}
#pragma mark  返利－银行－精选
- (void)loadData:(NSDictionary *)dic{


    NSDictionary *infor = [dic objectForKey:@"infor"];
    NSDictionary *listItem = [infor objectForKey:@"listItems"];
    for (NSDictionary *dic in listItem) {
        
        HYMTaskModel *model = [[HYMTaskModel alloc] initWithDictionary:dic];
        [self.fanliArr addObject:model];
        
        self.tableView.fanliArr = self.fanliArr;
        [self.tableView reloadData];
       
    }


}
#pragma mark 默认－期限－收益
- (void)selectedBtnChange:(NSInteger)selectedBtn{

    [self defaultData:selectedBtn];
    self.tableView.index = self.sortView.tag;
}


- (void)defaultData:(NSInteger)index{

    if (index == 3) {
        
        HYMSelectedVC *seleVC = [[HYMSelectedVC alloc] init];
        seleVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:seleVC animated:YES];
    }
    
    //调用网络请求
    NSString *orderValue = [NSString stringWithFormat:@"%ld",(long)index];
    
    NSDictionary *dic = @{@"type":@"0",@"order":orderValue,@"sort":@"1",@"page":@"1",@"brand":@""};
    NSMutableDictionary *nsdic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [self.fanliArr removeAllObjects];
    [XTomRequest requestWithURL:@"http://123.56.237.91/index.php/Webservice/Center/task_list" target:self selector:@selector(defaultsTaskData:) parameter:nsdic];
    
}

#pragma mark 默认－期限－－
- (void)defaultsTaskData:(NSDictionary *)taskDic{
    
    
    NSDictionary *infor = [taskDic objectForKey:@"infor"];
    
    NSArray *listItems = [infor objectForKey:@"listItems"];
    
    
    for (NSDictionary *dic in listItems) {
        
        HYMTaskModel *model = [[HYMTaskModel alloc] initWithDictionary:dic];
        [self.fanliArr addObject:model];
        
        self.tableView.fanliArr = self.fanliArr;
        [self.tableView reloadData];
        
        
      
    }
}
#pragma mark 右上角按钮
- (void)initWithBarItem{
    
    UIButton *record = [UIButton buttonWithType:UIButtonTypeCustom];
    record.frame = CGRectMake(0, 0, 18, 19);
    record.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"taskZhangdan"]];
    [record addTarget:self action:@selector(recordAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:record];

    UIButton *message = [UIButton buttonWithType:UIButtonTypeCustom];
    message.frame = CGRectMake(0, 0, 20, 20);
    [message setImage:[UIImage imageNamed:@"任务消息"] forState:UIControlStateNormal];
    [self.navigationController.navigationBar addSubview:message];
    
    UIBarButtonItem *recordItem = [[UIBarButtonItem alloc] initWithCustomView:record];
    UIBarButtonItem *messageItem = [[UIBarButtonItem alloc] initWithCustomView:message];
    
    self.navigationItem.rightBarButtonItems = @[messageItem,recordItem];
    
}

#pragma mark 记录按钮事件
- (void)recordAct:(UIButton *)record{

    HYMRecordVC *recordVC = [[HYMRecordVC alloc] init];
    [self.navigationController pushViewController:recordVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.segmentView addSubview:self.lineView];
    [self.navigationController.navigationBar addSubview:self.segmentView];
}
- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [self.segmentView removeFromSuperview];
}
@end
