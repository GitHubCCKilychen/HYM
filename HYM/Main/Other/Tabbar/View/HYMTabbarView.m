//
//  HYMTabbarView.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTabbarView.h"
#import "HYMTabbarButton.h"
@interface HYMTabbarView ()


@property (nonatomic,strong)NSMutableArray *buttonsCount;
@property (nonatomic,strong)UIButton *selectdButton;
@end

@implementation HYMTabbarView


- (NSMutableArray *)buttonsCount{
    if (_buttonsCount == nil) {
        _buttonsCount = [NSMutableArray array];
    }
    return _buttonsCount;
}


- (void)setItemsCount:(NSArray *)itemsCount{

    _itemsCount = itemsCount;
    
    //根据个数来创建item的个数
    
//    NSLog(@"%lu",(unsigned long)_itemsCount.count);
    
    for (UITabBarItem *item in _itemsCount) {
        
        HYMTabbarButton *tabbarButton = [HYMTabbarButton buttonWithType:UIButtonTypeCustom];
        tabbarButton.tabbarItem = item;
        tabbarButton.tag = self.buttonsCount.count;
        [tabbarButton addTarget:self action:@selector(tabbarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tabbarButton];
        
        //默认选中第一个
        if (tabbarButton.tag == 0) {
            
            [self tabbarButtonClick:tabbarButton];
        }
        
        [self.buttonsCount addObject:tabbarButton];
    }
}

#pragma mark tabbarButton点击事件
- (void)tabbarButtonClick:(UIButton *)button{
    
    _selectdButton.selected = NO;
    button.selected = YES;
    _selectdButton = button;
    
    //切换控制器
    if ([_tabbarDelegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
 
        [_tabbarDelegate tabBar:self didClickButton:button.tag];
    }
  
}

#pragma mark 布局
- (void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width;
    CGFloat buttonY = 0;
    CGFloat buttonWidth = width/self.buttonsCount.count;
    CGFloat buttonHeight = self.bounds.size.height;
    
    int i = 0;
    for (UIView *tabbarItem in self.buttonsCount) {
        
        
        tabbarItem.frame = CGRectMake(width/self.buttonsCount.count *i , buttonY, buttonWidth, buttonHeight);
        i++;
    }
    
}
@end
