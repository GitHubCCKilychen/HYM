//
//  HYMSortView.h
//  HYM
//
//  Created by 刘晓雪 on 16/4/28.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYMSortViewDelegate <NSObject>

- (void)selectedBtnChange:(NSInteger)selectedBtn;

@end

@interface HYMSortView : UIView

@property (nonatomic,strong)NSMutableArray *btnTitleSource;
@property (strong, nonatomic) UIColor * titleColor;
@property (strong, nonatomic) UIColor * selectColor;
@property (strong, nonatomic) UIFont * titleFont;
@property (nonatomic, strong) UIColor * buttonDownColor;

@property (nonatomic,weak)id<HYMSortViewDelegate>sortViewDelegate;

+ (HYMSortView *)setFrame:(CGRect)frame titleDataSource:(NSArray *)titleDataSource backgroudColor:(UIColor *)backgroudColor titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont selectedColor:(UIColor *)selectedColor buttonDownColor:(UIColor*)buttonDownColor delegate:(id)delegate;
@end
