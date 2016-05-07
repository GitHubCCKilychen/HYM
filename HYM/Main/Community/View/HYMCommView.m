//
//  HYMCommView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/5.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMCommView.h"

@interface HYMCommView ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UILabel *label;
@property (nonatomic,weak)NSTimer *timer;
@end

@implementation HYMCommView

- (UILabel *)label{

    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.frame = CGRectMake(0, 0,kScreenWitdth,30);
//        _label.backgroundColor = [UIColor grayColor];
        _label.text = @"1";
    }
    return _label;
}

- (UIScrollView *)scrollView{

    if (_scrollView == nil) {
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 0, kScreenWitdth, 30);
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(0, 3*30);
        _scrollView.pagingEnabled = YES;
        
    }
    return _scrollView;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self initWithView];
        //初始化定时器
        [self initTimer];
        
    }
    return self;
}

#pragma mark initview
- (void)initWithView{
    [self addSubview:self.scrollView];
    [self addSubview:self.label];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSInteger index = scrollView.contentOffset.y/scrollView.frame.size.height;
    
    self.label.text = [NSString stringWithFormat:@"%ld",(long)index];
}

#pragma mark 定时器
- (void)initTimer{

    NSTimer *timer = [NSTimer timerWithTimeInterval:0.35 target:self selector:@selector(timerAct) userInfo:nil repeats:YES];
    self.timer = timer;
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)timerAct{
    
    //获取当前滚动的index
    NSInteger index = self.scrollView.contentOffset.y/self.scrollView.frame.size.height;
    CGFloat offsetX = index * 30;
    [UIView animateWithDuration:0.35 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(0, offsetX);
    }];
    
}
#pragma mark 开启定时器
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    // 开启
    [self initTimer];
}
#pragma mark 取消定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.timer invalidate];
}

@end
