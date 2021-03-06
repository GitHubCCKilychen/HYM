//
//  HYMFormVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/29.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMFormVC.h"
#import "HYMFormTableView.h"
#import "HYMPublishVC.h"
@interface HYMFormVC ()

@property (nonatomic,strong)HYMFormTableView *tableView;
@property (nonatomic,strong)UIView *headView;//
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UILabel *titleLabel;//说明
@end

@implementation HYMFormVC
-(HYMFormTableView *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMFormTableView alloc]init];
    }
    
    return _tableView;
}
- (UIView *)headView{

    if (_headView == nil)
    {
        _headView = [[UIView alloc] init];
    }
    
    return _headView;
}

-(UIView *)lineView{

    if (_lineView == nil) {
        
        _lineView = [[UIView alloc] init];
        _lineView.layer.cornerRadius = 4;
    }
    return _lineView;
}

-(UILabel *)titleLabel{

    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"请填写报单必填项";
        [HYMTool initLabel:_titleLabel withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initDefault];
    [self initWithView];
}

- (void)setIndex:(int)index{

    _index = index;
}

- (void)initDefault{

    self.title = @"马上报单";
    self.view.backgroundColor = BB_Color_BackGround;
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    
}

- (void)initWithView{

    [self.view addSubview:self.headView];
    [self.headView addSubview:self.lineView];
    [self.headView addSubview:self.titleLabel];
    [self.view addSubview:self.tableView];


//    self.headView.backgroundColor = [UIColor grayColor];
    self.headView.sd_layout
    .leftSpaceToView(self.view,10).rightSpaceToView(self.view,10)
    .topSpaceToView(self.view,70).heightIs(30);
    
    self.lineView.backgroundColor = [UIColor orangeColor];
    self.lineView.sd_layout
    .leftSpaceToView(self.headView,0).topSpaceToView(self.headView,5)
    .bottomSpaceToView(self.headView,5).widthIs(8);
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.lineView,10).bottomEqualToView(self.lineView)
    .topEqualToView(self.lineView).widthRatioToView(self.view,0.5);
    
    self.tableView.sd_layout
    .leftSpaceToView(self.view,10).rightSpaceToView(self.view,10)
    .topSpaceToView(self.headView,10).bottomSpaceToView(self.view,0);

    
}



@end
