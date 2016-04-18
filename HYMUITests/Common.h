//
//  Common.h
//  HYM
//
//  Created by 刘晓雪 on 16/4/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#ifndef Common_h
#define Common_h

//屏宽
#define kScreenWitdth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//系统代理
#define applicationDeleagte (HYMAppDelegate *)[UIApplication sharedApplication].delegate

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

//tabbaritem字体大小
#define tabbarItemFont  [UIFont systemFontOfSize:12]

//tabbaritem字体颜色
#define tabbarItemColor  [UIColor blackColor]
//tabbaritem选择字体颜色
#define tabbarItemSelectedColor [UIColor brownColor]

#endif /* Common_h */
