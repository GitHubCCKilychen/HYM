//
//  HYMSelectedVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/19.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMSelectedVC.h"
#import "HYMSeletTable.h"
@interface HYMSelectedVC ()

@property (nonatomic,strong)HYMSeletTable *table;
@end

@implementation HYMSelectedVC



- (HYMSeletTable *)table{

    if (_table == nil) {
        
        _table = [[HYMSeletTable  alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    }
    return _table;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDefault];
    [self initView];
}

- (void)initDefault{

    self.title = @"筛选";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)initView{

    [self.view addSubview:self.table];
    
}




@end
