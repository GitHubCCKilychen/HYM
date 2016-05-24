
//
//  ScrollView.m
//  轮播图
//
//  Created by 刘晓雪 on 16/4/17.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "ScrollView.h"
#import "HYMHeaderModel.h"
#define kScreenWith [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ScrollView ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,weak)NSTimer *timer;

@end

@implementation ScrollView


#pragma mark 初始化
- (id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {

        [self initTimer];
        
    
    }
    
    return self;
}


- (void)setScrollList:(NSMutableArray *)scrollList{

    _scrollList = scrollList;

    [self initScroll];
    [self initPage];
    
    
    [self initWithImage];
   

}

- (void)initScroll{

    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.backgroundColor = [UIColor brownColor];
    self.scrollView.contentSize = CGSizeMake(kScreenWith * self.scrollList.count, 0);
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
}

- (void)initPage{

    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width/2-20, self.frame.size.height-20, 40, 15)];
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = self.scrollList.count;
    [self addSubview:self.pageControl];
}
#pragma mark 图片添加
- (void)initWithImage{
    
    for (int i = 0 ; i< self.scrollList.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(i * kScreenWitdth, 0, kScreenWitdth, self.scrollView.frame.size.height);
        HYMHeaderModel *model = self.scrollList[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.imgurl]];
        imageView.contentMode = UIViewContentModeScaleToFill;
        [self.scrollView addSubview:imageView];

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
