//
//  HYMSecurityDeposit.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/18.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMSecurityDeposit.h"
#import "HYMMoneyView.h"
#import "HYMMoneyTable.h"

@interface HYMSecurityDeposit ()

@property (nonatomic,strong)HYMMoneyView *moneyView;
@property (nonatomic,strong)HYMMoneyTable *moneyTable;

@end

@implementation HYMSecurityDeposit

- (HYMMoneyView *)moneyView{

    if (_moneyView == nil) {
        
        _moneyView = [[HYMMoneyView alloc] init];
        _moneyView.frame = CGRectMake(0, 64, kScreenWitdth, 180);
    }
    return _moneyView;
}

- (HYMMoneyTable *)moneyTable{

    if (_moneyTable == nil) {
        
        _moneyTable = [[HYMMoneyTable alloc] initWithFrame:CGRectMake(0, 224, kScreenWitdth, kScreenHeight-224) style:UITableViewStyleGrouped];
    }
    return _moneyTable ;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self initDefault];
    [self initView];
}

#pragma mark 数据
- (void)loadData{

    
    //--没有数据
    NSDictionary *dic = @{@"page":@"1",@"token":@"1"};
    
    NSMutableDictionary *nsdic = [NSMutableDictionary dictionaryWithDictionary:dic];

    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/task/deposit_info" target:self selector:@selector(loadData:) parameter:nsdic];
}


#pragma mark 数据解析
- (void)loadData:(NSDictionary *)dic{

//    NSLog(@"%@",dic);
    
}

- (void)initDefault{

    self.title = @"保证金";
     [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *help = [UIButton buttonWithType:UIButtonTypeCustom];
    [help setImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
    help.frame = CGRectMake(0, 0, 30, 30);
    [self.navigationController.navigationBar addSubview:help];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:help];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)initView{

    [self.view addSubview:self.moneyView];
    [self.view addSubview:self.moneyTable];
}
@end
