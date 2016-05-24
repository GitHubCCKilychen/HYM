//
//  HYMConView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/21.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMConView.h"
#import "HYMInTable.h"
#import "ScrollView.h"
@interface HYMConView ()

@property (nonatomic,strong)HYMInTable *tableView;
@property (nonatomic,strong)ScrollView *scrollView;
@end
@implementation HYMConView


- (ScrollView *)scrollView{

    if (_scrollView == nil) {
        
        _scrollView = [[ScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth, 70)];
    }
    return _scrollView;
}
- (HYMInTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMInTable alloc] initWithFrame:CGRectMake(0, 64, kScreenWitdth, kScreenHeight-64) style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = self.scrollView;
    }
    return _tableView;
}


- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame: frame]) {
        
        [self initView];
    }
    return self;
}

- (void)initView{


    [self addSubview:self.tableView];
    
}
@end
