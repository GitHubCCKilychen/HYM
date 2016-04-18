//
//  ScrollLabel.m
//  文字滚动－
//
//  Created by 刘晓雪 on 16/4/17.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "ScrollLabel.h"
#import "UIView+FrameExtension.h"
#define MMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define MMRandomColor MMColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define BTNWidth self.bounds.size.width
#define BTNHeight self.bounds.size.height
@interface ScrollLabel ()

@property (nonatomic,strong)NSMutableArray *titleM;
@property (nonatomic,assign)int index;
@property (nonatomic,assign)int titleIndex;

@end

@implementation ScrollLabel

- (instancetype)initWithFrame:(CGRect)frame withTitleArr:(NSArray *)titleArr{

    if (self = [super initWithFrame:frame]) {
        
        //添加按钮
        [self initWithBtn:titleArr];
    
        
    }
    
    return self;
}

#pragma mark 按钮
- (void)initWithBtn:(NSArray *)titleArr{


    NSMutableArray *title = [NSMutableArray arrayWithArray:titleArr];
    NSString *str = @"";
    self.titleM = title;
    [self.titleM addObject:str];
    self.index = 1;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, BTNWidth,BTNHeight);
    btn.tag = self.index;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:self.titleM[0] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:btn];
    self.clipsToBounds = YES;
    
    
    //计时器
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAct) userInfo:nil repeats:YES];
    
    
}

#pragma mark 事件
- (void)btnClick:(UIButton *)btn{

    
    if ([self.scrollLabelDelegate respondsToSelector:@selector(btnClick:)]) {
        
        [self.scrollLabelDelegate btnClick:btn];
    }
    
}

#pragma mark 计时器事件
- (void)timerAct{
    UIButton *firstBtn = [self viewWithTag:self.index];
    UIButton *modelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    modelBtn.frame = CGRectMake(0, BTNHeight, BTNWidth, BTNHeight);
    [modelBtn setBackgroundColor:[UIColor whiteColor]];
    [modelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    modelBtn.tag = self.index + 1;
    if ([self.titleM[self.titleIndex+1] isEqualToString:@""]) {
        
        self.titleIndex = -1;
        self.index = 0;
    }
    
    if (modelBtn.tag == self.titleM.count) {
        
        modelBtn.tag = 1;
        
    }
    [modelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [modelBtn setTitle:self.titleM[self.titleIndex +1] forState:UIControlStateNormal];
    [self addSubview:modelBtn];
    
    [UIView animateWithDuration:0.35 animations:^{
        
        firstBtn.y
        = - self.bounds.size.height;
        modelBtn.y = 0;
        
    } completion:^(BOOL finished) {
        
        [firstBtn removeFromSuperview];
    }];
    
    self.index++;
    self.titleIndex++;
}


    

@end
