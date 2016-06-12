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

    [self segumentSelectionChange:0];
    [self initDeafult];
    [self initView];
    

}
- (void)initDeafult{

    self.title = @"资金明细";
   [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initView{

    [self.view addSubview:self.segmentView];
    [self.view addSubview:self.tableView];
}


-(void)segumentSelectionChange:(NSInteger)selection{

    
    [self loadData:selection];
}

#pragma mark 数据
- (void)loadData:(NSInteger)index{
    
    self.datalist = [NSMutableArray array];
    
    if (index == 2 ||index == 3 ) {
        
        return;
        
    }else{
    
        
        NSString *indexStr = [NSString stringWithFormat:@"%ld",(long)index];
        NSDictionary *dic = @{@"page":@"1",@"type":indexStr,@"token":@"1"};
        
        NSMutableDictionary *nsDic= [NSMutableDictionary dictionaryWithDictionary:dic];
        //网络请求
        [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/center/money_detail" target:self selector:@selector(loadMoneyData:) parameter:nsDic];
        
        
    }
    
}

- (void)loadMoneyData:(NSDictionary *)dic{
    
   
    NSDictionary *infor = [dic objectForKey:@"infor"];
    NSArray *listItems = [infor objectForKey:@"listItems"];
    
    for (NSDictionary *dic in listItems) {
        HYMRemindModel *model = [[HYMRemindModel alloc] initWithDictionary:dic];
        [self.datalist addObject:model];
        self.tableView.datalist = self.datalist;
    }

    NSLog(@"%@-%@",dic,[dic objectForKey:@"msg"]);
    
}

@end
