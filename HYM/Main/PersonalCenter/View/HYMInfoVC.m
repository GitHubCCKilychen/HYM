//
//  HYMInfoVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/16.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMInfoVC.h"
#import "HYMInfoTable.h"
#import "HYMInfoView.h"
@interface HYMInfoVC ()

@property (nonatomic,strong)HYMInfoTable *tableView;
@property (nonatomic,strong)HYMInfoView *infoView;

@end

@implementation HYMInfoVC


- (HYMInfoTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMInfoTable alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = self.infoView;
    }
    return _tableView;
}

- (HYMInfoView *)infoView{

    if (_infoView == nil) {
        
        _infoView = [[HYMInfoView alloc] init];
        _infoView.frame =  CGRectMake(0, 0, self.view.frame.size.width, 120);
    }
    return _infoView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initDefault];
    [self initView];
}

- (void)initDefault{

    self.title = @"个人信息";
   [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
}

- (void)initView{

    
    [self.view addSubview:self.tableView];

}




@end
