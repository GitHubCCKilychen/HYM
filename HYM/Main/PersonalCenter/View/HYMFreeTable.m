//
//  HYMFreeTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/18.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMFreeTable.h"

@interface HYMFreeTable ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation HYMFreeTable

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    if (self = [super initWithFrame: frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = NO;
        self.showsVerticalScrollIndicator =NO;
        
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        NSArray *arr = @[@"借贷宝",@"2016-04-10",@"10",@"6",@"1230元"];
        CGFloat labelWidth = kScreenWitdth/5;
        for (int i = 0; i < 5; i ++) {
            
            UILabel *title = [[UILabel alloc] init];
            title.frame = CGRectMake(0+i*labelWidth+i*1,12,labelWidth, 20);
            title.text = arr[i];
            title.font = [UIFont systemFontOfSize:11];
            title.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:title];
            
        }
        
    }
    
    if (indexPath.row %2 ==1) {
        
        cell.backgroundColor = [UIColor whiteColor];
        
    }else if (indexPath.row %2 == 0)
    {
        cell.backgroundColor = [UIColor colorWithRed:244/256.f green:245/256.f blue:246/256.f alpha:1];
    }
    
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.001;
}


@end
