
//
//  ScrollView.m
//  轮播图
//
//  Created by 刘晓雪 on 16/4/17.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "ScrollView.h"
#define kScreenWith [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ScrollView ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,weak)NSTimer *timer;

@end

@implementation ScrollView

#pragma mark 懒加载
- (UIScrollView *)scrollView{

    if (_scrollView == nil) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = [UIColor brownColor];
        _scrollView.contentSize = CGSizeMake(kScreenWith * 3, 0);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
    }
    
    return _scrollView;
}

- (UIPageControl *)pageControl{

    if (_pageControl == nil) {
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width/2-20, self.frame.size.height-20, 40, 15)];
        _pageControl.numberOfPages = 3;
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

#pragma mark 初始化
- (id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {

        [self initWithScroll];
        [self initTimer];
    }
    
    return self;
}


#pragma mark 有数据后删除
- (void)initWithScroll{

    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    
    [self initWithImage];
    
}

#pragma mark 滚动个数－－添加控件
- (void)setScrollList:(NSMutableArray *)scrollList{

    _scrollList = scrollList;
    
    
}
#pragma mark 图片添加
- (void)initWithImage{

//    //i<_scrollList.count
    for (int i = 0 ; i< 3; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * kScreenWitdth, 0, kScreenWitdth, self.scrollView.frame.size.height);
        btn.backgroundColor = [UIColor redColor];
        NSString *imageName = [NSString stringWithFormat:@"%d",i];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        btn.tag = i;
        [self.scrollList addObject:btn];
    }
}

#pragma mark 轮播图跳转事件
- (void)imageViewAct:(UIButton *)btn{

    switch (btn.tag) {
        case 0:
        {
        }
            break;
        case 1:
        {
        }
            break;
        case 2:
        {
        }
            break;
        default:
            break;
    }
    
}
#pragma mark 时间
- (void)initTimer{
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(timerAct) userInfo:nil repeats:YES];
    self.timer = timer;

    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    
    [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
}

#pragma mark 时间事件
- (void)timerAct{

    
    //获取当前滚动的pagControl
    NSInteger index = self.pageControl.currentPage;
    if (index == self.pageControl.numberOfPages - 1) {
        
        index = 0;
    }else{
    
        index++;
    }
    CGFloat offsetX = index * self.frame.size.width;
    [UIView animateWithDuration:1.0 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(offsetX, 0);
    }];
    
}

#pragma mark 实时滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSInteger currentIndex = scrollView.contentOffset.x/scrollView.frame.size.width;
    _pageControl.currentPage = currentIndex;
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
