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
#import "HYMComMsgVC.h"
#import "HYMSearchTableVC.h"
#import "PostPublishNewVC.h"
@interface HYMCommunityVC ()<HYMSegmentViewDelegate,HYMCommSegmentDelegate>

@property (nonatomic,strong)HYMCommView *commView;
@property (nonatomic,strong)HYMSegmentView *segmentView;
@property (nonatomic,strong)HYMCommTable *tableView;
@property (nonatomic,strong)HYMCommSegment *sortView;
@property (nonatomic,strong)HYMSelectedPost *post;//帖子
@property (nonatomic,strong)NSMutableArray *datalist;
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,assign)NSInteger idIndex;
@property (nonatomic,strong)NSMutableArray *listArr;
@property (nonatomic,strong)UIView *lineView;


@end

@implementation HYMCommunityVC

#pragma mark 懒加载

- (UIView *)lineView{

    if (_lineView == nil) {
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWitdth-kScreenWitdth/3,0, 0.5,44)];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _lineView;
}

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
        _sortView = [HYMCommSegment segmenFrame:CGRectMake(0, 64, kScreenWitdth, 50) titleDataSource:titleArr backgroundColor:[UIColor whiteColor] titleColor:[UIColor lightGrayColor] titleFont:[UIFont systemFontOfSize:15] selectedColor:[UIColor lightGrayColor] buttonDownColor:[UIColor clearColor] delegate:self];
    }
    return _sortView;
}
- (HYMSegmentView *)segmentView{

    if (_segmentView == nil) {
        
        NSArray *title = @[@"网赚",@"信用卡"];
        _segmentView = [HYMSegmentView segmenFrame:CGRectMake(0, 0, kScreenWitdth-kScreenWitdth/3, 44) titleDataSource:title backgroundColor:[UIColor clearColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:15] selectedColor:[UIColor redColor] buttonDownColor:[UIColor redColor] delegate:self];
    }
    return _segmentView;
}

- (HYMCommTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMCommTable alloc] initWithFrame:CGRectMake(0, 125, kScreenWitdth, kScreenHeight-49-125) style:UITableViewStyleGrouped];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
    //此处参数缺少值
    //分类
    [self segSelectionChange:1];
    
    //此处剩余排序问题

}
#pragma mark 默认
- (void)initDefault{
    
    UIButton *editBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setImage:[UIImage imageNamed:@"论坛编辑"] forState:UIControlStateNormal];
    editBtn.frame = CGRectMake(0, 0, 20, 20);
    [editBtn addTarget:self action:@selector(editAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:editBtn];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage  imageNamed:@"论坛搜索"] forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(0, 0, 20, 20);
    [searchBtn addTarget:self action:@selector(serachAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:searchBtn];
       self.view.backgroundColor = [UIColor colorWithRed:235/256.f green:235/256.f blue:241/256.f alpha:1];
    
    
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    messageBtn.frame = CGRectMake(0, 0,20, 20);
    [messageBtn addTarget:self action:@selector(messAct:) forControlEvents:UIControlEventTouchUpInside];
    [messageBtn setImage:[UIImage imageNamed:@"任务消息"] forState:UIControlStateNormal];
    [self.navigationController.navigationBar addSubview:messageBtn];
    
    
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    UIBarButtonItem *messageItem = [[UIBarButtonItem alloc] initWithCustomView:messageBtn];
    self.navigationItem.rightBarButtonItems = @[messageItem,searchItem,editItem];
}
#pragma mark 控件
- (void)initWithView{


    [self.view addSubview:self.sortView];
    [self.view addSubview:self.tableView];
    
   

}

#pragma mark 帖子发表
- (void)editAct:(UIButton *)btn{

//    HYMPostVC *postVC = [[HYMPostVC alloc] init];
//    [self.navigationController  pushViewController:postVC animated:YES];
    PostPublishNewVC *post = [[PostPublishNewVC alloc]init];
    
    
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
        //变为信用卡--改变下面分类的值
        [self segSelectionChange:0];
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
    //stars-点赞 ／／starscount ／／visitcount－－浏览次数
}


