//
//  HYMNavigationVC.h
//  HYM
//
//  Created by 刘晓雪 on 16/4/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYMNavigationVC : UINavigationController

+ (NSDictionary *)setTitle:(UIColor *)fontColor withFontSize:(CGFloat)fontSize withNavi:(UINavigationBar *)navi;

+ (UIBarButtonItem *)rightBarItem:(UIButton *)button withBackImage:(UIImage *)image withNavi:(UINavigationBar *)navi;

@end

