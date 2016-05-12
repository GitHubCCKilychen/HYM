//
//  HYMTaskList.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/11.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTaskList.h"
#import "HYMTaskListCell.h"

@interface HYMTaskList ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak)UITableViewCell *cell;

@end
@implementation HYMTaskList

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    HYMTaskListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[HYMTaskListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.indexPath = indexPath;
    }
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        
        return 30;
    }
    return 80.f;
}
@end
