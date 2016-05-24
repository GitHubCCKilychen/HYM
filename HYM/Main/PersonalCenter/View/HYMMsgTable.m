//
//  HYMMsgTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/16.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMMsgTable.h"

@interface HYMMsgTable ()<UITableViewDelegate,UITableViewDataSource>
@end
@implementation HYMMsgTable

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame: frame]) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UIImageView *iconImage = [[UIImageView alloc] init];
        iconImage.tag = 1;
        iconImage.frame = CGRectMake(15, 7.5, 45, 45);
        iconImage.backgroundColor = [UIColor grayColor];
        [cell.contentView addSubview:iconImage];
        
        UILabel *titleName = [[UILabel alloc] init];
        titleName.frame = CGRectMake(70, 10, kScreenWitdth-70-50,20);
        titleName.text = @"薅羊毛活动";
        titleName.font = [UIFont systemFontOfSize:15];;
        [cell.contentView addSubview:titleName];
        
        UILabel *subTitle = [[UILabel alloc] init];
        subTitle.frame = CGRectMake(70, 32, kScreenWitdth-70-50, 20);
        subTitle.text = @"大家都在薅羊毛，快来吧";
        subTitle.textColor = [UIColor lightGrayColor];
        subTitle.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:subTitle];
        
        UILabel *time = [[UILabel alloc] init];
        time.frame = CGRectMake(kScreenWitdth-50, 15, kScreenWitdth, 25);
        time.textColor = [UIColor grayColor];
        time.text = @"昨天";
        time.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:time];
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}
//
//- (void)
@end
