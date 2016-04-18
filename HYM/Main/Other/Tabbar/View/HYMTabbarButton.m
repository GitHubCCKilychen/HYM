//
//  HYMTabbarButton.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTabbarButton.h"

#define tabbrImageRadio 0.7
@implementation HYMTabbarButton


- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        //字体
        [self setTitleColor:tabbarItemColor forState:UIControlStateNormal];
        [self setTitleColor:tabbarItemSelectedColor forState:UIControlStateSelected];
        
        self.titleLabel.font = tabbarItemFont;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    //图片－－
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    
    return self;
}

#pragma mark －－
-(void)setTabbarItem:(UITabBarItem *)tabbarItem{

    _tabbarItem = tabbarItem;
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    [tabbarItem addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [tabbarItem addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [tabbarItem addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{

    [self setImage:_tabbarItem.image forState:UIControlStateNormal];
    [self setImage:_tabbarItem.selectedImage forState:UIControlStateSelected];
    [self setTitle:_tabbarItem.title forState:UIControlStateNormal];
}

#pragma mark 控件重新布局
- (void)layoutSubviews{

    [super layoutSubviews];
    
    //图片
    
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageWidth = self.bounds.size.width;
    CGFloat imageHeight = self.bounds.size.height * tabbrImageRadio;
    self.imageView.frame = CGRectMake(imageX, imageY, imageWidth, imageHeight);
    
    //字体
    CGFloat titleX = 0;
    CGFloat titleY = imageHeight - 3;
    CGFloat titleWidth = self.bounds.size.width;
    CGFloat titleHeight = self.bounds.size.height - titleY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleWidth,titleHeight);
    
}

- (void)dealloc{
    [self.tabbarItem removeObserver:self forKeyPath:@"title"];
    [self.tabbarItem removeObserver:self forKeyPath:@"image"];
    [self.tabbarItem removeObserver:self forKeyPath:@"selectedImage"];
}
    
@end
