//
//  HYMTaskVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/27.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMHomeTaskVC.h"

@interface HYMHomeTaskVC ()

@end

@implementation HYMHomeTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initWithView];
}

#pragma mark 
- (void)initWithView{

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"任务";
    [HYMNavigationVC setLeftBackItem:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
}




@end
