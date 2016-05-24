//
//  HYMSearchView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/17.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMSearchView.h"

@interface HYMSearchView ()<UITextFieldDelegate>

@end
@implementation HYMSearchView

- (UITextField *)textField{

    if (_textField == nil) {
        
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"请输入搜索关键字";
        _textField.font = [UIFont systemFontOfSize:14 ];
        [_textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventValueChanged];
       _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _textField;
}

- (UIButton *)searchBtn{

    if (_searchBtn == nil) {
        
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.backgroundColor = [UIColor orangeColor];
        [_searchBtn addTarget:self action:@selector(searchAct:) forControlEvents:UIControlEventTouchUpInside];
        [_searchBtn setTitle:@"搜订单" forState:UIControlStateNormal];
        [_searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _searchBtn.layer.cornerRadius = 3;
        [_textField setReturnKeyType:UIReturnKeySearch];
        _textField.delegate = self;
    }
    return _searchBtn;
}

- (UIImageView *)bottomImage{

    if (_bottomImage == nil) {
        
        _bottomImage = [[UIImageView alloc] init];
//        _bottomImage.backgroundColor = [UIColor grayColor];
        _bottomImage.image = [UIImage imageNamed:@"line"];
    }
    return _bottomImage;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame: frame]) {
        
//        self.backgroundColor = [UIColor grayColor];
        [self initView];
    }
    return self;
}

- (void)initView{

    [self addSubview:self.textField];
    [self addSubview:self.searchBtn];
    [self addSubview:self.bottomImage];
    
    self.textField.sd_layout
    .leftSpaceToView(self,15).topSpaceToView(self,15).heightIs(25)
    .widthIs(kScreenWitdth-15-80);
    
    self.searchBtn.sd_layout
    .leftSpaceToView(self.textField,15).rightSpaceToView(self,15)
    .heightIs(25).topSpaceToView(self,15);
    
    
    self.bottomImage.sd_layout
    .leftSpaceToView(self,14).topSpaceToView(self.textField,-2)
    .heightIs(5).widthIs(kScreenWitdth-15-80);
    
}
#pragma mark 搜索
- (void)searchAct:(UIButton *)btn{

    
}
#pragma mark  搜索
- (void)textChange:(UITextField *)text{

}
- (BOOL)textFieldShouldReturn:(UITextField*)theTextField {
    [theTextField resignFirstResponder];
    NSLog(@"%@",theTextField.text);
    return YES;
}

- (void) textFieldDidChange:(UITextField*) TextField{
    NSLog(@"textFieldDidChange textFieldDidChange");
    if(![TextField.text isEqualToString:@""]) {
//        delButton.hidden=NO;  // 仿制searchbar后面的小叉叉
    } else{
//        delButton.hidden=YES;
    }
}  

@end
