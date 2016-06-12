//
//  HYMConView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/21.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMConView.h"
#import "HYMInTable.h"
#import "ComScrollView.h"
#import "HYMInBottom.h"
@interface HYMConView ()

@property (nonatomic,strong)HYMInTable *tableView;
//@property (nonatomic,strong)ComScrollView *scrollView;
@property (nonatomic,strong)HYMInBottom *bottomView;
@end
@implementation HYMConView

- (HYMInBottom *)bottomView{

    if (_bottomView == nil) {
        
        _bottomView = [[HYMInBottom alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth, 65)];
    }
    return _bottomView;
}
//- (ComScrollView *)scrollView{
//
//    if (_scrollView == nil) {
//        
//        _scrollView = [[ComScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth, 70)];
//    }
//    return _scrollView;
//}
- (HYMInTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMInTable alloc] initWithFrame:CGRectMake(0, 64, kScreenWitdth, kScreenHeight-64-50) style:UITableViewStyleGrouped];
//        _tableView.tableHeaderView = self.scrollView;
        _tableView.tableFooterView = self.bottomView;
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

- (void)setDatalist:(NSMutableArray *)datalist{

    _datalist = datalist;
    
    
    self.tableView.datalist = self.datalist;
}

- (void)setScrollList:(NSMutableArray *)scrollList{

    _scrollList = scrollList;
    
//    self.scrollView.scrollList = self.scrollList;
}
@end
