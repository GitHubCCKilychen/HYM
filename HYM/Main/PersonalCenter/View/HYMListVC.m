//
//  HYMListVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMListVC.h"
#import "HYMSegmentView.h"
#import "HYMListTable.h"
@interface HYMListVC ()<HYMSegmentViewDelegate>

@property (nonatomic,strong)HYMSegmentView *segment;
@property (nonatomic,strong)HYMListTable *tableView;
@end

@implementation HYMListVC

- (HYMListTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMListTable alloc] initWithFrame:CGRectMake(0, 104, kScreenWitdth, kScreenHeight-104)];
    }
    return _tableView;
}

- (HYMSegmentView *)segment{

    if (_segment == nil) {
        
        NSArray *titleArr = @[@"进行中",@"暂停中",@"已完成",@"已过期",@"已下架"];
        _segment = [HYMSegmentView segmenFrame:CGRectMake(0, 64, kScreenWitdth, 30) titleDataSource:titleArr backgroundColor:[UIColor whiteColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:13] selectedColor:[UIColor orangeColor] buttonDownColor:[UIColor orangeColor] delegate:self];
    }
    return _segment;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDefault];
    [self initWithView];
}

- (void)initDefault{
    
    self.title = @"推单列表";
    self.view.backgroundColor = BB_Back_Color_Here;

}

- (void)initWithView{

    [self.view addSubview:self.segment];
    [self.view addSubview:self.tableView];
}
-(void)segumentSelectionChange:(NSInteger)selection{
    
    
    self.tableView.selection = selection;
    
    switch (selection) {
        case 0:

            NSLog(@"-0进行中");
            break;
        case 1:
              NSLog(@"-1暂停中");
            break;
        case 2:
              NSLog(@"-2");
            break;
        case 3:
              NSLog(@"-3");
            break;
        case 4:
            NSLog(@"-4");
            break;
        default:
            break;
    }

}
@end
