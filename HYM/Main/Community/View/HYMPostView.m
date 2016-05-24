//
//  HYMPostView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/6.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPostView.h"

#import "HYMEditCell.h"
@implementation HYMPostView


- (UIImageView *)textImage{

    if (_textImage == nil) {
        _textImage = [[UIImageView alloc] init];
    }
    return _textImage;
}

- (UIButton *)textBtn{

    if (_textBtn == nil) {
        
        _textBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _textBtn;
}

- (UIView *)lineView{

    if (_lineView == nil) {
        
        _lineView = [[UIView alloc] init];
    }
    return _lineView;
}

- (UIImageView *)photoImage{

    if (_photoImage == nil) {
        
        _photoImage = [[UIImageView alloc] init];
    }
    return _photoImage;
}

- (UIButton *)photoBtn{

    if (_photoBtn == nil) {
        
        _photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _photoBtn;
}
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self initView];
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)initView{

    [self addSubview:self.textImage];
    [self addSubview:self.textBtn];
    [self addSubview:self.lineView];
    [self addSubview:self.photoImage];
    [self addSubview:self.photoBtn];
    
    
    self.textImage.backgroundColor = [UIColor brownColor];
    self.textImage.sd_layout
    .leftSpaceToView(self,15).topSpaceToView(self,10)
    .bottomSpaceToView(self,10).widthIs(25);
    
    [self.textBtn  setTitle:@"文字说明" forState:UIControlStateNormal];
    self.textBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.textBtn addTarget:self action:@selector(textBtn) forControlEvents:UIControlEventTouchUpInside];
    self.textBtn.sd_layout
    .leftSpaceToView(self.textImage,5).topSpaceToView(self,12)
    .heightIs(20).widthIs(55);
    
    self.lineView.backgroundColor = [UIColor grayColor];
    self.lineView.sd_layout
    .leftSpaceToView(self.textBtn,10).topSpaceToView(self,10)
    .heightIs(25).widthIs(1);
    
    self.photoImage.backgroundColor = [UIColor grayColor];
    self.photoImage.sd_layout
    .leftSpaceToView(self.lineView,10).topSpaceToView(self,10)
    .widthIs(25).bottomSpaceToView(self,10);
    
    [self.photoBtn setTitle:@"照片说明" forState:UIControlStateNormal];
    [self.photoBtn setTitleColor:[UIColor whiteColor] forState:
    UIControlStateNormal];
    self.photoBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.photoBtn.sd_layout
    .leftSpaceToView(self.photoImage,5).widthIs(55)
    .heightIs(20).topSpaceToView(self,12);
}

- (void)textAct:(UIButton *)text{

    HYMEditCell *editCell = [[HYMEditCell alloc] init];
    
    editCell.backgroundColor = [UIColor brownColor];
    
}
@end
