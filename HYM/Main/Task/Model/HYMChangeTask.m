//
//  HYMChangeTask.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMChangeTask.h"

@implementation HYMChangeTask

-(UIButton *)changeBtn{

    if (_changeBtn == nil) {
        
        _changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _changeBtn.backgroundColor = BB_BackColor;
        [_changeBtn setTitle:@"再次发布" forState:UIControlStateNormal];
        _changeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _changeBtn.layer.cornerRadius = 5;
        _changeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _changeBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
     
        self.backgroundColor = [UIColor whiteColor];
        [self initWithView];
    }
    return self;
}

- (void)initWithView{

    [self addSubview:self.changeBtn];
    
    self.changeBtn.sd_layout
    .leftSpaceToView(self,15).rightSpaceToView(self,15)
    .bottomSpaceToView(self,10).heightIs(35);
}
@end
