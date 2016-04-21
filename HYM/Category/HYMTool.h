//
//  HYMTool.h
//  HYM
//
//  Created by 刘晓雪 on 16/4/20.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYMTool : NSObject

/**
    *font;
    *text;
    *textColor;
    textAlignment
*/
//label常用方法
+ (UILabel *)initLabel:(UILabel *)label withFont:(UIFont *)textFont withTextColor:(UIColor *)textColor withTextAlignment:(UITextAlignment *)textAlignment;
@end
