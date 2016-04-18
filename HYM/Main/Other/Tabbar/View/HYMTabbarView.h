//
//  HYMTabbarView.h
//  HYM
//
//  Created by 刘晓雪 on 16/4/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYMTabbarView;
@protocol HYMTabbarViewDelegate <NSObject>

- (void)tabBar:(HYMTabbarView *)tabBar didClickButton:(NSInteger)index;

@end


@interface HYMTabbarView : UIView

//item个数
@property (nonatomic,strong)NSArray *itemsCount;
@property (nonatomic,weak)id<HYMTabbarViewDelegate>tabbarDelegate;

@end
