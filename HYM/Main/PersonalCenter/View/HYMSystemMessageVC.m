//
//  HYMSystemMessageVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/16.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMSystemMessageVC.h"
#import "HYMMsgTable.h"
@interface HYMSystemMessageVC ()

@property (nonatomic,strong)HYMMsgTable *tableView;
@end

@implementation HYMSystemMessageVC


- (HYMMsgTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMMsgTable alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initDefault];
    [self initView];
}

- (void)initDefault{

    self.title = @"消息";
     [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
}

- (void)initView{

    [self.view addSubview:self.tableView];
    
}



@end
