//
//  HYMDetailsVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/5.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMDetailsVC.h"
#import "HYMDetailsTable.h"
#import "HYMDetailsBottom.h"
#import "HYMNeedHelp.h"
@interface HYMDetailsVC ()

@property (nonatomic,strong)HYMDetailsTable *tableView;
@property (nonatomic,strong)HYMDetailsBottom *bottomView;
@end

@implementation HYMDetailsVC

- (HYMDetailsBottom *)bottomView{

    if (_bottomView == nil) {
        
        _bottomView = [[HYMDetailsBottom alloc] init];
        _bottomView.frame = CGRectMake(0, 0, kScreenWitdth, 125);
    }
    return _bottomView;
}

- (HYMDetailsTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMDetailsTable alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.tableFooterView = self.bottomView;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //数据
    [self loadData];
    //配置
    [self initDefault];
    //控件
    [self initWithView];
}

#pragma mark 数据
- (void)loadData{

    //图文信息接口
    
    //ID值不对，
    NSDictionary *dic = @{@"id":@"1",@"description":@"234345",@"content":@"123432",@"token":@"1"};
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    //网络请求
    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/Task/task_image_text" target:self selector:@selector(infoData:) parameter:infoDic];
}

- (void)infoData:(NSDictionary *)dic{

    //展示ID值暂时不对
   // NSLog(@"%@-%@",dic,[dic objectForKey:@"msg"]);
}
#pragma mark 配置
- (void)initDefault{

    self.title = @"任务详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
    [btn setImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:btn];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark 控件
- (void)initWithView{

    
    [self.view addSubview:self.tableView];
    
}

#pragma mark 事件
- (void)rightAct:(UIButton *)btn{

    HYMNeedHelp *help = [[HYMNeedHelp alloc] init];
    help.indexString = @"1";
    [self.navigationController pushViewController:help animated:YES];
    
}
@end
