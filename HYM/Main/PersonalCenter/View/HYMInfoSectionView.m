//
//  HYMInfoSectionView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/16.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMInfoSectionView.h"

@interface HYMInfoSectionView ()

@property (nonatomic,strong)UIImageView *iconImage;
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UIView *topicView;
@property (nonatomic,strong)UIImageView *topicImage;
@property (nonatomic,strong)UILabel *topicTitle;

@end
@implementation HYMInfoSectionView

- (UIImageView *)iconImage{

    if (_iconImage == nil) {
        
        _iconImage = [[UIImageView alloc] init];
        _iconImage.image = [UIImage imageNamed:@"提现必填"];
        _iconImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImage;
}

- (UILabel *)title{

    if (_title == nil) {
        
        _title = [[UILabel alloc] init];
        _title.text = @"提现必填信息";
         [HYMTool initLabel:_title withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _title;
}
- (UIView *)topicView{

    if (_topicView == nil) {
        
        _topicView = [[UIView alloc] init];
        _topicView.backgroundColor = [UIColor colorWithRed:250/256.f green:228/256.f  blue:212/256.f alpha:1];
    }
    return _topicView;
}

- (UIImageView *)topicImage{

    if (_topicImage == nil) {
        
        _topicImage = [[UIImageView alloc] init];
        _topicImage.contentMode = UIViewContentModeScaleAspectFit;
        _topicImage.image = [UIImage imageNamed:@"提醒"];
    }
    return _topicImage;
}

- (UILabel *)topicTitle{

    if (_topicTitle == nil) {
        
        _topicTitle = [[UILabel alloc] init];
        _topicTitle.text = @"必须真实有效,否则无法提现到账.不能修改,若有变化请联系客服。";
        [HYMTool initLabel:_topicTitle withFont:[UIFont systemFontOfSize:10] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _topicTitle;
}
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self initView];
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)initView{

    [self addSubview:self.iconImage];
    [self addSubview:self.title];
    [self addSubview:self.topicView];
    [self.topicView addSubview:self.topicImage];
    [self.topicView addSubview:self.topicTitle];
    
    self.iconImage.sd_layout
    .leftSpaceToView(self,15).topSpaceToView(self,13)
    .widthIs(24).heightIs(19);
    
    self.title.sd_layout
    .leftSpaceToView(self.iconImage,10).rightSpaceToView(self,0)
    .topSpaceToView(self,12).heightIs(20);
    
    self.topicView.sd_layout
    .leftSpaceToView(self,0).rightSpaceToView(self,0)
    .topSpaceToView(self.iconImage,15).heightIs(28);
    
    self.topicImage.sd_layout
    .leftSpaceToView(self.topicView,5).topSpaceToView(self.topicView,6.5)
    .widthIs(15).heightIs(15);
    
    
    self.topicTitle.sd_layout
    .leftSpaceToView(self.topicImage,3).topSpaceToView(self.topicView,4)
    .heightIs(20).widthIs(kScreenWitdth-22);
}
@end

