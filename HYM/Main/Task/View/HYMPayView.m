//
//  HYMPayView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/3.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPayView.h"

@interface HYMPayView ()

@property (nonatomic,strong)UIImageView *warningImage;
@property (nonatomic,strong)UILabel *warnTitle;
@end

@implementation HYMPayView

-(UIImageView *)warningImage{
    if (_warningImage == nil) {
        
        _warningImage = [[UIImageView  alloc] init];
        _warningImage.backgroundColor = [UIColor orangeColor];
    }
    return _warningImage;
}

-(UILabel *)warnTitle{

    if (_warnTitle == nil) {
        
        _warnTitle = [[UILabel alloc] init];
        _warnTitle.text = @"预付金额提示";
        [HYMTool initLabel:_warnTitle withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _warnTitle;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self initWithView];
        
    }
    return self;
}

#pragma mark view
- (void)initWithView{

    [self addSubview:self.warningImage];
    [self addSubview:self.warnTitle];
    
    self.warningImage.sd_layout
    .leftSpaceToView(self,10).topSpaceToView(self,5)
    .widthEqualToHeight(20).bottomSpaceToView(self,5);
    
    self.warnTitle.sd_layout
    .leftSpaceToView(self.warningImage,10).topEqualToView(self.warningImage)
    .bottomSpaceToView(self,5).widthRatioToView(self,0.5);
}
@end
