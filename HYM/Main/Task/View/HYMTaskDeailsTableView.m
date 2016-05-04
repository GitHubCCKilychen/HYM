//
//  HYMTaskDeailsTableView.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/28.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTaskDeailsTableView.h"

#import "HYMTaskDeailsCell.h"
@interface HYMTaskDeailsTableView ()<UITableViewDataSource,UITableViewDelegate>


@end
@implementation HYMTaskDeailsTableView

- (void)setIndex:(NSInteger)index{
    _index = index;
    
    if (_index == 1) {
        
        NSLog(@"1");
        [self reloadData];
    }else{
    
        NSLog(@"0");
    }
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self == [super initWithFrame:frame style:style]) {
     
        self.showsVerticalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;

    }
    
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    HYMTaskDeailsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[HYMTaskDeailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (self.index == 0) {
        
//        cell.model = 
        //根据索引值传递数据
    }else if (self.index ==1){
    
//        cell.model = 
        
    }
    
    return cell;
}

#pragma mark delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    return 130;
}


@end
