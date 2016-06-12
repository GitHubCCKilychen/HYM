//
//  HYMReadyView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/31.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMReadyView.h"

@implementation HYMReadyView



- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self initView];
        
    }
    return self;
}

- (void)initView{

    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(15, 10, 1, 20);
    lineView.backgroundColor = [UIColor orangeColor];
    [self addSubview:lineView];
    
    UILabel *title = [[UILabel alloc] init];
    title.frame = CGRectMake(20, 10, kScreenWitdth-30, 20);
    [HYMTool initLabel:title withFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
    title.tag = 1;
    title.text = @"待发布（上传发布成功的任务）";
    [self addSubview:title];
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, self.frame.size.height-0.5, kScreenWitdth, 0.5);
    view.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:view];
}
@end
