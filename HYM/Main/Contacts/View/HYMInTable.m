//
//  HYMInTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/20.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMInTable.h"
#import "HYMInHeaderView.h"
#import "HYMInLastView.h"
@interface HYMInTable ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)HYMInHeaderView *headView;
@property (nonatomic,strong)HYMInLastView *lastView;
@end

@implementation HYMInTable

- (void)setDatalist:(NSMutableArray *)datalist{

    _datalist = datalist;
    
    [self reloadData];
}


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self = [super initWithFrame: frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }

    return self.datalist.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        if (indexPath.section == 0) {
            
             self.headView = [[HYMInHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth, 80)];
            [cell.contentView addSubview:self.headView];
        }else if (indexPath.section == 1){
        
            self.lastView = [[HYMInLastView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth, 300)];
            HYMConModel *model = self.datalist[indexPath.row];
            self.lastView.model = model;

            [cell.contentView addSubview:self.lastView];
        }
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 1) {
    
        return 15;
    }
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
        return 80;
    }
    return 300;
}
@end
