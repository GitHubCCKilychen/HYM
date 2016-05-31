//
//  HYMSortView.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/28.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMSortView.h"

@interface HYMSortView ()

@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,assign)NSInteger selectBtn;
@end

@implementation HYMSortView

- (UIView *)lineView{

    if (_lineView == nil) {
        
        _lineView = [[UIView alloc] init];
        _lineView.frame = CGRectMake(0, 0, kScreenWitdth, 0.5);
        _lineView.backgroundColor = [UIColor lightGrayColor];
        _lineView.alpha = 0.3;
    }
    
    return _lineView;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.btnTitleSource = [NSMutableArray array];
        self.selectBtn = 0;
        [self initWithView];
    }
    
    return self;
}

#pragma mark  initView
- (void)initWithView{

    [self addSubview:self.lineView];
    
    
   
}

+ (HYMSortView *)setFrame:(CGRect)frame titleDataSource:(NSArray *)titleDataSource backgroudColor:(UIColor *)backgroudColor titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont selectedColor:(UIColor *)selectedColor buttonDownColor:(UIColor*)buttonDownColor delegate:(id)delegate{

    HYMSortView *sortView = [[self alloc] initWithFrame:frame];
    sortView.backgroundColor = backgroudColor;
    sortView.buttonDownColor = buttonDownColor;
    sortView.titleColor = titleColor;
    sortView.selectColor = selectedColor;
    sortView.sortViewDelegate = delegate;
    sortView.titleFont = titleFont;
    [sortView addBtnArray:titleDataSource];
    
    return sortView;
}

- (void)addBtnArray:(NSArray *)btnArray{

    NSInteger btnNumber = btnArray.count;
    
    CGFloat btnX = kScreenWitdth/btnNumber;
    CGFloat btnWidth = kScreenWitdth/5;
    
    for (int i = 0; i < btnArray.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake( i*btnX, self.frame.size.height/2-20, btnWidth, 40);
         [btn addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:btnArray[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:self.titleFont];
        [btn setTitleColor:self.titleColor forState:UIControlStateNormal];
        [btn setTitleColor:self.selectColor forState:UIControlStateSelected];
        btn.tag = i+1;
       
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
       
        if (i == btnArray.count - 1) {
            
            [btn setImage:[UIImage imageNamed:@"筛选"] forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 1, 0, 0)];
            
            
            
        }else if (i == 1 || i== 2){

            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 10)];
            [btn setImage:[UIImage imageNamed:@"论坛-2"] forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 40, 0, 10)];
            
        }
        
        UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(kScreenWitdth -kScreenWitdth/4, 0, 0.5, self.frame.size.height);
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lineView];
        
        //右侧有图，暂时未放置
        [self addSubview:btn];
        
        [self.btnTitleSource addObject:btn];
    }
    
    [[self.btnTitleSource  firstObject] setSelected:YES];
}

#pragma mark 
- (void)btnAct:(UIButton *)btn{

    [self selectBtn:btn.tag - 1];
    
}

#pragma mark
- (void)selectBtn:(NSInteger)btn{

    if (_selectBtn != btn) {
     
        [self.btnTitleSource[self.selectBtn] setSelected:NO];
        [self.btnTitleSource[btn] setSelected:YES];
    }
    
    self.selectBtn = btn;
    
    [self.sortViewDelegate selectedBtnChange:self.selectBtn];
    
}


@end
