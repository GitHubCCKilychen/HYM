//
//  HYMHomeMsgVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/27.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMHomeMsgVC.h"
#import "HYMHomeMsgTable.h"
#import "HYMHomeMsgModel.h"
@interface HYMHomeMsgVC ()
@property (nonatomic,strong)HYMHomeMsgTable *tableView;
@property (nonatomic,strong)NSMutableArray *datalist;
@end

@implementation HYMHomeMsgVC

-(HYMHomeMsgTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMHomeMsgTable alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadData];
    [self initDefault];
    [self initView];
}


#pragma mark 数据
- (void)loadData{

    self.datalist = [NSMutableArray array];
    NSDictionary *dic = @{@"page":@"0",@"token":@"1",@"noticetype":@"1"};
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    //网络请求
    [XTomRequest  requestWithURL:@"http://123.56.237.91//index.php/Webservice/v203/notice_list" target:self selector:@selector(loadData:) parameter:infoDic];
}
- (void)loadData:(NSDictionary *)dic{

    NSDictionary *infor = [dic objectForKey:@"infor"];
    NSArray *listItems = [infor objectForKey:@"listItems"];
    for (NSDictionary *dic in listItems) {
        
        HYMHomeMsgModel *model = [[HYMHomeMsgModel alloc] initWithDictionary:dic];
        [self.datalist addObject:model];
        self.tableView.datalist = self.datalist;

        [self.tableView reloadData];
        
    }
    
}
- (void)initDefault{

    self.title = @"消息";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:backBtn];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)initView{

    [self.view addSubview:self.tableView];
}

#pragma mark 返回按钮
- (void)backVC:(UIButton *)back{

    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
