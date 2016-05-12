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
@interface HYMTaskVC ()<HYMSegmentViewDelegate,HYMSortViewDelegate>
@property (nonatomic,strong)HYMSegmentView *segmentView;
@property (nonatomic,strong)HYMTaskTableView *tableView;
@property (nonatomic,strong)HYMSortView *sortView;
@property (nonatomic,strong)NSMutableArray *listArr;
@property (nonatomic,strong)NSMutableArray *fanliArr;

/**
 *  类型type
 */
@property (nonatomic,assign)NSInteger typeValue;
@end

@implementation HYMTaskVC

#pragma mark 懒加载

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
        _sortView = [HYMSortView setFrame:CGRectMake(0, 64, kScreenWitdth, 45) titleDataSource:title backgroudColor:[UIColor whiteColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:15] selectedColor:[UIColor blueColor] buttonDownColor:[UIColor orangeColor] delegate:self];
        
    }
    
    return _sortView;
}
- (HYMSegmentView *)segmentView{

    if (_segmentView == nil) {
        
        NSArray *title = @[@"精选",@"返利单",@"新手单",@"银行单"];
        _segmentView = [HYMSegmentView segmenFrame:CGRectMake(0, 0, kScreenWitdth-95, 44) titleDataSource:title backgroundColor:[UIColor clearColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:15] selectedColor:[UIColor orangeColor] buttonDownColor:[UIColor redColor] delegate:self];
    }
    
    return _segmentView;
}

-(HYMTaskTableView *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMTaskTableView alloc] initWithFrame:CGRectMake(0, 110, kScreenWitdth, kScreenHeight)style:UITableViewStyleGrouped];
        
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


#pragma mark 数据
- (void)loadData{
    
    NSMutableDictionary *dics = [NSMutableDictionary dictionary];
    [XTomRequest requestWithURL:@"http://123.56.237.91/index.php/Webservice/?m=Base&a=task_select" target:self selector:@selector(taskData:) parameter:dics];
//
    
//    [self segumentSelectionChange:0];
    
}


- (void)taskData:(NSDictionary *)taskDic{
    
    NSArray *infor = [taskDic objectForKey:@"infor"];
    
    for (NSDictionary *dic in infor) {
        
        HYMTaskModel *model = [[HYMTaskModel alloc] initWithDictionary:dic];
        
        [self.listArr addObject:model];
        
        self.tableView.listArr = self.listArr;
        
        [self.tableView reloadData];
        
    }
}
#pragma mark initview
- (void)initDefault{
    
  
}

#pragma mark initview
- (void)initWithView{
    [self.view addSubview:self.sortView];
    [self.view addSubview:self.tableView];
    
}

#pragma mark 代理方法
- (void)segumentSelectionChange:(NSInteger)selection{
    
    self.tableView.index = selection;
    
    NSString *typeValue = [NSString stringWithFormat:@"%ld",(long)selection];
     NSString *url = [NSString stringWithFormat:@"%@%@",REQUEST_Root_Net,REQUEST_Task_List];
    NSDictionary *dic = @{@"type":typeValue,@"order":@"1",@"sort":@"1",@"page":@"1",@"brand":@"1"};
    NSMutableDictionary *nsdic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [XTomRequest requestWithURL:url target:self selector:@selector(loadData:) parameter:nsdic];
    
    

    switch (selection) {
        case 0:
            
            break;
        case 1:
            break;
        case 2:
            break;
        default:
            break;
    }
}
#pragma mark 
- (void)loadData:(NSDictionary *)dic{


//    NSDictionary *infor = [dic objectForKey:@"infor"];
//    
//    
//    NSDictionary *listItem = [infor objectForKey:@"listItems"];
//   
//    for (NSArray *listArrsss in listItem) {
//        
//        self.tableView.fanliArr = listArrsss;
//    
//        [self.tableView reloadData];
//      
//    }
}
#pragma mark 默认－期限－收益
- (void)selectedBtnChange:(NSInteger)selectedBtn{

    
}


#pragma mark 右上角按钮
- (void)initWithBarItem{
    
    UIButton *record = [UIButton buttonWithType:UIButtonTypeCustom];
    record.frame = CGRectMake(0, 0, 28, 28);
    record.backgroundColor = [UIColor grayColor];
    [record addTarget:self action:@selector(recordAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:record];

    UIButton *message = [UIButton buttonWithType:UIButtonTypeCustom];
    message.frame = CGRectMake(0, 0, 28, 28);
    message.backgroundColor = [UIColor blueColor];
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
    
    [self.navigationController.navigationBar addSubview:self.segmentView];
}
- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [self.segmentView removeFromSuperview];
}
@end
