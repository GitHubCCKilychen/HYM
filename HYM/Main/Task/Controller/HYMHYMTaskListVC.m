//
//  HYMHYMTaskListVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/27.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMHYMTaskListVC.h"
#import "HYMTasklistTable.h"
#import "HYMTaskRecordModel.h"
@interface HYMHYMTaskListVC ()
@property (nonatomic,strong)HYMTasklistTable *tableView;
@property (nonatomic,strong)NSMutableArray *datalist;
@end

@implementation HYMHYMTaskListVC


- (HYMTasklistTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMTasklistTable alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDefault];
    [self initView];
}
- (void)initDefault{

    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initView{

    [self.view addSubview:self.tableView];
}

- (void)setIndex:(int)index{

    _index = index;
    [self loadData:_index];
}

#pragma mark 数据
- (void)loadData:(NSInteger)index{
    
    self.datalist = [NSMutableArray array];
    NSString *orderValue = [NSString stringWithFormat:@"%ld",(long)index+1];
  
    NSDictionary *dic = @{@"type":orderValue,@"page":@"1",@"token":@"1",};
    NSMutableDictionary *nsdic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [XTomRequest requestWithURL:@"http://123.56.237.91/index.php/Webservice/center/task_list_ower" target:self selector:@selector(msgData:) parameter:nsdic];

}

- (void)msgData:(NSDictionary *)dic{
    

    
    NSDictionary *infor = [dic objectForKey:@"infor"];
    NSArray *listItems = [infor objectForKey:@"listItems"];    
    for (NSDictionary *dic in listItems) {
        
        if ([dic isEqual:[NSNull null]]) {
            
            return;
        }else{
        
            HYMTaskRecordModel  *model = [[HYMTaskRecordModel alloc] initWithDictionary:dic];
            [self.datalist addObject:model];
            self.tableView.datalist = self.datalist;
        }
        
        
    
    }
    
}
@end
