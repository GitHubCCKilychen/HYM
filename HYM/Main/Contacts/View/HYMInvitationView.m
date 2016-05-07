//
//  HYMInvitationView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/6.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMInvitationView.h"

#import "HYMInHeaderView.h"
#import "HYMInLastView.h"
@interface HYMInvitationView ()
@property (nonatomic,strong)HYMInHeaderView *headerView;
@property (nonatomic,strong)HYMInLastView *lastView;
@end
@implementation HYMInvitationView

-(HYMInHeaderView *)headerView{

    if (_headerView == nil) {
        
        _headerView = [[HYMInHeaderView alloc] init];
        }
    return _headerView;
}

-(HYMInLastView *)lastView{

    if (_lastView == nil) {
        
        _lastView = [[HYMInLastView alloc] init];
    }
    return _lastView;
}



#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
     
        [self initWithView];
    }
    return self;
}

#pragma mark 视图-
- (void)initWithView{


    
    [self addSubview:self.headerView];
    [self addSubview:self.lastView];
    
//    self.headerView.backgroundColor = [UIColor grayColor];
    //此处高度有问题
    self.headerView.sd_layout
    .leftSpaceToView(self,0).rightSpaceToView(self,0)
    .topSpaceToView(self,0).heightIs(204);
    
    self.lastView.backgroundColor = [UIColor whiteColor];
    self.lastView.sd_layout
    .leftSpaceToView(self,0).topSpaceToView(self.headerView,10)
    .rightSpaceToView(self,0).heightIs(310);


    
    
}
@end
