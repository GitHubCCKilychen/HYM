//
//  HYMJoinView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/23.
//  right © 2016年 haokewangluo. All rights reserved.
//

#import "HYMJoinView.h"

@implementation HYMJoinView


- (void)setModel:(HYMTaskDetailModel *)model{

    _model = model;
    
    self.link.text = _model.content_link;
    NSLog(@"%@",_model.content_link);
}

- (UIView *)redView{
    
    if (_redView == nil) {
        
        _redView = [[UIView alloc] init];
    }
    return _redView;
}

//参与地址
- (UILabel *)participatingAddress{
    
    if (_participatingAddress == nil) {
        
        
        _participatingAddress = [[UILabel alloc] init];
        _participatingAddress.text = @"参与地址";
        [HYMTool initLabel:_participatingAddress withFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _participatingAddress;
}

- (UIButton *)Btn{
    
    if (_Btn == nil) {
        _Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _Btn.layer.borderColor = [UIColor blackColor].CGColor;
        _Btn.layer.borderWidth = 0.5;
        [_Btn setTitle:@"复制" forState:UIControlStateNormal];
        [_Btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _Btn.titleLabel.font = [UIFont systemFontOfSize:13];
        _Btn.layer.cornerRadius = 5;
        _Btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _Btn;
}

- (UILabel *)link{
    
    if (_link == nil) {
        
        _link = [[UILabel alloc] init];
        _link.text = @"www.baidu.com";
        [HYMTool initLabel:_link withFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor blueColor] withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _link;
}

- (UILabel *)bottomTitle{

    if (_bottomTitle == nil) {
        
        _bottomTitle = [[UILabel alloc] init];
        _bottomTitle.font = [UIFont systemFontOfSize:12];
        _bottomTitle.textColor = [UIColor lightGrayColor];
        _bottomTitle.text = @"请在30分钟内完成任务并报单，否则无法报单和拿到任务返利";
    }
    return _bottomTitle;
}


- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
       
        [self initJojn];
    }
    return self;
}
- (void)initJojn{
    
    [self addSubview:self.redView];
    [self addSubview:self.participatingAddress];
    [self addSubview:self.link];
    [self addSubview:self.Btn];
    [self addSubview:self.bottomTitle];
    
    
    self.redView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"参与地址"]];

    self.redView.sd_layout
    .leftSpaceToView(self,10)
    .widthIs(10).heightIs(10).topSpaceToView(self,10);
    
//    self.participatingAddress.backgroundColor = [UIColor grayColor];
    self.participatingAddress.sd_layout
    .leftSpaceToView(self.redView,5)
    .widthIs(60).heightIs(15).topSpaceToView(self,8);
    
    self.link.sd_layout
    .leftSpaceToView(self.participatingAddress,-3).widthRatioToView(self,0.65).heightIs(20).topSpaceToView(self,5);
    
    self.Btn.sd_layout
    .rightSpaceToView(self,5)
    .heightIs(20).widthIs(40).topSpaceToView(self,8);
    
    self.bottomTitle.sd_layout
    .leftSpaceToView(self.redView,-10).topSpaceToView(self.redView,5)
    .widthRatioToView(self,0.8).heightIs(20);
    
}
@end
