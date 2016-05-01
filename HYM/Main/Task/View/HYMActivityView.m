//
//  HYMActivityVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/28.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMActivityView.h"
#import "HYMFormVC.h"
@implementation HYMActivityView

#pragma mark 懒加载
-(UIView *)lineView{

    if (_lineView == nil) {
        
        _lineView = [[UIView alloc] init];
        _lineView.layer.cornerRadius = 4;
        
    }
    return _lineView;
}

-(UILabel *)activity{

    if (_activity == nil) {
        
        _activity = [[UILabel alloc] init];
        _activity.text= @"活动简介";
        [HYMTool initLabel:_activity withFont:[UIFont boldSystemFontOfSize:15] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
        [_activityContent sizeToFit];
    }
    return _activity;
}

- (UILabel *)activityContent{

    if (_activityContent == nil) {
        
        _activityContent = [[UILabel alloc] init];
        _activityContent.numberOfLines = 0;
        _activityContent.text = @"通过活动链接注册完成认证及投资，投资100元（充值90元，勾选10元红包）新手15天收益10元";
        [HYMTool initLabel:_activityContent withFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _activityContent;
}

- (UIView *)grayLine{

    if (_grayLine == nil) {
        
        _grayLine = [[UIView alloc] init];
        _grayLine.alpha = 0.2;
        
    }
    return _grayLine;
}

- (UIView *)verticalLine{

    if (_verticalLine == nil) {
        _verticalLine = [[UIView alloc] init];
        _verticalLine.layer.cornerRadius = 4;
    }
    return _verticalLine;
}

-(UILabel *)activityCourse{

    if (_activityCourse == nil) {
        
        _activityCourse = [[UILabel alloc] init];
        _activityCourse.text = @"活动教程";
        [HYMTool initLabel:_activityCourse withFont:[UIFont boldSystemFontOfSize:15] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _activityCourse;
}
- (UILabel *)courseContent{

    if (_courseContent == nil) {
        
        _courseContent = [[UILabel alloc] init];
        _courseContent.text = @"通过活动链接注册完成认证及投资，投资100元（充值90元，勾选10元红包）新手15天收益10元";
        [HYMTool initLabel:_courseContent withFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
        _courseContent.numberOfLines = 0;
        [_courseContent sizeToFit];
    }
    return _courseContent;
}

-(UIView *)gray2Line{

    if (_gray2Line == nil) {
        
        _gray2Line = [[UIView alloc] init];
        _gray2Line.alpha = 0.2;
    }
    return _gray2Line;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
      
        [self initWithView];
        [self initWithBtn];
    }
    
    return self;
}

#pragma mark 
- (void)initWithView{

    [self addSubview:self.lineView];
    [self addSubview:self.activity];
    [self addSubview:self.activityContent];
    [self addSubview:self.grayLine];
    [self addSubview:self.verticalLine];
    [self addSubview:self.activityCourse];
    [self addSubview:self.courseContent];
    [self addSubview:self.gray2Line];
    
    
    //左侧15上册10
    self.lineView.backgroundColor = [UIColor orangeColor];
    self.lineView.sd_layout
    .leftSpaceToView(self,15).topSpaceToView(self,10)
    .widthIs(8).heightIs(20);
    
    self.activity.sd_layout
    .topEqualToView(self.lineView).leftSpaceToView(self.lineView,10)
    .widthIs(80).heightIs(20);
    
//    self.activityContent.backgroundColor = [UIColor brownColor];
    self.activityContent.sd_layout
    .leftSpaceToView(self,15).rightSpaceToView(self,10)
    .topSpaceToView(self.activity,15).heightIs(40);
    
    self.grayLine.backgroundColor = [UIColor grayColor];
    self.grayLine.sd_layout
    .leftEqualToView(self.activityContent).rightEqualToView(self.activityContent)
    .topSpaceToView(self.activityContent,20).heightIs(1);
    
    self.verticalLine.backgroundColor = [UIColor orangeColor];
    self.verticalLine.sd_layout
    .leftSpaceToView(self,15).topSpaceToView(self.grayLine,20)
    .heightIs(20).widthIs(8);
    
    
    self.activityCourse.sd_layout
    .leftEqualToView(self.activity).topSpaceToView(self.grayLine,20)
    .widthIs(80).heightIs(20);
//
//    self.courseContent.backgroundColor = [UIColor grayColor];
    self.courseContent.sd_layout
    .leftSpaceToView(self,15).topSpaceToView(self.activityCourse,15)
    .rightSpaceToView(self,15).heightIs(40);
    
    self.gray2Line.backgroundColor = [UIColor grayColor];
    self.gray2Line.sd_layout
    .leftSpaceToView(self,15).rightSpaceToView(self,15)
    .topSpaceToView(self.courseContent,20).heightIs(1);
    
}

- (void)initWithBtn{

    CGFloat btnX = ((kScreenWitdth-60)/2);
    CGFloat btnWidth = (kScreenWitdth-60)/2;
    
    NSArray *title = @[@"马上参与",@"马上报单"];
    
    for (int i = 0; i < 2; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20+20*i+i*btnX, 250, btnWidth, 40);
        btn.backgroundColor = [UIColor orangeColor];
        [btn setTitle:title[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.tag = i;
        btn.layer.cornerRadius = 5;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(joinForm:) forControlEvents:UIControlEventTouchUpInside];
        [self  addSubview:btn];
    }
}

#pragma mark 马上报单
- (void)joinForm:(UIButton *)btn{

    if (btn.tag == 0) {
        
        NSLog(@"3242");
        
    }else if (btn.tag == 1){
    
        HYMFormVC *formVC = [[HYMFormVC alloc] init];
        formVC.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:formVC animated:YES];
    }
}
@end
