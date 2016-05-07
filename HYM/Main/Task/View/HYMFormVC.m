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
@property (nonatomic,strong)UIButton *sureBtn;//确定
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
- (UIButton *)sureBtn{

    if (_sureBtn == nil) {
        
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureBtn setBackgroundColor:[UIColor orangeColor]];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _sureBtn.layer.cornerRadius = 5;
        [_sureBtn addTarget:self action:@selector(submitAct:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDefault];
    [self initWithView];
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
    [self.view addSubview:self.sureBtn];

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
    .topSpaceToView(self.headView,10).heightRatioToView(self.view,0.65);
    
    self.sureBtn.sd_layout
    .leftSpaceToView(self.view,10).rightSpaceToView(self.view,10)
    .topSpaceToView(self.tableView,15).heightIs(30);
    
    
}

#pragma mark 提交
- (void)submitAct:(UIButton *)submit{

    //判断必填项是否完整
    
    HYMPublishVC *pulishVC = [[HYMPublishVC alloc] init];
    [self.navigationController pushViewController:pulishVC animated:YES];
}

@end
