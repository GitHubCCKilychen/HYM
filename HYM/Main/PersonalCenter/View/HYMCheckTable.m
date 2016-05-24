//
//  HYMCheckTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMCheckTable.h"
#import "HYMFormDetails.h"
@interface HYMCheckTable ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation HYMCheckTable


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self = [super initWithFrame:frame style:style]) {
        
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
        
        UIImageView *storeImage = [[UIImageView alloc] init];
        storeImage.frame = CGRectMake(15, 15, 50,50);
        storeImage.tag = 1;
        storeImage.backgroundColor = [UIColor grayColor];
        [cell.contentView addSubview:storeImage];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(75, 15, kScreenWitdth*0.6, 50);
        label.tag = 2;
        label.font = [UIFont systemFontOfSize:15];
        label.numberOfLines = 0;
        [cell.contentView addSubview:label];
        
        
        UILabel *count = [[UILabel alloc] init];
        count.frame = CGRectMake(kScreenWitdth-15-25, 20, 25, 15);
        count.backgroundColor = [UIColor redColor];
        count.layer.cornerRadius = 8;
        count.layer.masksToBounds = YES;
        [HYMTool initLabel:count withFont:[UIFont systemFontOfSize:10] withTextColor:[UIColor whiteColor] withTextAlignment:NSTextAlignmentCenter];
        count.tag = 3;
        [cell.contentView addSubview:count];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kScreenWitdth-15-40, 40, 40, 20);
        btn.tag = 3;
        [btn setTitle:@"报单详情" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        btn.backgroundColor = [UIColor colorWithRed:45/256.f green:154/256.f blue:252/256.f alpha:1];
        [btn addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:btn];
        
    }
    
    UIImageView *store = [cell.contentView viewWithTag:1];
//    store.image = [UIImage imageNamed:];
    
    UILabel *title = [cell.contentView viewWithTag:2];
    title.text = @"234456787bvcbnmvnmbn,kkn,m";
    
    UILabel *coutn = [cell.contentView viewWithTag:3];
    coutn.text = @"1个";
    
    UIButton *btn = [cell.contentView viewWithTag:4];
    btn.backgroundColor = [UIColor greenColor];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        
        return 15;
    }
    return 0.001;
}

#pragma mark 报单详情事件 
- (void)btnAct:(UIButton *)btn{

    HYMFormDetails *form = [[HYMFormDetails alloc] init];
    [self.viewController.navigationController pushViewController:form animated:YES];
    

    
    
}
@end
