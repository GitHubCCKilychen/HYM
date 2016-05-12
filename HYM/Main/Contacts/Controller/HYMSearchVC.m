//
//  HYMSearchVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/9.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMSearchVC.h"

@interface HYMSearchVC ()

@end

@implementation HYMSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDefault];
    [self initWithView];
}

- (void)initDefault{

    self.title = @"搜索好友";
    self.view.backgroundColor = [UIColor whiteColor];
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
}

- (void)initWithView{

    
}



@end
