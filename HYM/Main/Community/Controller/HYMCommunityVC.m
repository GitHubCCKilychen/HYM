//
//  HYMCommunityVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMCommunityVC.h"

@interface HYMCommunityVC ()

@end

@implementation HYMCommunityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //默认配置
    [self initDefault];
    [self initWithView];
}

- (void)initDefault{

    
}
- (void)initWithView{

    self.title = @"社区";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
}



@end
