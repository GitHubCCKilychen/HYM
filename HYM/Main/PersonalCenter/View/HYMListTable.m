//
//  HYMListTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMListTable.h"
#import "HYMGoDetailsVC.h"
@interface HYMListTable ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation HYMListTable

- (void)setSelection:(NSInteger)selection{

    _selection = selection;
    

}


- (instancetype)initWithFrame:(CGRect)frame{

    if (self =[super initWithFrame:frame] ) {
        
        
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
       cell.selectionStyle = UITableViewCellSelectionStyleNone;  
        UIImageView *storeImage = [[UIImageView alloc] init];
        storeImage.frame = CGRectMake(15, 15, 50,50);
        storeImage.tag = 1;
        storeImage.backgroundColor = [UIColor grayColor];
        [cell.contentView addSubview:storeImage];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(75, 15, kScreenWitdth*0.5, 50);
        label.tag = 2;
        label.font = [UIFont systemFontOfSize:15];
        label.numberOfLines = 0;
        [cell.contentView addSubview:label];
        
        UIButton *republish = [UIButton buttonWithType:UIButtonTypeCustom];
        //颜色值
        republish.backgroundColor = [UIColor colorWithRed:26/256.f green:197/256.f blue:82/256.f alpha:1];
        republish.frame = CGRectMake(kScreenWitdth-70, 15, 55, 20);
        republish.tag = 3;
        [republish setTitle:@"重新发布" forState:UIControlStateNormal];
        [republish setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        republish.titleLabel.textAlignment = NSTextAlignmentCenter;
        republish.titleLabel.font = [UIFont systemFontOfSize:12];
        [cell.contentView addSubview:republish];
        
        UIButton *shelves = [UIButton buttonWithType:UIButtonTypeCustom];
        shelves.frame = CGRectMake(kScreenWitdth-70, 45, 55, 20);
        shelves.backgroundColor = [UIColor lightGrayColor];
        shelves.tag = 4;
        [shelves setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [shelves setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [shelves setTitle:@"下架" forState:UIControlStateNormal];
        shelves.titleLabel.textAlignment = NSTextAlignmentCenter;
        shelves.titleLabel.font = [UIFont systemFontOfSize:12];
        [cell.contentView addSubview:shelves];
    }
    
    UIImageView *store = [cell.contentView viewWithTag:1];
    
    UILabel *title = [cell.contentView viewWithTag:2];
    title.text = @"1234567890lkjhgfdserdftghjkn";
    UIButton *republish = [cell.contentView viewWithTag:3];
    
    UIButton *shelves = [cell.contentView viewWithTag:4];
    
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (self.selection) {
        case 0:
            
            NSLog(@"------");
            break;
        case 1:
             NSLog(@"+++_");
            break;
        default:
            break;
    }
    
    HYMGoDetailsVC *goVC = [[HYMGoDetailsVC alloc] init];
    goVC.selection = self.selection;
    [self.viewController.navigationController pushViewController:goVC animated:YES];
}
@end
