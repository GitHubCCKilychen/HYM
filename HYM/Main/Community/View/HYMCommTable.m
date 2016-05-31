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
#import "HYMCommModel.h"
@interface HYMCommTable ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak)HYMCommBlogVC *blogvc;
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


- (void)setDatalist:(NSMutableArray *)datalist{
    _datalist = datalist;
}
#pragma mark datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"cell";
    HYMCommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[HYMCommunityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.index = indexPath.row;
    }
    //判断当前是不是自己的帐号，如果是就添加删除按钮
    
    
    HYMCommModel *model = self.datalist[indexPath.row];
    
    cell.model = model;
    
    
    return cell;
    
}



#pragma mark 选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HYMCommBlogVC *blogVC = [[HYMCommBlogVC alloc] init];
    
    HYMCommModel *model = self.datalist[indexPath.row];
    
    blogVC.index = model.blogID;
    
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
