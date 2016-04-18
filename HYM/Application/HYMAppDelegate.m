//
//  HYMAppDelegate.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMAppDelegate.h"
#import "HYMTabbarVC.h"
@interface HYMAppDelegate ()

@end

@implementation HYMAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    HYMTabbarVC *tabbarVC = [[HYMTabbarVC alloc] init];
    self.window.rootViewController = tabbarVC;
    [self.window makeKeyAndVisible];
    

    
    //判断是不是第一次启动
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
        NSLog(@"第一次启动");
    }else{
    
        NSLog(@"不是第一次启动");
    }
    
    

    
    return YES;
}

@end
