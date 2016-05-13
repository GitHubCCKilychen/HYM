//
//  HYMGoTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMGoTable.h"
#import "HYMGoCell.h"
#import "HYMGoTaskCell.h"
@interface HYMGoTable ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation HYMGoTable

- (void)setSelection:(NSInteger)selection{
    
    _selection = selection;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    if (self =[super initWithFrame:frame style:style] ) {
        
        
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
    
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"cell";
    HYMGoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    HYMGoTaskCell *cell2 = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (indexPath.section == 0) {
        
        cell = [[HYMGoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
    
        cell2 = [[HYMGoTaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell2.indexPath = indexPath;
        cell2.selection = self.selection;
        return cell2;
    }
    
    
    return cell;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return 100;
    }else if (indexPath.section == 1)
    {
    
        if (indexPath.row == 2) {
            
            return 65;
        }
    }
    return 105;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0.001;
    }
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (section == 0) {
        return 0.0001;
    }
    return 0.001;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
@end
