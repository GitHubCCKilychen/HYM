//
//  HYMPostedView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPostedView.h"

@implementation HYMPostedView


- (UIButton *)payBtn{

    if (_payBtn == nil) {
        
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _payBtn.backgroundColor = BB_BackColor;
        [_payBtn setTitle:@"立即充值" forState:UIControlStateNormal];
        _payBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _payBtn.layer.cornerRadius = 5;
        _payBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _payBtn;
}

- (UILabel *)topic{

    if (_topic == nil) {
        
        _topic = [[UILabel alloc] init];
        _topic.text = @"还需充值:";
        [HYMTool initLabel:_topic withFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _topic;
}

- (UILabel *)money{

    if (_money == nil) {
        
        _money = [[UILabel alloc] init];
        _money.text = @"¥230";
        [HYMTool initLabel:_money withFont:[UIFont boldSystemFontOfSize:15] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _money;
}
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self initWithView];
    }
    return self;
}

- (void)initWithView{

    [self addSubview:self.topic];
    [self addSubview:self.money];
    [self addSubview:self.payBtn];
    
    self.topic.sd_layout
    .rightSpaceToView(self,55).topSpaceToView(self,15)
    .bottomSpaceToView(self,60).widthIs(60);
    
    self.money.sd_layout
    .leftSpaceToView(self.topic,2).rightSpaceToView(self,10)
    .topSpaceToView(self,10).bottomSpaceToView(self,55);
    
    self.payBtn.sd_layout
    .leftSpaceToView(self,15).rightSpaceToView(self,15)
    .bottomSpaceToView(self,10).heightIs(35);
    
}
@end
