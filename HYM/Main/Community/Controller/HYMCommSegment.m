//
//  HYMSegmentView.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/27.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMCommSegment.h"

@interface HYMCommSegment ()<HYMCommSegmentDelegate>
{
    CGFloat witdthFloat;
    UIView * buttonDownView;
    NSInteger selectSeugment;
}
@end

@implementation HYMCommSegment

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
      
        self.btnTitleSource = [NSMutableArray array];
        selectSeugment = 0;
        [self initWithView];
    }
    
    return self;
}

#pragma mark initWithView

- (void)initWithView{
}

+ (HYMCommSegment *)segmenFrame:(CGRect)frame titleDataSource:(NSArray *)titleArr backgroundColor:(UIColor *)backgroundColor  titleColor:(UIColor *)titleColor titleFont:(UIFont*)titleFont selectedColor:(UIColor *)selectedColor buttonDownColor:(UIColor *)buttonDownColor delegate:(id)delegate{
    
    HYMCommSegment *segment = [[self alloc] initWithFrame:frame];
    segment.backgroundColor = backgroundColor;
    segment.buttonDownColor = buttonDownColor;
    segment.titleColor = titleColor;
    segment.selectColor = selectedColor;
    segment.segmentDelegate = delegate;
    segment.titleFont = titleFont;
    [segment addSegmentArray:titleArr];
   
    return segment;
}

- (void)addSegmentArray:(NSArray *)segmentArray{

    
    // 1.按钮的个数
    NSInteger seugemtNumber = segmentArray.count;
    
    // 2.按钮的宽度
    witdthFloat = (self.bounds.size.width) / seugemtNumber;
    
    // 3.创建按钮
    for (int i = 0; i < segmentArray.count; i++) {
        
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(i * witdthFloat, 0, witdthFloat, self.bounds.size.height-2)];
        self.btn = btn;
        [btn setTitle:segmentArray[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:self.titleFont];
        [btn setTitleColor:self.titleColor forState:UIControlStateNormal];
        [btn setTitleColor:self.selectColor forState:UIControlStateSelected];
        btn.tag = i + 1;
        [btn addTarget:self action:@selector(changeSegumentAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            buttonDownView =[[UIView alloc]initWithFrame:CGRectMake(i * witdthFloat, self.bounds.size.height - 2, witdthFloat, 2)];
            [buttonDownView setBackgroundColor:self.buttonDownColor];
            [self addSubview:buttonDownView];
            
        }
        
        if (i == 0) {
            
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 10)];
            [btn setImage:[UIImage imageNamed:@"论坛-1"] forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0,50, 0, 10)];
        }else{
        
            
            if (i >1) {
                
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 10)];
                [btn setImage:[UIImage imageNamed:@"论坛-2"] forState:UIControlStateNormal];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(0,50, 0, 10)];
            }else{
            
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 10)];
                [btn setImage:[UIImage imageNamed:@"论坛-2"] forState:UIControlStateNormal];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(0,50, 0, 10)];
            }
           
        }
        
        [self addSubview:btn];
        
        [self.btnTitleSource addObject:btn];
        
        
        
       
    }
    [[self.btnTitleSource firstObject] setSelected:YES];
    
}

- (void)changeSegumentAction:(UIButton *)btn{

    [self selectTheSegument:btn.tag - 1];
    
    NSLog(@"%ld",(long)btn.tag);
    //设置选中
    //1.选中状态
    if (btn.selected == YES) {
        
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 10)];
        [btn setImage:[UIImage imageNamed:@"论坛选中"] forState:UIControlStateSelected];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0,50, 0, 10)];
        
    }else{
    
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 10)];
        [btn setImage:[UIImage imageNamed:@"论坛排序"] forState:UIControlStateSelected];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0,50, 0, 10)];
    }
   
}

- (void)setIndex:(NSInteger)index{

    _index = index;
//    if (self.index != self.btn.tag) {
//        
//        //设置当前的选中状态---此处有问题
//        [self selectTheSegument:self.index+1];
//    }
}
-(void)selectTheSegument:(NSInteger)segument{
    
    if (selectSeugment != segument) {
        
        [self.btnTitleSource[selectSeugment] setSelected:NO];
        [self.btnTitleSource[segument] setSelected:YES];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            [buttonDownView setFrame:CGRectMake(segument * witdthFloat,self.bounds.size.height - 2, witdthFloat, 2)];
        }];
        selectSeugment = segument;
        [self.segmentDelegate segSelectionChange:selectSeugment];

        
    }
    

    
}


@end
