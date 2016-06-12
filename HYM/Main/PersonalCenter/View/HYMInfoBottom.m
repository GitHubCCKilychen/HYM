//
//  HYMInfoBottom.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/14.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMInfoBottom.h"
#import "HYMInforModel.h"
@interface HYMInfoBottom ()<UITextFieldDelegate>

@end
@implementation HYMInfoBottom

- (NSArray *)titleArr{
    
    if (_titleArr == nil) {
        
        _titleArr = [NSArray array];
        _titleArr = @[@"真实姓名*",@"身份证号*",@"支付宝账号",@"常用邮箱*",@"常用QQ*",@"紧急电话*"];
    }
    return _titleArr;
}

- (NSArray *)textFiledArr{
    
    if (_textFiledArr == nil) {
        
        _textFiledArr = [NSArray array];
        _textFiledArr = @[@"请输入您的真实姓名",@"请输入您的身份证号",@"请输入您的支付宝密码",@"请输入您的常用邮箱",@"请输入您的常用QQ",@"请输入您的紧急电话"];
    }
    return _textFiledArr;
}

#pragma mark model

- (void)setModel:(HYMInforModel *)model{

    _model = model;
    
    NSArray *titleArr = @[_model.true_name,_model.id_card,_model.alipay,_model.email,_model.qq,_model.qq];
    [self initView:titleArr];
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
    
    }
    return self;
}

- (void)initView:(NSArray *)titleArr{
    
    for (int i = 0; i < self.titleArr.count; i++) {
        
        UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(15, 8 +i*38+i*5, kScreenWitdth-30, 30);
//        lineView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        lineView.layer.borderWidth = 0.5;
//        lineView.layer.cornerRadius = 3;
        lineView.userInteractionEnabled = YES;
        [self addSubview:lineView];
        
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(0, 5, 72, 20);
        title.text = self.titleArr[i];
        title.font = [UIFont systemFontOfSize:13];
        title.textAlignment = NSTextAlignmentCenter;
        [lineView addSubview:title];
        
        UILabel *textF = [[UILabel alloc] init];
        textF.frame = CGRectMake(80, 5, lineView.frame.size.width-75, 20);
        textF.font = [UIFont systemFontOfSize:13];
        textF.tag = i;
        textF.text = titleArr[i];
        [lineView addSubview:textF];
        
    }
}

@end
