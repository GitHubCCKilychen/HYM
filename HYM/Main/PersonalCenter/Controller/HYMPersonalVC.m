//
//  HYMPersonalVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPersonalVC.h"
#import "HYMPersonTable.h"
#import "HYMPersonHeader.h"
@interface HYMPersonalVC ()

@property (nonatomic,strong)HYMPersonTable *tableView;
@property (nonatomic,strong)HYMPersonHeader *header;
@end

@implementation HYMPersonalVC


-(HYMPersonHeader *)header{

    if (_header == nil) {
        
        _header = [[HYMPersonHeader alloc] init];
        _header.frame = CGRectMake(0, 0, kScreenWitdth, 150);
    }
    return _header;
}

- (HYMPersonTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMPersonTable alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = self.header;
    
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDefault];
    [self initWithView];
}

- (void)initDefault{

    self.title = @"个人中心";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    
}

- (void)initWithView{

    [self.view addSubview:self.tableView];
    
    
    

    
}


@end
