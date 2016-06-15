//
//  HYMAppDelegate.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "AppDelegate.h"
#import "HYMTabbarVC.h"
@interface AppDelegate ()


@end

@implementation AppDelegate


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
#pragma mark 内存⚠️
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{

    //停止所有的下载
    [[SDWebImageManager  sharedManager] cancelAll];
    
    //删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

@end
