//
//  HYMMyOrderVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/13.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMMyOrderVC.h"
#import "HYMSegmentView.h"
#import "HYMWholeTable.h"
#import "HYMMyOrder.h"
#import "HYMComent.h"
@interface HYMMyOrderVC ()<HYMSegmentViewDelegate>

@property (nonatomic,strong)HYMSegmentView *segment;
@property (nonatomic,strong)HYMWholeTable *whole;
@property (nonatomic,strong)HYMComent *comentView;
@end

@implementation HYMMyOrderVC


- (HYMSegmentView *)segment{

    if (_segment == nil) {
        
        NSArray *titleArr = @[@"全部",@"待付款",@"待发货",@"待收货",@"待评价"];
        _segment = [HYMSegmentView segmenFrame:CGRectMake(0, 64, kScreenWitdth, 40) titleDataSource:titleArr backgroundColor:[UIColor whiteColor] titleColor:[UIColor grayColor] titleFont:[UIFont systemFontOfSize:15] selectedColor:[UIColor orangeColor] buttonDownColor:[UIColor orangeColor] delegate:self];
    }
    return _segment;
}

- (HYMWholeTable *)whole{

    if (_whole == nil) {
        
        _whole = [[HYMWholeTable alloc] initWithFrame:CGRectMake(0, 104, kScreenWitdth, kScreenHeight-104) style:UITableViewStyleGrouped];
    }
    return _whole;
}

- (HYMComent *)comentView{

    if (_comentView == nil) {
        
        _comentView = [[HYMComent alloc] init];
        _comentView.frame = CGRectMake(0, 104, kScreenWitdth, kScreenHeight-104);
    }
    return _comentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDefault];
    [self initView];
}


- (void)initDefault{
    
    self.view.backgroundColor = [UIColor colorWithRed:235/256.f green:235/256.f blue:241/256.f alpha:1];
    self.title = @"我的订单";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    
    UIButton *search = [UIButton buttonWithType:UIButtonTypeCustom];
    search.frame = CGRectMake(0, 0, 20, 20);
    search.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"taskSearch"]];
    [search addTarget:self action:@selector(searchOrder:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:search];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:search];
    self.navigationItem.rightBarButtonItem = right;
    
}
- (void)initView{

    [self.view addSubview:self.segment];
    [self.view addSubview:self.whole];
    //根据是否有数据来进行判断设置添加
//    [self.view addSubview:self.comentView];
}

-(void)segumentSelectionChange:(NSInteger)selection{

    selection = self.index;
    
    //根据点击设置当前的index值
    
}

- (void)setIndex:(NSInteger)index{
    
    _index = index;
    
    self.segment.index = self.index;
    
    NSLog(@"----%ld",(long)self.segment.index);
}

#pragma mark 搜索订单
- (void)searchOrder:(UIButton *)btn{

    HYMMyOrder *search = [[HYMMyOrder alloc] init];
    [self.navigationController pushViewController:search animated:YES];
}
@end
