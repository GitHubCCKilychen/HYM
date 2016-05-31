//
//  HYMMallVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/20.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMMallVC.h"
#import "MallScrollView.h"
#import "HYMStoreTableView.h"
#import "HYMMallModel.h"
#import "HYMMallListModel.h"
@interface HYMMallVC ()

@property (nonatomic,strong)HYMStoreTableView *tableView;
@property (nonatomic,strong)MallScrollView *scrollView;
@property (nonatomic,strong)NSMutableArray *datalist;
@property (nonatomic,strong)NSMutableArray *list;
@end

@implementation HYMMallVC

#pragma mark 懒加载
-(MallScrollView *)scrollView{

    if (_scrollView == nil) {
        
        _scrollView = [[MallScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth, 150)];
        _scrollView.backgroundColor = [UIColor grayColor];
    }
    
    return _scrollView;
}
-(HYMStoreTableView *)tableView{

    if (_tableView == nil) {
        _tableView = [[HYMStoreTableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = self.scrollView;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self loadData];
    [self load2];
    [self initDefault];
    [self initWithView];
    
}

- (void)loadData{
  
   
    self.datalist = [NSMutableArray array];
  

    NSDictionary *dic = @{@"sellerid":@"无",@"keyid":@"0",@"client_id":@"无",@"ordertype":@"desc",@"keytype":@"7",@"page":@"0",@"orderby":@"2"};
    NSMutableDictionary *nsdic = [NSMutableDictionary dictionaryWithDictionary:dic];
    //网络请求
    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/v203/blog_list" target:self selector:@selector(loadData:) parameter:nsdic];
    
    
}

- (void)loadData:(NSDictionary *)infor{
    
    [self.datalist removeAllObjects];
    [self.list removeAllObjects];
    NSDictionary *dic = [infor objectForKey:@"infor"];
    NSArray *listItems = [dic objectForKey:@"listItems"];
    for (NSDictionary *dic in listItems) {
    
        HYMMallModel *model = [[HYMMallModel alloc] initWithDictionary:dic];
     
        [self.datalist addObject:model];
        
        self.tableView.datalist  =self.datalist;
//       
    }

}


- (void)load2{
    
      self.list = [NSMutableArray array];
    NSDictionary *dic2 = @{@"sellerid":@"无",@"keyid":@"0",@"client_id":@"无",@"ordertype":@"desc",@"keytype":@"6",@"page":@"0",@"orderby":@"2"};
    NSMutableDictionary *nsdic2 = [NSMutableDictionary dictionaryWithDictionary:dic2];
    //网络请求
    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/v203/blog_list" target:self selector:@selector(loadData2:) parameter:nsdic2];
}

- (void)loadData2:(NSDictionary *)infor{

    NSDictionary *dic = [infor objectForKey:@"infor"];
    NSArray *listItems = [dic objectForKey:@"listItems"];
    for (NSDictionary *dic in listItems) {
        
        HYMMallListModel *model = [[HYMMallListModel alloc] initWithDictionary:dic];
        
        [self.list addObject:model];
        
        self.tableView.list  =self.datalist;
        //
    }
    
}

- (void)initDefault{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"薅羊毛商城";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    
    UIButton *newBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    newBtn.frame = CGRectMake(0, 0, 30, 30);
    //图片不正确
    [newBtn setImage:[UIImage imageNamed:@"消息"] forState:UIControlStateNormal];
    newBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:newBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

    
}
#pragma mark 初始化
- (void)initWithView{

    
    
    [self.view addSubview:self.tableView];
}

@end
