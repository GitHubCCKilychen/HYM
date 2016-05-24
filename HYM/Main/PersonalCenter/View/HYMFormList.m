//
//  HYMFormList.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/17.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMFormList.h"
#import "HYMFormListTable.h"
@interface HYMFormList ()
@property (nonatomic,strong)HYMFormListTable *tableView;
@end

@implementation HYMFormList

- (HYMFormListTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMFormListTable alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initDefault];
    [self initView];
}


- (void)initDefault{

    self.title = @"开通推单中心";
     [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initView{

    [self.view addSubview:self.tableView];
}

@end
