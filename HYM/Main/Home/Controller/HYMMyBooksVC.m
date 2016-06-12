//
//  HYMMyBooksVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/27.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMMyBooksVC.h"
#import "HYMMyBooksTableView.h"
#import "HYMMyBookModel.h"
@interface HYMMyBooksVC ()

@property (nonatomic,strong)HYMMyBooksTableView *tableView;
@property (nonatomic,strong)NSMutableArray *datalist;
@end

@implementation HYMMyBooksVC

#pragma mark 懒加载
- (NSMutableArray *)datalist{

    if (_datalist == nil) {
        
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}
-(HYMMyBooksTableView *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMMyBooksTableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self loadData];
    [self initWithDefaults];
    
    [self initWithView];
}

#pragma mark 数据
- (void)loadData{
    
    NSDictionary *dic = @{@"page":@"1",@"token":@"1"};

    NSMutableDictionary *nsDic= [NSMutableDictionary dictionaryWithDictionary:dic];
    //网络请求
    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/?m=base&a=blog_list_index" target:self selector:@selector(loadData:) parameter:nsDic];
    
    
}

- (void)loadData:(NSDictionary *)infor{

    NSDictionary *dic = [infor objectForKey:@"infor"];
    NSArray *listItems = [dic objectForKey:@"listItems"];
    for (NSDictionary *dic in listItems) {
        
        HYMMyBookModel *model = [[HYMMyBookModel alloc] initWithDictionary:dic];
        [self.datalist addObject:model];
        
        self.tableView.datalist = self.datalist;
    }
    
}
#pragma mark 默认配置
- (void)initWithDefaults{

    self.title = @"赎回提醒";
    self.view.backgroundColor = [UIColor whiteColor];
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
}


#pragma mark initview
- (void)initWithView{

    [self.view addSubview:self.tableView];
}
@end
