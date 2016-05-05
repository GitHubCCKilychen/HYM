//
//  HYMTaskTableView.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/27.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTaskTableView.h"
#import "HYMTaskCell.h"
#import "HYMTaskDetailsVC.h"
@interface HYMTaskTableView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation HYMTaskTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self = [super initWithFrame:frame style:style]) {
        
        self.showsVerticalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
    }
    
    return self;
}

#pragma mark datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    HYMTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[HYMTaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  
    }
    
    
        [cell cell2];

    
    return cell;
}

#pragma mark delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    return 110.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.01;
}

#pragma mark 跳转任务详情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    HYMTaskDetailsVC *taskDetailsVC = [[HYMTaskDetailsVC alloc] init];
    [self.viewController.navigationController pushViewController:taskDetailsVC animated:YES];
    
}
@end
