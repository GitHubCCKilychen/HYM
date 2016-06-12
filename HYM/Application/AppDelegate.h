//
//  HYMAppDelegate.h
//  HYM
//
//  Created by  on 16/4/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder<UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,assign)BOOL isLogin;
@property (nonatomic,copy)NSString *mydeviceid;
@property (nonatomic,strong)NSString *mycity;
@end
