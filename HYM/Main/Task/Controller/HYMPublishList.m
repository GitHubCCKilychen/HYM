//
//  HYMPublishList.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/11.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPublishList.h"
#import "HYMTaskList.h"
#import "HYMNeedHelp.h"
#import "HYMPubListModel.h"
#import "HYMReadyView.h"
@interface HYMPublishList ()

@property (nonatomic,strong)HYMTaskList *taskList;
@property (nonatomic,strong)NSMutableArray *datalist;
@property (nonatomic,strong)HYMReadyView *readyView;
@end

@implementation HYMPublishList

- (HYMReadyView *)readyView{

    if (_readyView == nil) {
        
        _readyView = [[HYMReadyView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth, 40)];

    }
    return _readyView;
}

- (HYMTaskList *)taskList{

    if (_taskList == nil) {
        
        _taskList = [[HYMTaskList alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth, kScreenHeight)];
        _taskList.tableHeaderView = self.readyView;
    }
    return _taskList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self initDefault];
    [self initWithView];
}

- (void)loadData{

    
    self.datalist = [NSMutableArray array];
    NSDictionary *dic = @{@"page":@"1",@"token":@"1",@"audit_status":@"1"};
    NSMutableDictionary *dics = [NSMutableDictionary dictionaryWithDictionary:dic];
    [XTomRequest requestWithURL:@"http://123.56.237.91/index.php/Webservice/center/task_list_forward" target:self selector:@selector(loadData:) parameter:dics];
}
- (void)loadData:(NSDictionary *)dic{
    

    NSDictionary *infor = [dic objectForKey:@"infor"];
    NSArray *listItems = [infor objectForKey:@"listItems"];
    
    for (NSDictionary *dic in listItems) {
     
        HYMPubListModel *model = [[HYMPubListModel alloc] initWithDictionary:dic];
        
        [self.datalist addObject:model];
        self.taskList.datalist = self.datalist;
        
        NSString *indexString = [dic objectForKey:@"id"];
        int index = [indexString intValue];
        self.taskList.index = index;
        
    }
//    
//    NSLog(@"%@",dic);
}

- (void)initDefault{

    self.title = @"发布任务";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *right =[UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, 30, 30);
    [right setImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(helpAcct:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:right];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)initWithView{

    
    [self.view addSubview:self.taskList];
}

#pragma mark 帮助
- (void)helpAcct:(UIButton *)btn{

    HYMNeedHelp *help = [[HYMNeedHelp alloc] init];
    help.indexString = @"1";
    [self.navigationController pushViewController:help animated:YES];
    
    
}

@end
