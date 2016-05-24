//
//  HYMCommunityVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMCommunityVC.h"
#import "HYMCommView.h"
#import "HYMSegmentView.h"
#import "HYMCommTable.h"
#import "HYMCommSegment.h"
#import "HYMSelectedPost.h"
#import "HYMPostVC.h"
#import "HYMCommModel.h"
@interface HYMCommunityVC ()<HYMSegmentViewDelegate,HYMCommSegmentDelegate>

@property (nonatomic,strong)HYMCommView *commView;
@property (nonatomic,strong)HYMSegmentView *segmentView;
@property (nonatomic,strong)HYMCommTable *tableView;
@property (nonatomic,strong)HYMCommSegment *sortView;
@property (nonatomic,strong)HYMSelectedPost *post;//帖子
@property (nonatomic,strong)NSMutableArray *datalist;
@property (nonatomic,assign)NSInteger index;


@end

@implementation HYMCommunityVC

#pragma mark 懒加载


- (HYMSelectedPost *)post{

    if (_post == nil) {
        
        _post = [[HYMSelectedPost alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _post;
}

- (HYMCommView *)commView{

    if (_commView == nil) {
        _commView = [[HYMCommView alloc] init];
        _commView.frame = CGRectMake(0, 124, kScreenWitdth, 30);
    }
    return _commView;
}

- (HYMCommSegment *)sortView{

    if (_sortView == nil) {
        
        NSArray *titleArr = @[@"分类",@"时间",@"阅读量",@"评价量"];
        _sortView = [HYMCommSegment segmenFrame:CGRectMake(0, 64, kScreenWitdth, 50) titleDataSource:titleArr backgroundColor:[UIColor whiteColor] titleColor:[UIColor lightGrayColor] titleFont:[UIFont systemFontOfSize:15] selectedColor:[UIColor orangeColor] buttonDownColor:[UIColor clearColor] delegate:self];
    }
    return _sortView;
}
- (HYMSegmentView *)segmentView{

    if (_segmentView == nil) {
        
        NSArray *title = @[@"网赚",@"信用卡"];
        _segmentView = [HYMSegmentView segmenFrame:CGRectMake(0, 0, kScreenWitdth-kScreenWitdth/2.5, 44) titleDataSource:title backgroundColor:[UIColor clearColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:15] selectedColor:[UIColor redColor] buttonDownColor:[UIColor redColor] delegate:self];
    }
    return _segmentView;
}

- (HYMCommTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMCommTable alloc] initWithFrame:CGRectMake(0, 164, kScreenWitdth, kScreenHeight-49-164) style:UITableViewStyleGrouped];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:235/256.f green:235/256.f blue:241/256.f alpha:1];
    
    [self loadData];
    //默认配置

    [self initDefault];
    //控件
    [self initWithView];
}
- (void)loadData{

    self.datalist = [NSMutableArray array];
    
    //默认设置为网赚
    [self segumentSelectionChange:0];
    //分类
    [self segSelectionChange:0];
}

- (void)loadData:(NSDictionary *)infor{

}
#pragma mark 默认
- (void)initDefault{
    
    UIButton *editBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.backgroundColor = [UIColor grayColor];
    editBtn.frame = CGRectMake(0, 0, 30, 30);
    [editBtn addTarget:self action:@selector(editAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:editBtn];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.backgroundColor = [UIColor brownColor];
    searchBtn.frame = CGRectMake(0, 0, 30, 30);
    [self.navigationController.navigationBar addSubview:searchBtn];
    
    
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    messageBtn.frame = CGRectMake(0, 0, 30, 30);
    messageBtn.backgroundColor = [UIColor greenColor];
    [self.navigationController.navigationBar addSubview:messageBtn];
    
    
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    UIBarButtonItem *messageItem = [[UIBarButtonItem alloc] initWithCustomView:messageBtn];
    self.navigationItem.rightBarButtonItems = @[messageItem,searchItem,editItem];
}
#pragma mark 控件
- (void)initWithView{


    [self.view addSubview:self.sortView];
    [self.view addSubview:self.commView];
    [self.view addSubview:self.tableView];
    
   

}

#pragma mark 帖子发表
- (void)editAct:(UIButton *)btn{

    HYMPostVC *postVC = [[HYMPostVC alloc] init];
    [self.navigationController  pushViewController:postVC animated:YES];
    
}
#pragma mark 网赚－－－信用卡
-(void)segumentSelectionChange:(NSInteger)selection{
    
  
    [self inforData:selection];
}
#pragma mark 网赚

- (void)inforData:(NSInteger )index{


    self.index = 5;
    if (index == 1){
    
        self.index = 3;
    }
    
    NSString *indexString = [NSString stringWithFormat:@"%ld",(long)self.index];
    
    
   
    NSDictionary *money = @{@"sellerid":@"无",@"keyid":indexString,@"client_id":@"1",@"ordertype":@"desc",@"keytype":@"2",@"page":@"0",@"orderby":@"1"};
    
    NSMutableDictionary *nsdic = [NSMutableDictionary dictionaryWithDictionary:money];
    [self.datalist removeAllObjects];
    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/v203/blog_list" target:self selector:@selector(infoData:) parameter:nsdic];
    
    
}
- (void)infoData:(NSDictionary *)dic{


    NSDictionary *infor = [dic objectForKey:@"infor"];
    NSArray *listItems = [infor objectForKey:@"listItems"];
    

    for (NSDictionary *dic in listItems) {
        
        HYMCommModel *model = [[HYMCommModel alloc] initWithDictionary:dic];
        [self.datalist addObject:model];
        
        self.tableView.datalist = self.datalist;

        
        [self.tableView reloadData];
    }
}


#pragma mark 分类
-(void)segSelectionChange:(NSInteger)selection{

    self.index = 5;
    if (selection == 1){
        
        self.index = 3;
    }
    
    NSString *indexString = [NSString stringWithFormat:@"%ld",(long)self.index];
    
    
    
    if (selection == 0) {
       
        //此处是分类的网络请求
        NSDictionary *dic = @{@"keytype":@"2"};
        
        NSMutableDictionary *nsdic = [NSMutableDictionary dictionaryWithDictionary:dic];
        
        [self.datalist removeAllObjects];
        [self.datalist removeAllObjects];
        [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/v203/public_type_list" target:self selector:@selector(classData:) parameter:nsdic];
    }else{
    
        
        //根据排序的值设置
        NSString *orderString = [NSString stringWithFormat:@"%ld",(long)selection];
        //此处问题
        NSDictionary *money = @{@"sellerid":@"无",@"keyid":indexString,@"client_id":@"1",@"ordertype":@"desc",@"keytype":@"2",@"page":@"0",@"orderby":orderString};
        
        NSMutableDictionary *nsdic = [NSMutableDictionary dictionaryWithDictionary:money];
        [self.datalist removeAllObjects];
        [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/v203/blog_list" target:self selector:@selector(infoData:) parameter:nsdic];
    }
    }
 

#pragma mark 分类
- (void)classData:(NSDictionary *)dic{

    
//    NSLog(@"---%@",dic);

    NSDictionary *infro = [dic objectForKey:@"infor"];
    NSArray *listItems = [infro objectForKey:@"listItems"];
    
    
    
    for (NSDictionary *dics in listItems) {
        
      
        HYMCommModel *model = [[HYMCommModel alloc] initWithDictionary:dics];
        [self.datalist addObject:model];
        
//        NSLog(@"%@",model.name);
//        self.tableView.datalist = self.datalist;
//        [self.tableView reloadData];
    }
    
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar addSubview:self.segmentView];
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    [self.segmentView removeFromSuperview];
}
@end
