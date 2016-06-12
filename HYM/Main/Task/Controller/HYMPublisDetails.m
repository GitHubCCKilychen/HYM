//
//  HYMPublisDetails.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/31.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPublisDetails.h"
#import "HYMPublishTable.h"
#import "HYMPublishHeader.h"
#import "HYMPublishBottom.h"
@interface HYMPublisDetails ()

@property (nonatomic,strong)HYMPublishTable *tableView;
@property (nonatomic,strong)HYMPublishHeader *headerView;
@property (nonatomic,strong)HYMPublishBottom *bottom;
@end

@implementation HYMPublisDetails

- (HYMPublishHeader *)headerView{

    if (_headerView == nil) {
        
        _headerView = [[HYMPublishHeader alloc] initWithFrame:CGRectMake(0, 64, kScreenWitdth, 120)];
    }
    return _headerView;
}

- (HYMPublishTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMPublishTable alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = self.bottom;
    }
    return _tableView;
}


- (HYMPublishBottom *)bottom{

    if (_bottom == nil) {
        
        _bottom = [[HYMPublishBottom alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth, 60)];
    }
    return _bottom;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self initDefault];
    [self initView];
}

#pragma mark 数据
- (void)loadData{

    NSDictionary *dic = @{@"id":@"1"};
    
    NSMutableDictionary *nsdic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/Task/task_info" target:self selector:@selector(loadData:) parameter:nsdic];
    
}


- (void)loadData:(NSDictionary *)dic{

    NSDictionary *infor = [dic objectForKey:@"infor"];
    NSArray *listItems = [infor objectForKey:@"listItems"];
    for (NSDictionary *dic in listItems) {
        NSLog(@"%@",dic);
    }

}
-(void)initDefault{

    self.title = @"任务详情";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initView{

    [self.view addSubview:self.tableView];

    
}

@end
