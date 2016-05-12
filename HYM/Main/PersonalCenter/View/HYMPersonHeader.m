//
//  HYMPersonHeader.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/9.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPersonHeader.h"

@implementation HYMPersonHeader

- (UIImageView *)iconImage{

    if (_iconImage == nil) {
        
        _iconImage = [[UIImageView alloc] init];
        _iconImage.image = [UIImage imageNamed:@"aaa"];
    }
    return _iconImage;
}

- (UILabel *)userName{

    if (_userName == nil) {
        
        _userName = [[UILabel alloc] init];
        _userName.text = @"Aasders";
        [HYMTool initLabel:_userName withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _userName;
}

- (UIImageView *)sexImage{

    if (_sexImage == nil) {
        
        _sexImage = [[UIImageView alloc] init];
        _sexImage.backgroundColor = [UIColor redColor];
    }
    return _sexImage;
}

- (UILabel *)invitationCode{

    if (_invitationCode == nil) {
        
        _invitationCode = [[UILabel alloc] init];
        _invitationCode.text = @"我的邀请码(ID):12345678";
        [HYMTool initLabel:_invitationCode withFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _invitationCode;
}

- (UIButton *)nextBtn{

    if (_nextBtn == nil) {
        
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _nextBtn;
}

- (UIImageView *)leftImage{

    if (_leftImage == nil) {
        
        _leftImage = [[UIImageView alloc] init];
        _leftImage.backgroundColor = [UIColor colorWithRed:244/256.f green:214/256.f blue:53/256.f alpha:1];
    }
    return _leftImage;
}

- (UIImageView *)rightImage{

    if (_rightImage == nil) {
        _rightImage = [[UIImageView alloc] init];
    }
    return _rightImage;
}

- (UILabel *)money{

    if (_money == nil) {
        
        _money = [[UILabel alloc] init];
        _money.text = @"5263.25";
        [HYMTool initLabel:_money withFont:[UIFont boldSystemFontOfSize:20] withTextColor:[UIColor redColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _money;
}

- (UILabel *)moneyTitle{

    if (_moneyTitle == nil) {
        
        _moneyTitle = [[UILabel alloc] init];
        _moneyTitle.text = @"我的余额";
        [HYMTool initLabel:_moneyTitle withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _moneyTitle;
}

- (UILabel *)frozenGold{

    if (_frozenGold == nil) {
        
        _frozenGold = [[UILabel alloc] init];
        _frozenGold.text = @"其中推单冻结金：330.00元";
        _frozenGold.backgroundColor = [UIColor redColor];
        [HYMTool initLabel:_frozenGold withFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor whiteColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _frozenGold;
}

- (UIButton *)seeDetails{

    if (_seeDetails == nil) {
        
        _seeDetails = [UIButton buttonWithType:UIButtonTypeCustom];
        [_seeDetails setTitle:@"查看\n详情" forState:UIControlStateNormal];
        [_seeDetails setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        _seeDetails.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _seeDetails;
}
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self initWithView];
    }
    return self;
}

- (void)initWithView{

    [self addSubview:self.iconImage];
    [self addSubview:self.userName];
    [self addSubview:self.sexImage];
    [self addSubview:self.invitationCode];
    [self addSubview:self.nextBtn];
    [self addSubview:self.leftImage];
    [self addSubview:self.rightImage];
    [self.leftImage addSubview:self.money];
    [self.leftImage addSubview:self.moneyTitle];
    [self.leftImage addSubview:self.frozenGold];
    [self.leftImage addSubview:self.seeDetails];
    
   
    self.iconImage.sd_layout
    .leftSpaceToView(self,15).topSpaceToView(self,20)
    .heightIs(30).widthIs(30);
    
    self.userName.sd_layout
    .leftSpaceToView(self.iconImage,15).topSpaceToView(self,15)
    .widthIs(kScreenWitdth/4).heightIs(15);
    
    //30*15
    self.sexImage.sd_layout
    .topSpaceToView(self,15).leftSpaceToView(self.userName,8)
    .heightIs(15).widthIs(30);
    
    self.invitationCode.sd_layout
    .leftSpaceToView(self.iconImage,15).topSpaceToView(self.userName,3)
    .heightIs(15).widthRatioToView(self,0.7);
    
    self.nextBtn.backgroundColor = [UIColor grayColor];
    self.nextBtn.sd_layout
    .rightSpaceToView(self,10).topSpaceToView(self,25)
    .heightIs(15).widthIs(15);
    
    
    
    self.leftImage.sd_layout
    .leftSpaceToView(self,15).topSpaceToView(self.iconImage,10)
    .rightSpaceToView(self,15).bottomSpaceToView(self,10);
    
    
    self.money.sd_layout
    .leftSpaceToView(self.leftImage,15).topSpaceToView(self.leftImage,10)
    .widthIs(kScreenWitdth/4).heightIs(32);
    
    self.moneyTitle.sd_layout
    .leftSpaceToView(self.money,10).topSpaceToView(self.leftImage,25)
    .heightIs(15).widthIs(80);
    
    self.frozenGold.sd_layout
    .leftSpaceToView(self.leftImage,15).topSpaceToView(self.money,5)
    .heightIs(20).widthIs(kScreenWitdth/2);
    
    self.seeDetails.sd_layout
    .rightSpaceToView(self.leftImage,25).topSpaceToView(self.leftImage,25)
    
    .bottomSpaceToView(self.leftImage,25).widthIs(50);
    
}
@end
