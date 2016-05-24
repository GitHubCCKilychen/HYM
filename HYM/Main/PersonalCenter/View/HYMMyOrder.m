//
//  HYMMyOrder.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/17.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMMyOrder.h"
#import "HYMSearchView.h"
@interface HYMMyOrder ()

@property (nonatomic,strong)HYMSearchView *searchView;
@end

@implementation HYMMyOrder

- (HYMSearchView *)searchView{

    if (_searchView == nil) {
        
        _searchView = [[HYMSearchView alloc] initWithFrame:CGRectMake(0, 64, kScreenWitdth, 50)];
    }
    return _searchView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initDefault];
    [self initView];
    
}

- (void)initDefault{

    self.title = @"我的订单";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initView{

    [self.view addSubview:self.searchView];
}
@end
