//
//  HYMPublishVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/3.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPublishVC.h"
#import "HYMPublishTableView.h"
#import "HYMPublishView.h"
#import "HYMPublishBottomView.h"
@interface HYMPublishVC ()

@property (nonatomic,strong)HYMPublishTableView *tableView;
@property (nonatomic,strong)HYMPublishView *publishView;
@property (nonatomic,strong)HYMPublishBottomView *bottomView;
@end

@implementation HYMPublishVC

-(HYMPublishBottomView *)bottomView{

    if (_bottomView ==nil) {
        
        _bottomView = [[HYMPublishBottomView alloc] init];
        _bottomView.frame = CGRectMake(0, 0, kScreenWitdth, 160);
        
    }
    return _bottomView;
}

-(HYMPublishView *)publishView{
    if (_publishView == nil) {
        
        _publishView = [[HYMPublishView alloc] init];
//        _publishView.backgroundColor = [UIColor grayColor];
        _publishView.frame = CGRectMake(0, 0, kScreenWitdth, 140);
    }
    return _publishView;
}

-(HYMPublishTableView *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMPublishTableView alloc] init];
        _tableView.tableHeaderView = self.publishView;
        _tableView.tableFooterView = self.bottomView;
        _tableView.frame = CGRectMake(0, 0, kScreenWitdth, kScreenHeight);
    }
    
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initDefault];
    [self initWithView];
}

#pragma mark 
- (void)initDefault{

    self.title = @"发布任务";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
}

#pragma mark view
- (void)initWithView{

    [self.view addSubview:self.tableView];
                                                   
    
}
@end
