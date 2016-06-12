//
//  HYMMallView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/24.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMMallView.h"
#import "PostPublishNewVC.h"
#import "CategoryVC.h"
@implementation HYMMallView

- (void)setModel:(HYMCenMallModel *)model{

    _model = model;

    [self.leftBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:_model.imgurl0] forState:UIControlStateNormal];

     [self.topBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:_model.imgurl0] forState:UIControlStateNormal];
    
     [self.centerBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:_model.imgurl0] forState:UIControlStateNormal];
    
     [self.rightBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:_model.imgurl0] forState:UIControlStateNormal];
}

- (void)setDatalist:(NSMutableArray *)datalist{

    _datalist = datalist;
    
}
- (UIButton *)leftBtn{
    
    if (_leftBtn == nil) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.imageView.contentMode = UIViewContentModeScaleToFill;
        [_leftBtn addTarget:self action:@selector(leftAct:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _leftBtn;
}

- (UIButton *)topBtn{
    
    if (_topBtn == nil) {
        
        _topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _topBtn.backgroundColor =[UIColor brownColor];
         _topBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_topBtn addTarget:self action:@selector(topAct:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _topBtn;
    
}

-(UIButton *)rightBtn{
    
    if (_rightBtn == nil) {
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.backgroundColor = [UIColor brownColor];
        _rightBtn.imageView.contentMode = UIViewContentModeScaleToFill;
        [_rightBtn addTarget:self action:@selector(rightAct:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
- (UIButton *)centerBtn{
    
    if (_centerBtn == nil) {
        
        _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerBtn.backgroundColor = [UIColor greenColor];
        _centerBtn.imageView.contentMode = UIViewContentModeScaleToFill;
        [_centerBtn addTarget:self action:@selector(centerAct:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _centerBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self initView];
    }
    return self;
}
- (void)initView{

    [self addSubview:self.leftBtn];
    [self addSubview:self.topBtn];
    [self addSubview:self.centerBtn];
    [self addSubview:self.rightBtn];
    
    self.leftBtn.sd_layout
    .leftSpaceToView(self,10)
    .topSpaceToView(self,15)
    .bottomSpaceToView(self,15)
    .widthRatioToView(self,0.4)
    .heightRatioToView(self,0.8);
    
    self.topBtn.sd_layout
    .topEqualToView(self.leftBtn)
    .rightSpaceToView(self,10)
    .leftSpaceToView(self.leftBtn,1)
    .heightIs(59);
    
    self.centerBtn.sd_layout
    .leftEqualToView(self.topBtn)
    .bottomEqualToView(self.leftBtn)
    .topSpaceToView(self.topBtn,1)
    .heightIs(59)
    .widthRatioToView(self.topBtn,0.5);
    
    self.rightBtn.sd_layout
    .topEqualToView(self.centerBtn)
    .leftSpaceToView(self.centerBtn,1)
    .bottomEqualToView(self.centerBtn)
    .rightEqualToView(self.topBtn);
    
}
#pragma mark 
- (void)topAct:(UIButton *)btn{

    
    CategoryVC *cateVC = [[CategoryVC alloc] init];
    [self.viewController.navigationController pushViewController:cateVC animated:YES];

}

#pragma mark 
- (void)leftAct:(UIButton *) btn{

    CategoryVC *cateVC = [[CategoryVC alloc] init];
    [self.viewController.navigationController pushViewController:cateVC animated:YES];
}

#pragma mark center
- (void)centerAct:(UIButton *)btn{

    
    CategoryVC *cateVC = [[CategoryVC alloc] init];
    [self.viewController.navigationController pushViewController:cateVC animated:YES];
    
}

- (void)rightAct:(UIButton *)btn{
    
    CategoryVC *cateVC = [[CategoryVC alloc] init];
    [self.viewController.navigationController pushViewController:cateVC animated:YES];

}
@end
