//
//  HYMUpTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/10.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMUpTable.h"
#import "HYMUpModel.h"
#import "HYMUpTaskCell.h"
@interface HYMUpTable ()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation HYMUpTable

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}


- (void)setDatalist:(NSMutableArray *)datalist{

    _datalist = datalist;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    NSString *identifier = @"cell";
    HYMUpTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        
        cell = [[HYMUpTaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else{
    
        while ([cell.contentView.subviews lastObject] != nil) {
            
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    cell.indexPath = indexPath;
    
    HYMUpModel  *model = self.datalist[indexPath.row];
    
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    return 80;
}

@end
