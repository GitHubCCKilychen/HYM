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
@interface HYMMyOrderVC ()<HYMSegmentViewDelegate>

@property (nonatomic,strong)HYMSegmentView *segment;
@property (nonatomic,strong)HYMWholeTable *whole;
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
        
        _whole = [[HYMWholeTable alloc] initWithFrame:CGRectMake(0, 120, kScreenWitdth, kScreenHeight-120) style:UITableViewStyleGrouped];
    }
    return _whole;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDefault];
    [self initView];
}

- (void)initDefault{
    
    self.view.backgroundColor = BB_Back_Color_Here;
    self.title = @"我的订单";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    
    UIButton *search = [UIButton buttonWithType:UIButtonTypeCustom];
    search.frame = CGRectMake(0, 0, 20, 20);
    search.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"taskSearch"]];
    [self.navigationController.navigationBar addSubview:search];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:search];
    self.navigationItem.rightBarButtonItem = right;
    
}
- (void)initView{

    [self.view addSubview:self.segment];
    [self.view addSubview:self.whole];
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


@end
