//
//  HYMUploadTask.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/10.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMUploadTask.h"
#import "HYMUpHeader.h"
#import "HYMUpTable.h"
#import "HYMUpModel.h"
@interface HYMUploadTask ()

@property (nonatomic,strong)HYMUpHeader *header;
@property (nonatomic,strong)HYMUpTable *tableView;
@property (nonatomic,strong)NSMutableArray *datalist;
@end

@implementation HYMUploadTask

- (HYMUpHeader *)header{

    if (_header == nil) {
        
        _header = [[HYMUpHeader alloc] init];
        _header.frame = CGRectMake(0, 0, kScreenWitdth, 110);
    }
    return _header;
}

- (HYMUpTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMUpTable alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _tableView.tableHeaderView = self.header;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self initDefault];
    [self initWithView];
}

- (void)initDefault{

    self.view.backgroundColor= [UIColor whiteColor];
    self.title = @"上传任务";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    
    UIButton *help = [UIButton buttonWithType:UIButtonTypeCustom];
    [help setImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
    help.frame = CGRectMake(0, 0, 20, 20);
    [self.navigationController.navigationBar addSubview:help];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:help];
    self.navigationItem.rightBarButtonItem = right;
    
}
#pragma mark 帮助
- (void)helpAct:(UIButton *)btn{

    
}

#pragma mark view
- (void)initWithView{
    [self.view addSubview:self.tableView];
    
}

#pragma mark 数据
- (void)loadData{

    
    self.datalist = [NSMutableArray array];
    NSDictionary *dic = @{@"audit_status":@"0",@"page":@"1",@"token":@"1"};
    NSMutableDictionary *nsdic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/center/task_list_forward" target:self selector:@selector(loadData:) parameter:nsdic];
    
}

- (void)loadData:(NSDictionary *)infor{

    NSDictionary *dic = [infor objectForKey:@"infor"];
    
    NSArray *listItems = [dic objectForKey:@"listItems"];
    
    for (NSDictionary *dic in listItems) {
        
        HYMUpModel *model = [[HYMUpModel alloc] initWithDictionary:dic];
        
        [self.datalist addObject:model];
        self.tableView.datalist = self.datalist;
        [self.tableView reloadData];

    }
}
@end
