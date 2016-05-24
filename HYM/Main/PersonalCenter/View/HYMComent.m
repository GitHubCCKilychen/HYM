//
//  HYMComentView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/17.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMComent.h"

@implementation HYMComent

- (UIImageView *)storeImage{

    if (_storeImage == nil) {
     
        _storeImage = [[UIImageView alloc] init];
        _storeImage.backgroundColor = [UIColor grayColor];
    }
    return _storeImage;
}

-  (UILabel *)title{

    if (_title == nil) {
        
        _title = [[UILabel alloc] init];
        _title.text = @"您还没有相关的订单";
        _title.font = [UIFont systemFontOfSize:15];
        _title.textAlignment = NSTextAlignmentCenter;
    }
    return _title;
}

- (UILabel *)wantTitle{

    if (_wantTitle == nil) {
        _wantTitle = [[UILabel alloc] init];
        _wantTitle.textAlignment = NSTextAlignmentCenter;
        _wantTitle.text = @"可以看看有哪些想买的";
        _wantTitle.textColor = [UIColor grayColor];
        _wantTitle.font = [UIFont systemFontOfSize:12];
    }
    return _wantTitle;
}

- (UILabel *)connect{

    if (_connect==nil) {
        
        _connect = [[UILabel alloc] init];
        _connect.backgroundColor = [UIColor orangeColor];
        _connect.text = @"可能想买的";
        _connect.font = [UIFont systemFontOfSize:14];
        _connect.layer.cornerRadius = 8;
        _connect.textColor = [UIColor whiteColor];
        
    }
    return _connect;
}
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame: frame]) {
        
        [self initView];
    }
    return self;
}

- (void)initView{

    [self addSubview:self.storeImage];
    [self addSubview:self.title];
    [self addSubview:self.wantTitle];
    [self addSubview:self.connect];
    
    
    //60*65
    self.storeImage.sd_layout
    .leftSpaceToView(self,kScreenWitdth/2-30).rightSpaceToView(self,kScreenWitdth/2-30).topSpaceToView(self,80)
    .widthIs(60).heightIs(65);
    
    self.title.sd_layout
    .leftSpaceToView(self,kScreenWitdth/2-110).rightSpaceToView(self,kScreenWitdth/2-110)
    .topSpaceToView(self.storeImage,35).heightIs(20);

    
    self.wantTitle.sd_layout
    .leftSpaceToView(self,kScreenWitdth/2-90).rightSpaceToView(self,kScreenWitdth/2-90)
    .heightIs(20).topSpaceToView(self.title,8);
    
    self.connect.sd_layout
    .leftSpaceToView(self,kScreenWitdth/2-40).rightSpaceToView(self,kScreenWitdth/2-40).heightIs(25)
    .topSpaceToView(self,kScreenHeight-104-kScreenHeight/3.7-50);
    
    
    for (int i = 0; i < 2; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0+i*(kScreenWitdth/2-1)+i*2,kScreenHeight- 104-kScreenHeight/3.7,kScreenWitdth/2-1, kScreenHeight/3.7);
        imageView.backgroundColor = [UIColor grayColor];
        [self addSubview:imageView];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(0+i*(kScreenWitdth/2-40)+i*80,kScreenHeight-104-kScreenHeight/3.7-40 ,kScreenWitdth/2-40, 1);
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
        

    }
}
@end
