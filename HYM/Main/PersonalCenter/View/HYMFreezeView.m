//
//  HYMFreezeView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/18.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMFreezeView.h"

@implementation HYMFreezeView



- (UIView *)lineView{

    if (_lineView == nil) {
        
        _lineView = [[UIView alloc] init];
//        _lineView.backgroundColor =
        _lineView.layer.borderColor =  [UIColor colorWithRed:215/255.f green:216/255.f blue:217/255.f alpha:1].CGColor;
        _lineView.layer.borderWidth = 1;
        _lineView.layer.cornerRadius = 3;
    }
    return _lineView;
}
- (UILabel *)title{

    if (_title == nil) {
        
        _title = [[UILabel alloc] init];
        _title.textColor = [UIColor lightGrayColor];
        _title.text = @"对银行等金融机构以及各类商家开展的一些优惠活动引发兴趣，从而活的优惠乃至金钱上的回报，也被认为是理财族惯用的手法之一.前两年，通过关注信用卡进“薅羊毛”的案例就屡见不鲜";
        _title.font = [UIFont systemFontOfSize:13];
        _title.numberOfLines = 0;
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
-  (UIImageView *)lineImage{
    
    if (_lineImage == nil) {
        
        _lineImage = [[UIImageView alloc] init];
        _lineImage.backgroundColor = [UIColor orangeColor];
    }
    return _lineImage;
}
- (UILabel *)list{
    
    if (_list == nil) {
        _list = [[UILabel alloc] init];
        _list.textColor = [UIColor orangeColor];
        _list.text = @"明细记录";
        _list.font = [UIFont systemFontOfSize:15];
    }
    return _list;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame: frame]) {
     
        [self initView];
        self.backgroundColor = [UIColor colorWithRed:246/255.f green:247/255.f blue:249/255.f alpha:1]
        ;
    }
    return self;
}

- (void)initView{

    [self addSubview:self.lineView];
    [self.lineView addSubview:self.title];

    self.lineView.sd_layout
    .leftSpaceToView(self,10).rightSpaceToView(self,10)
    .topSpaceToView(self,10).heightIs(90);
    
    self.title.sd_layout
    .leftSpaceToView(self.lineView,10).rightSpaceToView(self.lineView,10)
    .topSpaceToView(self.lineView,10).bottomSpaceToView(self.lineView,10);
//
    [self addSubview:self.backView];
    [self.backView addSubview:self.lineImage];
    [self.backView addSubview:self.list];
    self.backView.sd_layout
    .leftSpaceToView(self,0).rightSpaceToView(self,0)
    .bottomSpaceToView(self,0).heightIs(70);
    
    self.lineImage.sd_layout
    .leftSpaceToView(self.backView,15).topSpaceToView(self.backView,8)
    .heightIs(15).widthIs(1);
    
    
    self.list.sd_layout
    .leftSpaceToView(self.lineImage,5).topSpaceToView(self.backView,5)
    .heightIs(20).widthIs(80);
    
   NSArray *arr = @[@"项目",@"发布时间",@"任务数",@"剩余任务数",@"备付金额"];
    
    CGFloat labelWidth = kScreenWitdth/5;
    for (int i = 0; i <arr.count; i++) {
        
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(0+i*labelWidth+i*1, self.backView.frame.size.height - 40,labelWidth, 20);
        title.text = arr[i];
        title.font = [UIFont systemFontOfSize:13];
        title.textAlignment = NSTextAlignmentCenter;
        [self.backView addSubview:title];
        
        if (i == 3) {
            
            title.frame = CGRectMake(0+i*(labelWidth-2)+i*1, self.backView.frame.size.height - 40,labelWidth+10, 20);
        }else if (i == 4){
        
            title.frame = CGRectMake(0+i*labelWidth+i*1, self.backView.frame.size.height - 40, kScreenWitdth/5, 20);
        }
    }
    
}
@end
