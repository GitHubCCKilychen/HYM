//
//  HYMRemindTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/23.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMRemindTable.h"
#import "HYMRemindModel.h"
@interface HYMRemindTable ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation HYMRemindTable

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)setDatalist:(NSMutableArray *)datalist{

    _datalist = datalist;
    [self reloadData];
    
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
   
    
        UILabel *name = [[UILabel alloc] init];
        name.frame = CGRectMake(15, 5, kScreenWitdth/2, 20);
        name.text = @"借贷宝";
        name.tag = 1;
        name.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:name];
        
        
        UILabel *time = [[UILabel alloc] init];
        time.frame = CGRectMake(15, 28,kScreenWitdth/2 , 20);
        time.textColor = [UIColor lightGrayColor];
        time.text = @"2016-09-21 12:35";
        time.font = [UIFont systemFontOfSize:13];
        time.tag = 2;
        [cell.contentView addSubview:time];
        
        UILabel *task = [[UILabel alloc] init];
        task.frame = CGRectMake(kScreenWitdth-120, 50-20, 60, 20);
        task.font = [UIFont systemFontOfSize:13];
        task.text = @"任务返利";
        task.tag = 3;
        [cell.contentView addSubview:task];
        
        UILabel *money = [[UILabel alloc] init];
        money.frame = CGRectMake(kScreenWitdth-60,30 , 50, 20);
        money.textColor = [UIColor redColor];
        money.font = [UIFont systemFontOfSize:13];
        money.text = @"20.00元";
        money.tag = 4;
        [cell.contentView addSubview:money];
    }
    
    if (indexPath.row %2 == 1) {
        
        cell.contentView.backgroundColor = [UIColor colorWithRed:241/255.f green:242/255.f blue:243/255.f alpha:1];
    }else{
    
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    HYMRemindModel *model = self.datalist[indexPath.row];
    
    UILabel *name = [cell.contentView viewWithTag:1];
    name.text = model.title;
    
    
    UILabel *time = [cell.contentView viewWithTag:2];
    time.text = model.end_time;
    
    //时间格式－－不对－改
    
    UILabel *money = [cell.contentView viewWithTag:4];
    
    NSString *string = [NSString stringWithFormat:@"%@元",model.fanli];
    money.text = string;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}
@end
