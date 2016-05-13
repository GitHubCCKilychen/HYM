//
//  HYMSegmentView.h
//  HYM
//
//  Created by 刘晓雪 on 16/4/27.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  HYMSegmentViewDelegate <NSObject>

@optional

-(void)segumentSelectionChange:(NSInteger)selection;

@end

@interface HYMSegmentView : UIView
@property (nonatomic,weak)UIButton *btn;
@property (nonatomic,assign)NSInteger index;
@property (nonatomic, strong) NSMutableArray * btnTitleSource;
@property (strong, nonatomic) UIColor * titleColor;
@property (strong, nonatomic) UIColor * selectColor;
@property (strong, nonatomic) UIFont * titleFont;
@property (nonatomic, strong) UIColor * buttonDownColor;
@property (nonatomic,weak)id<HYMSegmentViewDelegate>segmentDelegate;


+ (HYMSegmentView *)segmenFrame:(CGRect)frame titleDataSource:(NSArray *)titleArr backgroundColor:(UIColor *)backgroundColor  titleColor:(UIColor *)titleColor titleFont:(UIFont*)titleFont selectedColor:(UIColor *)selectedColor buttonDownColor:(UIColor *)buttonDownColor delegate:(id)delegate;
@end
