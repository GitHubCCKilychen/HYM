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
#import "HYMSortView.h"
#import "HYMSelectedPost.h"
#import "HYMPostVC.h"
@interface HYMCommunityVC ()<HYMSegmentViewDelegate,HYMSortViewDelegate>

@property (nonatomic,strong)HYMCommView *commView;
@property (nonatomic,strong)HYMSegmentView *segmentView;
@property (nonatomic,strong)HYMCommTable *tableView;
@property (nonatomic,strong)HYMSortView *sortView;
@property (nonatomic,strong)HYMSelectedPost *post;//帖子


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

- (HYMSortView *)sortView{

    if (_sortView == nil) {
        
        NSArray *titleArr = @[@"分类",@"时间",@"阅读量",@"评价量"];
        _sortView = [HYMSortView setFrame:CGRectMake(0, 64, kScreenWitdth, 50) titleDataSource:titleArr backgroudColor:[UIColor whiteColor] titleColor:[UIColor lightGrayColor] titleFont:[UIFont systemFontOfSize:15] selectedColor:[UIColor lightGrayColor] buttonDownColor:[UIColor lightGrayColor] delegate:self];
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
        
        _tableView = [[HYMCommTable alloc] initWithFrame:CGRectMake(0, 164, kScreenWitdth, kScreenHeight-50) style:UITableViewStyleGrouped];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:235/256.f green:235/256.f blue:241/256.f alpha:1];
    //默认配置
    [self initDefault];
    //控件
    [self initWithView];
}

#pragma mark 默认
- (void)initDefault{

    
////    self.title = @"社区";
//    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
//    
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
#pragma mark 代理方法
-(void)segumentSelectionChange:(NSInteger)selection{

    NSLog(@"%ld",(long)selection);
}

#pragma mark 分类 ----
- (void)selectedBtnChange:(NSInteger)selectedBtn{

//    //获取当前窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
//    UIView *keyView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [keyWindow addSubview:keyView];
    
    switch (selectedBtn) {
        case 0:
        {
//            keyView.backgroundColor = [UIColor lightGrayColor];
//            keyView.alpha = 0.2;
         
            keyWindow.backgroundColor = [UIColor lightGrayColor];
        }
            break;
        case 1:{
        
        }
            break;
        case 2:
        {
        
        }
            break;
        case 3:
        {
        
        }
            break;
        default:
            break;
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
