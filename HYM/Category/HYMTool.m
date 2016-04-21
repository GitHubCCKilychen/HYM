//
//  HYMTool.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/20.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTool.h"

@implementation HYMTool


//label常用方法
//label常用方法
+ (UILabel *)initLabel:(UILabel *)label withFont:(UIFont *)textFont withTextColor:(UIColor *)textColor withTextAlignment:(UITextAlignment *)textAlignment{

    label.font = textFont;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    
    return label;
}
@end
