//
//  HYMTabBarItem.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/22.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTabBarItem.h"

@implementation HYMTabBarItem

-(instancetype)init{
    self = [super init];
    UIColor *tabarTitleNormalColor = [UIColor colorWithRed:144.0/255.0 green:145.0/255.0 blue:146/255.0 alpha:1.0];
    //    UIColor *tabarTitleNormalColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    
    
    UIColor *tabarTitleHighlightColor = [UIColor colorWithRed:20.0/255.0 green:157.0/255.0 blue:150/255.0 alpha:1.0];
    ;
    [self setTitleTextAttributes:[NSDictionary
                                  dictionaryWithObjectsAndKeys: tabarTitleNormalColor,
                                  NSForegroundColorAttributeName,[UIFont systemFontOfSize:11.0], NSFontAttributeName,nil] forState:UIControlStateNormal];
    [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:tabarTitleHighlightColor, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];//高亮状态。
    return self;
}

@end
