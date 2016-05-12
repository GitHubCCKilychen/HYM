//
//  HYMPostedCaseVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPostedCaseVC.h"
#import "HYMPostView.h"
@interface HYMPostedCaseVC ()


@end

@implementation HYMPostedCaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDefault];
}

- (void)initDefault{
    
    self.title = @"发布情况";
    self.view.backgroundColor = [UIColor whiteColor];
    [HYMNavigationVC setTitle:[UIColor whiteColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    
}

@end
