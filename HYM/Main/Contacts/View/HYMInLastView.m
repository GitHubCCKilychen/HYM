//
//  HYMInLastView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/6.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMInLastView.h"

@implementation HYMInLastView

-(UILabel *)title{

    if (_title == nil) {
        
        _title = [[UILabel alloc] init];
        
        _title.text = @"邀请返利";
        [HYMTool initLabel:_title withFont:[UIFont systemFontOfSize:16] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _title;
}

- (UILabel *)returnMoney{

    if (_returnMoney == nil) {
        
        _returnMoney = [[UILabel alloc] init];
        
        _returnMoney.text = @"累计邀请返利:";
        [HYMTool initLabel:_returnMoney withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _returnMoney;
}

- (UILabel *)money{

    if (_money ==nil) {
        
        _money = [[UILabel alloc] init];
        _money.text = @"2342";
        [HYMTool initLabel:_money withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _money;
}

- (UIButton *)makeMoney{

    if (_makeMoney == nil) {
        
        _makeMoney = [UIButton buttonWithType:UIButtonTypeCustom];
        [_makeMoney setTitle:@"点击此处,邀请赚钱" forState:UIControlStateNormal];
        [_makeMoney setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _makeMoney.backgroundColor = [UIColor orangeColor];
        _makeMoney.layer.cornerRadius = 3;
        _makeMoney.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _makeMoney;
}

- (UIView *)invitationView{

    if (_invitationView  == nil) {
        
        _invitationView = [[UIView alloc] init];
        _invitationView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _invitationView.layer.borderWidth = 0.5;
        _invitationView.layer.cornerRadius = 3;
        
    }
    return _invitationView;
}
-(UILabel *)continueInvite{

    if (_continueInvite == nil) {
        
        _continueInvite = [[UILabel alloc] init];
        _continueInvite.text = @"继续邀请";
        [HYMTool initLabel:_continueInvite withFont:[UIFont systemFontOfSize:17] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _continueInvite;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self initWithView];
        [self initWithBtn];
    }
    return self;
}

- (void)initWithView{

    [self addSubview:self.title];
    [self addSubview:self.returnMoney];
    [self addSubview:self.money];
    [self addSubview:self.makeMoney];
    [self addSubview:self.invitationView];
    [self addSubview:self.continueInvite];
    
    self.title.sd_layout
    .leftSpaceToView(self,15).topSpaceToView(self,10)
    .heightIs(20).widthRatioToView(self,0.3);
    
//    self.returnMoney.backgroundColor = [UIColor grayColor];
    self.returnMoney.sd_layout
    .leftSpaceToView(self,15).topSpaceToView(self.title,10)
    .heightIs(20).widthRatioToView(self,0.3);
    
//    self.money.backgroundColor = [UIColor grayColor];
    self.money.sd_layout
    .leftSpaceToView(self.returnMoney,5).topEqualToView(self.returnMoney)
    .heightIs(20).widthRatioToView(self,0.2);
    
    
    self.invitationView.sd_layout
    .leftSpaceToView(self,15).rightSpaceToView(self,15)
    .bottomSpaceToView(self.makeMoney,10).heightIs(100);
    
    self.makeMoney.sd_layout
    .leftSpaceToView(self,15).rightSpaceToView(self,15)
    .bottomSpaceToView(self,10).heightIs(35);
    
    self.continueInvite.sd_layout
    .leftSpaceToView(self,15).heightIs(20)
    .bottomSpaceToView(self.invitationView,5).widthIs(100);
    
}

- (void)initWithBtn{

    UIView *centerView = [[UIView alloc] init];
    centerView.frame = CGRectMake(15, 70, kScreenWitdth-30, 50);
    centerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    centerView.layer.borderWidth = 0.5;
    centerView.layer.cornerRadius = 5;
    [self addSubview:centerView];
    
    
    for (int i = 0; i<2; i++) {
        
        UIView *redView = [[UIView alloc] init];
        redView.frame = CGRectMake(15, 6+i*15+i*9, 15, 15);
        redView.backgroundColor = [UIColor redColor];
        [centerView addSubview:redView];
    }
    
    NSArray *label1Arr = @[@"1级粉丝:210人",@"2级粉丝:2090人"];
    NSArray *label2Arr = @[@"提成:8%",@"提成:20%"];
    NSArray *label3Arr = @[@"收益:343",@"收益:998.0"];
    for (int i = 0; i<2; i++) {
        
      
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(35, 6+i*15+i*9, kScreenWitdth/4, 15);
        label.text = label1Arr[i];
        [HYMTool initLabel:label withFont:[UIFont systemFontOfSize:10] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
        [centerView addSubview:label];
        
        UILabel *label2 = [[UILabel alloc] init];
        label2.frame = CGRectMake(45+kScreenWitdth/4, 6+i*15+i*9, kScreenWitdth/4, 15);
        label2.text = label2Arr[i];
         [HYMTool initLabel:label2 withFont:[UIFont systemFontOfSize:10] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
        [centerView addSubview:label2];
        
        UILabel *label3 = [[UILabel alloc] init];
        label3.frame = CGRectMake(50+kScreenWitdth/4*2, 6+i*15+i*9, kScreenWitdth/4, 15);
        label3.text = label3Arr[i];
         [HYMTool initLabel:label3 withFont:[UIFont systemFontOfSize:10] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
        [centerView addSubview:label3];
        
    }
    
    
    NSArray *titleArr = @[@"邀请码",@"邀请链接",@"邀请二维码"];
    NSArray *linkArr = @[@"123424",@"www.baidu.com",@"2343455"];
    NSArray *btnTitle = @[@"复制",@"复制",@"生成"];
    for (int i = 0; i < 3;i++) {
        
        UIView *redView = [[UIView alloc] init];
        redView.frame = CGRectMake(15, 10+i*15+i*18, 15, 15);
        redView.backgroundColor = [UIColor redColor];
        [self.invitationView addSubview:redView];
        
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(35, 10+i*15+i*18, 60, 15);
        title.text = titleArr[i];
        [HYMTool initLabel:title withFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
        [self.invitationView addSubview:title];
        
        UILabel *link = [[UILabel alloc] init];
        link.frame = CGRectMake(100, 10+i*15+i*18, kScreenWitdth/2.2, 15);
//        link.backgroundColor = [UIColor brownColor];
        link.text = linkArr[i];
        [self.invitationView addSubview:link];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(105+kScreenWitdth/2.1, 10+i*15+i*18, 30, 15);
//        btn.backgroundColor = [UIColor blueColor];
        [btn setTitle:btnTitle[i] forState:UIControlStateNormal];
        btn.layer.borderColor = [UIColor blueColor].CGColor;
        btn.layer.borderWidth = 0.5;
        btn.titleLabel.font = [UIFont systemFontOfSize:11];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.invitationView addSubview:btn];
    }
}
@end
