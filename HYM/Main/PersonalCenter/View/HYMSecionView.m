//
//  HYMSecionView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/14.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMSecionView.h"

@interface HYMSecionView ()<UITextFieldDelegate>
@end

@implementation HYMSecionView

- (NSArray *)titleArr{

    if (_titleArr == nil) {
        
        _titleArr = [NSArray array];
        _titleArr = @[@"身份证号码*",@"支付宝*",@"银行卡号*",@"开户银行*",@"常用邮箱*"];
    }
    return _titleArr;
}

- (NSArray *)textFiledArr{

    if (_textFiledArr == nil) {
        
        _textFiledArr = [NSArray array];
        _textFiledArr = @[@"请输入您的身份证号码",@"请输入您的支付宝密码",@"请输入您的银行卡密码",@"请输入您的开户银行",@"请输入您的常用邮箱"];
    }
    return _textFiledArr;
}
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self initView];
    }
    return self;
}

- (void)initView{

    for (int i = 0; i < 5; i++) {
        
        UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(15, 8 +i*38+i*5, kScreenWitdth-30, 30);
        lineView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        lineView.layer.borderWidth = 0.5;
        lineView.layer.cornerRadius = 3;
        [self addSubview:lineView];
        
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(0, 5, 72, 20);
        title.text = self.titleArr[i];
        title.font = [UIFont systemFontOfSize:13];
        title.textAlignment = NSTextAlignmentCenter;
        [lineView addSubview:title];
        
        UITextField *textF = [[UITextField alloc] init];
        textF.frame = CGRectMake(80, 5, lineView.frame.size.width-75, 20);
        textF.placeholder = self.textFiledArr[i];
        textF.font = [UIFont systemFontOfSize:13];
        textF.delegate = self;
        textF.tag = i;
        textF.keyboardType = UIKeyboardTypeNumberPad;
        [lineView addSubview:textF];
        
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    return YES;
}
@end
