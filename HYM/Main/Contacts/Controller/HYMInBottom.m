//
//  HYMInBottom.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/26.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMInBottom.h"

@implementation HYMInBottom

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self initView];
    }
    return self;
}

- (void)initView{

    NSArray *titleArr = @[@"为什么要邀请好友",@"如何邀请更多好友"];
    for (int i = 0 ; i < 2; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(15, 15+i*15+i*15, 15, 15);
        imageView.backgroundColor = [UIColor grayColor];
        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15+15+10, 15+i*15+i*15, 120,15 );
        label.text = titleArr[i];
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:13];
        [self addSubview:label];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(150, 15+i*15+i*15, 40, 15);
        [btn setTitle:@"(必读)" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self addSubview:btn];
    }
}

@end
