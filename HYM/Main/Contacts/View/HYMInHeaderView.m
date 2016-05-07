//
//  HYMHeaderView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/6.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMInHeaderView.h"

@implementation HYMInHeaderView


- (UIView *)lineView{

    if (_lineView == nil) {
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor orangeColor];
        _lineView.layer.cornerRadius = 4;
    }
    return _lineView;
}

- (UILabel *)title{

    if (_title == nil) {
        
        _title = [[UILabel alloc] init];
        _title.text = @"每天邀请十个朋友，月入上千元";
        [HYMTool initLabel:_title withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _title;
}

- (UILabel *)content{

    if (_content == nil) {
        
        _content = [[UILabel alloc] init];
        
        _content.text = @"用户完成由赚客制定的任务，此奖励为您的劳动所得，由叶赚客以及合作广告商支付响应报酬.";
        _content.numberOfLines = 0;
         [HYMTool initLabel:_content withFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _content;
}

- (ScrollView *)scrollView{

    if (_scrollView == nil) {
        
        _scrollView = [[ScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWitdth, 70)];
    }
    return _scrollView;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
     
        [self initWithView];
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)initWithView{
    

    [self addSubview:self.scrollView];
    [self addSubview:self.lineView];
    [self addSubview:self.title];
    [self addSubview:self.content];
    
    
    self.lineView.backgroundColor = [UIColor orangeColor];
    
    self.lineView.sd_layout
    .leftSpaceToView(self,15).topSpaceToView(self,140)
    .widthIs(8).heightIs(20);
    
//    self.title.backgroundColor = [UIColor grayColor];
    self.title.sd_layout
    .leftSpaceToView(self.lineView,10).topEqualToView(self.lineView)
    .heightIs(20).widthRatioToView(self,0.7);
    

//    self.content.backgroundColor = [UIColor grayColor];
    self.content.sd_layout
    .leftSpaceToView(self,15).rightSpaceToView(self,15)
    .topSpaceToView(self.lineView,2).bottomSpaceToView(self,5);
    
    
}
@end
