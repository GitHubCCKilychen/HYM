//
//  UINavViewController.h
//  BAOWEN
//
//  Created by 平川嘉恒 on 13-9-5.
//  Copyright (c) 2013年 平川嘉恒. All rights reserved.
//

#import <UIKit/UIKit.h>
//用于横竖屏的设置
@interface UINavViewController : UINavigationController<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,assign) BOOL canDragBack;
@end
