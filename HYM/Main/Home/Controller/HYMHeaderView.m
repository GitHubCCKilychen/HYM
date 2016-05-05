//
//  HYMHeaderView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/4.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMHeaderView.h"

@implementation HYMHeaderView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self initWithBtn];
        
    }
    return self;
}


#pragma mark 按钮
- (void)initWithBtn{
    
    NSArray *titleArr = @[@"网贷资讯",@"银行资讯"];
    
    for (int i = 0; i < 2; i++) {
        
        UIButton *btm = [UIButton buttonWithType:UIButtonTypeCustom];
        btm.frame = CGRectMake(20+120*i, 0, 100, 40);
        [btm setTitle:titleArr[i] forState:UIControlStateNormal];
        [btm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btm.titleLabel.textAlignment = NSTextAlignmentCenter;
        btm.tag = i;
        [btm addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btm];
    }
    
    UIView *lineView = [[UIView alloc] init];
    _lineView = lineView;
    lineView.frame = CGRectMake(20, 43,100, 1.5);
    lineView.backgroundColor =[UIColor redColor];
    [self addSubview:lineView];
    
    
}


- (void)btnAct:(UIButton *)btn{
    

    self.infoTable.index = btn.tag;
    
    
    [UIView animateWithDuration:0.35 animations:^{
        if (btn.tag == 0) {
            
            _lineView.frame = CGRectMake(20, 43, 100, 1.5);
    
            
        }else if (btn.tag == 1){
            
            _lineView.frame = CGRectMake(140, 43, 100, 1.5);
            
        }
        
        
    }];
    
    
}



@end