#pragma mark 分类
- (void)segSelectionChange:(NSInteger)selection{

    //初始化字典
    NSDictionary *dic = [NSDictionary dictionary];
    
    //先获取当前事网赚还是信用卡
    
    if (self.index == 5) {
        
//        NSLog(@"网赚");
         NSString *indexString = [NSString stringWithFormat:@"%ld",(long)self.index];
        //根据
        switch (selection) {
            case 0:
            {
                [self photoAct];
            }
                break;
            case 1:
            {
            
             dic = @{@"sellerid":@"无",@"keyid":indexString,@"client_id":@"1",@"ordertype":@"desc",@"keytype":@"2",@"page":@"0",@"orderby":@"1"};
                 [self loadRequest:dic];
            }
                break;
            case 2:
            {
                dic = @{@"sellerid":@"无",@"keyid":indexString,@"client_id":@"1",@"ordertype":@"desc",@"keytype":@"2",@"page":@"0",@"orderby":@"5"};
                 [self loadRequest:dic];
            }
                break;
            case 3:
            {
            
                dic = @{@"sellerid":@"无",@"keyid":indexString,@"client_id":@"1",@"ordertype":@"desc",@"keytype":@"2",@"page":@"0",@"orderby":@"7"};
                 [self loadRequest:dic];
            }
                break;
            default:
                break;
        }
        
    }else if (self.index == 3){
    
    
        NSString *indexString = [NSString stringWithFormat:@"%ld",(long)self.index];
        
               switch (selection) {
            case 0:
            {
//                dic = @{@"sellerid":@"无",@"keyid":indexString,@"client_id":@"1",@"ordertype":@"desc",@"keytype":@"1",@"page":@"0",@"orderby":@"0"};
//                [self bankCategory:dic];
            }
                break;
            case 1:
            {
                
                dic = @{@"sellerid":@"无",@"keyid":indexString,@"client_id":@"1",@"ordertype":@"desc",@"keytype":@"2",@"page":@"0",@"orderby":@"1"};
                [self loadRequest:dic];
            }
                break;
            case 2:
            {
                dic = @{@"sellerid":@"无",@"keyid":indexString,@"client_id":@"1",@"ordertype":@"desc",@"keytype":@"2",@"page":@"0",@"orderby":@"5"};
                [self loadRequest:dic];
            }
                break;
            case 3:
            {
                
                dic = @{@"sellerid":@"无",@"keyid":indexString,@"client_id":@"1",@"ordertype":@"desc",@"keytype":@"2",@"page":@"0",@"orderby":@"7"};
                [self loadRequest:dic];
            }
                break;
            default:
                break;
        }
    }
    
}

#pragma mark 调用网络请求
- (void)loadRequest:(NSDictionary *)dic{

    [self.datalist removeAllObjects];
    NSMutableDictionary *nsDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/v203/blog_list" target:self selector:@selector(classData:) parameter:nsDic];


}
#pragma mark 网赚分类
- (void)moneyCategory:(NSDictionary *)dic{

    
    [self.datalist removeAllObjects];
    NSMutableDictionary *nsDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/v203/public_type_list" target:self selector:@selector(classData:) parameter:nsDic];
}
#pragma mark 信用卡分类
- (void)bankCategory:(NSDictionary *)dic{

    [self.datalist removeAllObjects];
    NSMutableDictionary *nsDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/v203/public_type_list" target:self selector:@selector(classData:) parameter:nsDic];
}
#pragma mark 分类
- (void)classData:(NSDictionary *)dic{

    NSDictionary *infro = [dic objectForKey:@"infor"];
    NSArray *listItems = [infro objectForKey:@"listItems"];
    
    for (NSDictionary *dics in listItems) {
        
      
        HYMCommModel *model = [[HYMCommModel alloc] initWithDictionary:dics];
        [self.datalist addObject:model];

        self.tableView.datalist = self.datalist;
        [self.tableView reloadData];
    }
    
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.segmentView addSubview:self.lineView];
    [self.navigationController.navigationBar addSubview:self.segmentView];
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    [self.segmentView removeFromSuperview];
}

#pragma mark 消息
- (void)messAct:(UIButton *)btn{

    HYMComMsgVC *msgVC = [[HYMComMsgVC alloc] init];
    [self.navigationController pushViewController:msgVC animated:YES];
}

#pragma mark 搜索
- (void)serachAct:(UIButton *)btn{

    HYMSearchTableVC  *searchVC = [[HYMSearchTableVC  alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES ];
}

#pragma mark 分类
- (void)photoAct{


}
@end
