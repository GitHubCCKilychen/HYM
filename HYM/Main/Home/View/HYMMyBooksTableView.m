//
//  HYMMyBooksTableView.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/27.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMMyBooksTableView.h"
#import "HYMRecordCell.h"
@interface HYMMyBooksTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation HYMMyBooksTableView

- (id)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
     
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
#pragma mark dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    
    HYMRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[HYMRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    HYMMyBookModel *model = self.datalist[indexPath.row];
    cell.model = model;
    //NSLog(@"%@",model.name);
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;
}

@end
