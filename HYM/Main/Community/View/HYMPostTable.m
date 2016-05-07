//
//  HYMPostTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/6.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPostTable.h"

@interface HYMPostTable ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSArray *cellTitle;
@end

@implementation HYMPostTable

- (NSArray *)cellTitle{

    if (_cellTitle == nil) {
        
        _cellTitle = [NSArray array];
        _cellTitle = @[@"选择帖子分类",@"闲聊",@"500元以上投资",@"100-500元薅",@"10-100元薅",@"0-10元薅",@"0元薅"];
    }
    return _cellTitle;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 7;
    }

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    
    if (indexPath.section == 0) {
      cell.textLabel.text = self.cellTitle[indexPath.row];
        
    }else{
    
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setBackgroundColor:[UIColor orangeColor]];
        sureBtn.layer.cornerRadius = 5;
        sureBtn.frame = CGRectMake(20, 150/2-20, cell.contentView.frame.size.width-40-70, 40);
        [cell.contentView addSubview:sureBtn];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1) {
        
        return 150;
    }
    
    return 44.f;
}
@end
