//
//  HYMFormTableView.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/29.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMFormTableView.h"

@interface HYMFormTableView ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation HYMFormTableView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor grayColor];
        self.showsVerticalScrollIndicator = NO;
        self.scrollEnabled = NO;
    }
    
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
//    cell.backgroundColor = [UIColor grayColor];
    return cell;
}

@end
