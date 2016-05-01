//
//  HYMRecordTableView.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/28.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMRecordTableView.h"

@interface HYMRecordTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSArray *titleArr;
@end

@implementation HYMRecordTableView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
     
        self.titleArr = @[@"阅读未参与",@"参与未报单",@"报单未审核",@"审核未通过",@"已完成",@"已忽略"];
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.scrollEnabled = NO;
        
       
    }
    
    return self;
}

#pragma mark dataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.titleArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
  
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(10, 7, 30, 30);
    imageView.backgroundColor = [UIColor grayColor];
    [cell.contentView addSubview:imageView];
    
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, kScreenWitdth*0.6, 24)];
    title.text = [NSString stringWithFormat:@"%@",_titleArr[indexPath.row]];
    [cell.contentView addSubview:title];
    
    
  
    
    return cell;
}

#pragma mark 选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            break;
        default:
            break;
    }
}

#pragma mark 重新布局--此处最后一条线的问题
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    // 设置需要的偏移量,这个UIEdgeInsets左右偏移量不要太大，不然会titleLabel也会便宜的。
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 10, 0, 0);
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) { // iOS8的方法
        if (indexPath.row == self.titleArr.count-1) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        } else {
            // 设置边界为0，默认是{8,8,8,8}
            [cell setLayoutMargins:inset];
        }
        
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        if (indexPath.row == self.titleArr.count-1) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        } else {
            [cell setSeparatorInset:inset];
        }
    }
}



@end
