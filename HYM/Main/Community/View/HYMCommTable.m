//
//  HYMCommTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/5.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMCommTable.h"
#import "HYMCommunityCell.h"
#import "HYMCommBlogVC.h"
@interface HYMCommTable ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation HYMCommTable

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self = [super initWithFrame:frame style:style]) {
    
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator =NO;
        
    }
    return self;
}

#pragma mark datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"cell";
    HYMCommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HYMCommunityCell" owner:self options:nil] lastObject];
    }
    //判断当前是不是自己的帐号，如果是就添加删除按钮
    
    return cell;
    
}

#pragma mark 选中删除
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HYMCommBlogVC *blogVC = [[HYMCommBlogVC alloc] init];
    [self.viewController.navigationController pushViewController:blogVC animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 150;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 10;
}
@end
