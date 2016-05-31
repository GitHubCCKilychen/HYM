//
//  HYMListPerson.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/31.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMListPerson.h"

@interface HYMListPerson ()

@end

@implementation HYMListPerson

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initDefault];
}

- (void)initDefault{

    self.title = @"个人信息";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
}



@end
