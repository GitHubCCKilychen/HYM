//
//  ScrollLabel.h
//  文字滚动－
//
//  Created by 刘晓雪 on 16/4/17.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  ScrollLabelDelegate <NSObject>

- (void)btnClick:(UIButton *)btn;

@end

@interface ScrollLabel : UIView

@property (nonatomic,weak)id<ScrollLabelDelegate>scrollLabelDelegate;

- (instancetype)initWithFrame:(CGRect)frame withTitleArr:(NSArray *)titleArr;
@end
