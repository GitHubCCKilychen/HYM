//
//  HYMDetailsBottom.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/5.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMDetailsBottom.h"

@interface HYMDetailsBottom ()


@end

@implementation HYMDetailsBottom

- (UIButton *)sureBtn{

    if (_sureBtn == nil) {
        
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.backgroundColor = [UIColor orangeColor];
        _sureBtn.layer.cornerRadius = 5;
        [_sureBtn setTitle:@"确认上传" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _sureBtn;
}

- (UIButton *)draft{

    if (_draft == nil) {
        
        _draft = [UIButton buttonWithType:UIButtonTypeCustom];
        _draft.backgroundColor = [UIColor lightGrayColor];
        [_draft setTitle:@"存至草稿" forState:UIControlStateNormal];
        [_draft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _draft.layer.cornerRadius = 5;
        _draft.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _draft;
}
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
//        self.backgroundColor = [UIColor lightGrayColor];
        
        [self initWithView];
    }
    return self;
}

- (void)initWithView{

    [self addSubview:self.sureBtn];
    [self addSubview:self.draft];
    
    
    self.sureBtn.sd_layout
    .leftSpaceToView(self,15).topSpaceToView(self,20)
    .widthRatioToView(self,0.6).bottomSpaceToView(self,60);
    
    self.draft.backgroundColor = [UIColor lightGrayColor];
    self.draft.sd_layout
    .leftSpaceToView(self.sureBtn,8).topEqualToView(self.sureBtn)
    .bottomEqualToView(self.sureBtn).widthRatioToView(self,0.3);
    
}
@end
