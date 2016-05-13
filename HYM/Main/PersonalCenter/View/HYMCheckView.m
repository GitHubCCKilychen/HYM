//
//  HYMCheckView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMCheckView.h"

@implementation HYMCheckView


- (UIImageView *)iconImage{

    if (_iconImage == nil) {
        
        _iconImage = [[UIImageView alloc] init];
    }
    return _iconImage;
}

- (UIView *)lineView{

    if (_lineView == nil) {
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor whiteColor];
        _lineView.layer.borderColor = [UIColor colorWithRed:188/255.f green:149/255.f blue:104/255.f alpha:1].CGColor;
        _lineView.layer.borderWidth = 1;
        
    }
    return _lineView;
}

- (UILabel *)title{

    if (_title == nil) {
        
        _title = [[UILabel alloc] init];
        _title.text = @"您有多个报单审核了,点击下方审核!";
        [HYMTool initLabel:_title withFont:[UIFont systemFontOfSize:14] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentCenter];
    }
    return _title;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame] ) {
     
        self.backgroundColor = [UIColor whiteColor];
        
        [self initWithView];
    }
    
    return self;
}

- (void)initWithView{

    [self addSubview:self.iconImage];
    [self addSubview:self.lineView];
    [self.lineView addSubview:self.title];
    
    
    self.iconImage.backgroundColor = [UIColor orangeColor];
    self.iconImage.sd_layout
    .leftSpaceToView(self,15).topSpaceToView(self,5)
    .bottomSpaceToView(self,5).widthIs(50);
    
 
    self.lineView.sd_layout
    .leftSpaceToView(self.iconImage,0).topEqualToView(self.iconImage)
    .bottomEqualToView(self.iconImage).rightSpaceToView(self,15);
    
    self.title.sd_layout
    .leftSpaceToView(self.lineView,5).topSpaceToView(self.lineView,10)
    .bottomSpaceToView(self.lineView,10).rightSpaceToView(self.lineView,5);
    
    
    
}
@end
