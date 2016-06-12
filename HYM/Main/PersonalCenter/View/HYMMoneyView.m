//
//  HYMMoneyView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/18.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMMoneyView.h"
#import "RechargeVC.h"
#import "TiXianVC.h"
@interface HYMMoneyView ()

@property (nonatomic,strong)NSArray *titleArr;
@property (nonatomic,strong)NSArray *imageArr;
@end
@implementation HYMMoneyView
- (NSArray *)titleArr{

    if (_titleArr == nil) {
        
        _titleArr = [NSArray array];
        _titleArr = @[@"充值",@"提现"];
    }
    return _titleArr;
}

-  (UIImageView *)lineImage{

    if (_lineImage == nil) {
        
        _lineImage = [[UIImageView alloc] init];
        _lineImage.backgroundColor = [UIColor orangeColor];
    }
    return _lineImage;
}
- (UILabel *)title{

    if (_title == nil) {
        _title = [[UILabel alloc] init];
        _title.textColor = [UIColor orangeColor];
        _title.text = @"交易明细";
        _title.font = [UIFont systemFontOfSize:15];
    }
    return _title;
}

- (UIView *)backView{
    
    if (_backView == nil) {
        
        _backView =[[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self initView];
        
        self.backgroundColor = [UIColor colorWithRed:241/256.f green:247/256.f blue:251/256.f alpha:1];

        
        
    }
    return self;
}



- (void)initView{
    
    [self addSubview:self.backView];
    self.backView.sd_layout
    .leftSpaceToView(self,0).rightSpaceToView(self,0)
    .bottomSpaceToView(self,0).heightIs(80);
    
    [self.backView addSubview:self.lineImage];
    [self.backView addSubview:self.title];
    

    self.lineImage.sd_layout
    .leftSpaceToView(self.backView,15).topSpaceToView(self.backView,8)
    .heightIs(15).widthIs(1);
    
    
    self.title.sd_layout
    .leftSpaceToView(self.lineImage,5).topSpaceToView(self.backView,5)
    .heightIs(20).widthIs(80);
    
    
    self.imageArr = @[@"保证金1",@"保证金2"];
    //65*2 +宽 35
    CGFloat imageWidth = 35;
    CGFloat margin = kScreenWitdth- 35*2 -65*2;
    
    CGFloat btnWidth = 75;
    CGFloat btnMargin = kScreenWitdth-(50*2+75*2);
    for (int i = 0; i < 2 ; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(65+i*margin+i*imageWidth, 20, imageWidth, 35);
        imageView.image = [UIImage imageNamed:self.imageArr[i]];
        [self addSubview:imageView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(50+i*btnMargin+i*btnWidth, imageView.frame.size.height+20+10, 75, 22.5);
        [btn setTitle:self.titleArr[i] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor colorWithRed:117/256.f green:159/256.f blue:252/256.f alpha:1];
        [btn addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:btn];
       
    }
    
    
    NSArray *arr = @[@"时间",@"类型",@"金额"];
    CGFloat labelWidth = kScreenWitdth/3;
    for (int i = 0; i < arr.count; i ++) {
        
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(0+i*labelWidth+i*1,self.lineImage.frame.size.height+15,labelWidth, 20);
        title.text = arr[i];
        title.font = [UIFont systemFontOfSize:15];
        title.textAlignment = NSTextAlignmentCenter;
        [self.backView addSubview:title];
        
    }

  
    
}

- (void)btnAct:(UIButton *)btn{

    if (btn.tag == 0) {
        
        //有些地方没有了，后期更改
        RechargeVC *recharege = [[RechargeVC alloc] init];
        [self.viewController.navigationController pushViewController:recharege animated:YES];
    }else{
    
        TiXianVC *tixian = [[TiXianVC alloc] init];
        [self.viewController.navigationController pushViewController:tixian animated:YES];
    }
    
}
@end
