//
//  HYMTieziVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/14.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTieziVC.h"
#import "HYMTieziTable.h"
@interface HYMTieziVC ()<HYMTieziTableDelegate>

@property (nonatomic,strong)HYMTieziTable *tableView;
@end

@implementation HYMTieziVC

-(HYMTieziTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMTieziTable alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth, kScreenHeight/1.8)];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDefault];
    [self initView];
}

- (void)initDefault{

    self.title = @"选择帖子分类";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    
}

- (void)initView{

    [self.view addSubview:self.tableView];
}

- (void)getTitle:(NSString *)title{

}
@end
