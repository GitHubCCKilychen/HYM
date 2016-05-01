//
//  HYMMyBooksVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/27.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMMyBooksVC.h"
#import "HYMMyBooksTableView.h"
@interface HYMMyBooksVC ()

@property (nonatomic,strong)HYMMyBooksTableView *tableView;
@end

@implementation HYMMyBooksVC

#pragma mark 懒加载
-(HYMMyBooksTableView *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMMyBooksTableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initWithDefaults];
    
    [self initWithView];
}

#pragma mark 默认配置
- (void)initWithDefaults{

    self.title = @"投资记录";
    self.view.backgroundColor = [UIColor whiteColor];
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
}

#pragma mark initview
- (void)initWithView{

    [self.view addSubview:self.tableView];
}
@end
