//
//  HYMListPerson.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/31.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMListPerson.h"
#import "HYMInforTable.h"
#import "HYMMoneyListView.h"
#import "HYMInforModel.h"
#import "HYMInfoSectionView.h"
@interface HYMListPerson ()

@property (nonatomic,strong)HYMInforTable *tableView;
@property (nonatomic,strong)NSMutableArray *datalist;
@property (nonatomic,strong)HYMInfoSectionView *headView;
@end

@implementation HYMListPerson

- (HYMInfoSectionView *)headView{

    if (_headView == nil) {
        
        _headView = [[HYMInfoSectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth, 75)];
    }
    return _headView;
}
- (HYMInforTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMInforTable alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = self.headView;
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

    self.title = @"个人信息";
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
    
    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/?m=Center&a=get_client_info" target:self selector:@selector(loadData:) parameter:nsdic];
}

- (void)loadData:(NSDictionary *)dic{

    NSDictionary *infro = [dic objectForKey:@"infor"];
    
    HYMInforModel *model = [[HYMInforModel alloc] initWithDictionary:infro];
    [self.datalist addObject:model];
    self.tableView.datalist = self.datalist;
    
//    NSLog(@"%@",dic);
    
}
@end
