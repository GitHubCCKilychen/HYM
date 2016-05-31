//
//  HYMComMsgTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/27.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//
#import "HYMComMsgTable.h"
#import "HYMHomeMsgModel.h"
@interface HYMComMsgTable ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation HYMComMsgTable

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self= [super initWithFrame: frame]) {
        
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
        cell = [[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UIImageView *iconImage = [[UIImageView alloc] init];
        iconImage.tag = 1;
        iconImage.frame = CGRectMake(15, 7.5, 45, 45);
    
        [cell.contentView addSubview:iconImage];
        
        UILabel *titleName = [[UILabel alloc] init];
        titleName.frame = CGRectMake(70, 10, kScreenWitdth-70-50,20);
        titleName.text = @"薅羊毛活动";
        titleName.tag = 2;
        titleName.font = [UIFont systemFontOfSize:15];;
        [cell.contentView addSubview:titleName];
        
        UILabel *subTitle = [[UILabel alloc] init];
        subTitle.frame = CGRectMake(70, 32, kScreenWitdth-70-50, 20);
        subTitle.text = @"大家都在薅羊毛，快来吧";
        subTitle.tag = 3;
        subTitle.textColor = [UIColor lightGrayColor];
        subTitle.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:subTitle];
        
        UILabel *time = [[UILabel alloc] init];
        time.frame = CGRectMake(kScreenWitdth-150, 10, 150, 20);
        time.textColor = [UIColor grayColor];
        time.text = @"昨天";
        time.tag = 4;
        time.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:time];
    }
    
    HYMHomeMsgModel *model = self.datalist[indexPath.row];
    
    UIImageView *iconImage = [cell viewWithTag:1];
    if ([model.avatar isEqual:[NSNull null]]) {
        iconImage.image  = [UIImage imageNamed:@"aaa"];
    }else{
        [iconImage sd_setImageWithURL:[NSURL URLWithString:model.avatar]] ;
    }
    
    UILabel *title = [cell viewWithTag:2];
    title.text = model.nickname;
    
    UILabel *content = [cell viewWithTag:3];
    content.text = model.content;
    
    UILabel *time = [cell viewWithTag:4];
    time.text = model.regdate;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

@end