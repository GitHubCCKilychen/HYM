//
//  HYMTaskList.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/11.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTaskList.h"
#import "HYMTaskListCell.h"
#import "HYMPubListModel.h"
#import "HYMPostedCaseVC.h"
#import "HYMTaskDetailsVC.h"
#import "HYMPublisDetails.h"
@interface HYMTaskList ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak)UITableViewCell *cell;

@end
@implementation HYMTaskList

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (void)setDatalist:(NSMutableArray *)datalist{
    
    _datalist = datalist;
    [self reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UIImageView *storeImage = [[UIImageView alloc] init];
        storeImage.frame = CGRectMake(15, 10, 60, 60);
        storeImage.tag = 1;
        [cell.contentView addSubview:storeImage];
        
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(80, 15, kScreenWitdth/2, 40);
        title.numberOfLines = 0;
        title.tag = 2;
        title.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:title];
        
        
        UIButton *seeTask = [UIButton buttonWithType:UIButtonTypeCustom];
        seeTask.frame = CGRectMake(kScreenWitdth-70, 10, 50, 25);
        seeTask.backgroundColor = [UIColor colorWithRed:44/256.f green:150/256.f blue:253/256.f alpha:1];
        [seeTask addTarget:self action:@selector(seeTask:) forControlEvents:UIControlEventTouchUpInside];
        seeTask.tag = 3;
        [seeTask setTitle:@"预览" forState:UIControlStateNormal];
        seeTask.titleLabel.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:seeTask];
        
        UIButton *publish = [UIButton buttonWithType:UIButtonTypeCustom];
        publish.frame = CGRectMake(kScreenWitdth-70, 45, 50, 25);
        [publish setTitle:@"发布" forState:UIControlStateNormal];
        publish.tag = 4;
        publish.titleLabel.font = [UIFont systemFontOfSize:14];
        publish.backgroundColor = [UIColor colorWithRed:25/255.f green:185/255.f blue:78/255.f alpha:1];
        [publish addTarget:self action:@selector(publishAct:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:publish];
        
    }

    HYMPubListModel *model = self.datalist[indexPath.row];
    
    UIImageView *storeImage = [cell.contentView viewWithTag:1];
    [storeImage sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    
    UILabel *title = [cell.contentView viewWithTag:2];
    title.text = model.title;
    

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80.f;
}

- (void)setIndex:(int)index{

    _index = index;

}
#pragma mark 发布
- (void)publishAct:(UIButton *)btn{
    
    //发布情况
    HYMPostedCaseVC *postedVC = [[HYMPostedCaseVC alloc] init];
    postedVC.index = self.index;
    postedVC.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:postedVC animated:YES];
    
}

#pragma mark 预览情况
- (void)seeTask:(UIButton *)task{
    
    
    HYMPublisDetails *taskVC = [[HYMPublisDetails alloc] init];
    [self.viewController.navigationController pushViewController:taskVC animated:YES];
}
@end
