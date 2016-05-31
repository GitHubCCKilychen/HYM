//
//  HYMCheckForm.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMCheckForm.h"
#import "HYMCheckTable.h"
#import "HYMCheckView.h"
#import "HYMNeedHelp.h"
#import "HYMCheckModel.h"
@interface HYMCheckForm ()

@property (nonatomic,strong)HYMCheckTable *tableView;
@property (nonatomic,strong)HYMCheckView *headerView;
@property (nonatomic,strong)NSMutableArray *datalist;
@end

@implementation HYMCheckForm

- (HYMCheckView *)headerView{

    if (_headerView == nil) {
        
        _headerView = [[HYMCheckView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth, 50)];
    }
    return _headerView;
}

- (HYMCheckTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMCheckTable alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self initDeault];
    [self initWithView];
    
}

- (void)loadData{

    self.datalist = [NSMutableArray array];
    NSDictionary *dic = @{@"page":@"1",@"token":@"1"};
    NSMutableDictionary *nsDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/center/task_sign_check" target:self selector:@selector(loadData:) parameter:nsDic];
    
    
}
- (void)loadData:(NSDictionary *)dic{

    
    NSLog(@"%@",dic);
    NSDictionary *infor = [dic objectForKey:@"infor"];
    NSArray *listItems = [infor objectForKey:@"listItems"];
    
    for (NSDictionary *dic in listItems) {
        
        HYMCheckModel *model = [[HYMCheckModel alloc] initWithDictionary:dic];
        [self.datalist addObject:model];
        
        self.tableView.datalist = self.datalist;
        
    }
}
#pragma mark 默认配置
- (void)initDeault{

    self.title = @"审核报单";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    
    UIButton *help = [UIButton buttonWithType:UIButtonTypeCustom];
    [help setImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
    help.frame = CGRectMake(0, 0, 20, 20);
    [help addTarget:self action:@selector(helpAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:help];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:help];
    self.navigationItem.rightBarButtonItem = right;
    
}

- (void)initWithView{

    [self.view addSubview:self.tableView];
    
}


- (void)helpAct:(UIButton *)btn{

    
    HYMNeedHelp *help = [[HYMNeedHelp  alloc] init];
    help.indexString = @"5";
    [self.navigationController pushViewController:help animated:YES ];
}



@end
