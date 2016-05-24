
//
//  HYMTieziTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/14.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTieziTable.h"

@interface HYMTieziTable ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSArray *titleArr;
@property (nonatomic,copy)NSString *title;
@end
@implementation HYMTieziTable

- (NSArray *)titleArr{

    if (_titleArr == nil) {
        
        _titleArr = [NSArray array];
        _titleArr = @[@"闲聊",@"500元以上薅",@"100-500元薅",@"10-100元薅",@"0-10元薅",@"0元薅"];
    }
    return _titleArr;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame: frame]) {
        
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        
    }
    
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
       
    }
    
    cell.textLabel.text = self.titleArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.tag = 1;
    
    self.title =cell.textLabel.text;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:

            break;
        case 1:
             NSLog(@"1");
            break;
        case 2:
             NSLog(@"2");
            break;
        case 3:
             NSLog(@"3");
            break;
        case 4:
             NSLog(@"4");
            break;
        default:
            break;
    }
    

//    
}


- (void)getTitle:(NSString *)title{

    
}

@end
