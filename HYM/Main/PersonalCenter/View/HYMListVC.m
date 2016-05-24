//
//  HYMListVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMListVC.h"
#import "HYMSegmentView.h"
#import "HYMListTable.h"
#import "HYMListModel.h"
@interface HYMListVC ()<HYMSegmentViewDelegate>

@property (nonatomic,strong)HYMSegmentView *segment;
@property (nonatomic,strong)HYMListTable *tableView;
@property (nonatomic,strong)NSMutableArray *datalist;
@end

@implementation HYMListVC

- (HYMListTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMListTable alloc] initWithFrame:CGRectMake(0, 104, kScreenWitdth, kScreenHeight-104)];
    }
    return _tableView;
}

- (HYMSegmentView *)segment{

    if (_segment == nil) {
        
        NSArray *titleArr = @[@"进行中",@"暂停中",@"已完成",@"已过期",@"已下架"];
        _segment = [HYMSegmentView segmenFrame:CGRectMake(0, 64, kScreenWitdth, 30) titleDataSource:titleArr backgroundColor:[UIColor whiteColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:13] selectedColor:[UIColor orangeColor] buttonDownColor:[UIColor orangeColor] delegate:self];
    }
    return _segment;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self initDefault];
    [self initWithView];
}

#pragma mark 数据
- (void)loadData{

    self.datalist = [NSMutableArray array];
    [self segumentSelectionChange:0];
}

- (void)initDefault{
    
    self.title = @"推单列表";
    self.view.backgroundColor = BB_Back_Color_Here;

}

- (void)initWithView{

    [self.view addSubview:self.segment];
    [self.view addSubview:self.tableView];
}
-(void)segumentSelectionChange:(NSInteger)selection{
    
    
    self.tableView.selection = selection;
    
    
    [self loadData:selection];

}

#pragma mark 数据
- (void)loadData:(NSInteger)index{

    
    NSString *indexString = [NSString stringWithFormat:@"%ld",(long)index];
    NSDictionary *dic = @{@"status":indexString,@"page":@"1",@"token":@"1"};
    NSMutableDictionary *nsDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [self.datalist removeAllObjects];
     [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/center/task_status_ower" target:self selector:@selector(infoData:) parameter:nsDic];
    
}

- (void)infoData:(NSDictionary *)dic{

    NSDictionary *infor = [dic objectForKey:@"infor"];
    NSArray *listItems = [infor objectForKey:@"listItems"];
    for (NSDictionary *dic in listItems) {
        
        HYMListModel *model = [[HYMListModel alloc] initWithDictionary:dic];
        
        [self.datalist addObject:model];
        
        self.tableView.datalistl = self.datalist;
     
        [self.tableView reloadData];
    }

    
}
@end
