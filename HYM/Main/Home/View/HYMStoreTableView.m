//
//  HYMStoreTableView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/4.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMStoreTableView.h"
#import "HYMStoreCell.h"
#import "HYMStore2Cell.h"
@interface HYMStoreTableView ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation HYMStoreTableView

- (void)setDatalist:(NSMutableArray *)datalist{

    _datalist = datalist;
    
    [self reloadData];
}


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        
    }
    
    return self;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 4) {
        return 2;
    }

    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"cell";

    HYMStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    HYMStore2Cell *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (indexPath.section == 0 || indexPath.section == 2) {
         cell = [[HYMStoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];

        
        HYMMallModel *model = self.datalist[indexPath.row];
        cell.model = model;
        return cell;
    }else{
    
        cell1 = [[HYMStore2Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        HYMMallModel *model = self.datalist[indexPath.row];
        cell1.model = model;
        return cell1;
    }

    
}

#pragma mark delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 140;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10;
}
@end
