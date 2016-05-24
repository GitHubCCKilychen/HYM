//
//  HYMGoDetailsVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMGoDetailsVC.h"
#import "HYMGoTable.h"
@interface HYMGoDetailsVC ()

@property (nonatomic,strong)HYMGoTable *tableView;
@end

@implementation HYMGoDetailsVC

- (HYMGoTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMGoTable alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self initDefault];
    [self initWithView];
}

#pragma mark 数据
- (void)loadData{

    //此处是分类的网络请求
    //任务id-task_id
    NSDictionary *dic = @{@"task_id":@"1",@"publish_status":@"1",@"token":@"1"};
    
    NSMutableDictionary *nsdic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/center/client_center_info" target:self selector:@selector(loadData:) parameter:nsdic];
    
}
#pragma mark 数据
- (void)loadData:(NSDictionary *)dic{

    NSDictionary *infor = [dic objectForKey:@"infor"];
    
    
}
- (void)initDefault{

    
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
}

- (void)initWithView{

    [self.view addSubview:self.tableView];
}


- (void)setSelection:(NSInteger)selection{

    _selection = selection;
    self.tableView.selection = selection;
    
    switch (selection) {
        case 0:
          self.title = @"进行中的任务详情";
            break;
        case 1:
          self.title = @"暂停中的任务详情";
        default:
            break;
    }
    
}


@end
