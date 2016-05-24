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


#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
//---------
#define REFRESH_HEADER_HEIGHT 52.0f
#define ADDMORE_HEIGHT 30.0f
#define ViewHieght IS_IPHONE5?505.0f:417.0f

#define kTextAlignmentCenter    NSTextAlignmentCenter
#define kTextAlignmentLeft      NSTextAlignmentLeft
#define kTextAlignmentRight     NSTextAlignmentRight

#define UI_View_Hieght (IS_IPHONE5?504.0f:416.0f)
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height


#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

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

//----------------常用颜色值-----------------
#define BB_Back_Color_Here [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0f]
#define BB_Button_Color [UIColor colorWithRed:255/255.0 green:66/255.0 blue:0/255.0 alpha:1]
#define BB_Gray [UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0f]
#define BB_White_Color [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]
#define BB_Blake [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1]
#define BB_Blake [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1]

#define BB_BackColor [UIColor colorWithRed:240/255.0 green:96/255.0 blue:25/255.0 alpha:1]
#define TextColor [UIColor colorWithRed:54/255.0 green:146/255.0 blue:177/255.0 alpha:1]
#define Cell_BackColr [UIColor colorWithRed:226/255.0 green:240/255.0 blue:244/255.0 alpha:1]

//-------------------网络--------------
#define REQUEST_Root_Net @"http://123.56.237.91/"
#define REQUEST_Task_List @"index.php/Webservice/Center/task_list"
#define REQUEST_Task_Info @"index.php/Webservice/Task/task_info"
#define REQUEST_Task_Jojn @"index.php/Webservice/?m=Task&a=task_join"

//---------------
#define BUY_SUCCESS_XUNI @"buy_success_xuni"
#define BUY_SUCCESS_SHIQU @"buy_success_shiwu"

#endif /* Common_h */
