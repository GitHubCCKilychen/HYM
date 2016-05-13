//
//  HYMWholeTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/13.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMWholeTable.h"
#import "HYMWholeCell.h"
@interface HYMWholeTable ()<UITableViewDataSource,UITableViewDelegate>
@end

@implementation HYMWholeTable

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self = [super initWithFrame:frame style:style]) {
        
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
    HYMWholeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[HYMWholeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

@end
