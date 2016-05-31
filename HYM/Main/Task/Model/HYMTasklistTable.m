//
//  HYMlistTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/27.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTasklistTable.h"
#import "HYMListCell.h"
@interface HYMTasklistTable ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation HYMTasklistTable

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
    HYMListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
       
        cell = [[HYMListCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    HYMTaskRecordModel *model = self.datalist[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 110;
}

@end
