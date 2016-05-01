//
//  HYMFormVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/29.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMFormVC.h"
#import "HYMFormTableView.h"
@interface HYMFormVC ()

@property (nonatomic,strong)HYMFormTableView *tableView;
@end

@implementation HYMFormVC
-(HYMFormTableView *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMFormTableView alloc]init];
    }
    
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDefault];
    [self initWithView];
}

- (void)initDefault{

    self.title = @"马上报单";
    self.view.backgroundColor = [UIColor clearColor];
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    
}

- (void)initWithView{

    [self.view addSubview:self.tableView];
    
    self.tableView.sd_layout
    .leftSpaceToView(self.view,10).topSpaceToView(self.view,100)
    .rightSpaceToView(self.view,10).heightIs(200);
}



@end
