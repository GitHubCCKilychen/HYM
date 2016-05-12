//
//  HYMWoolletterView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/7.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMWoolletterView.h"

@interface HYMWoolletterView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@end

@implementation HYMWoolletterView

- (UITableView *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, kScreenWitdth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    
    return _tableView;
}


- (id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self initWithView];
        
    }
    return self;
}

- (void)initWithView{

    [self addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 1;
    }

    
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell ) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else{
        
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    UIImageView *iconImage = [[UIImageView alloc] init];
    iconImage.frame = CGRectMake(15, 7.5, 42.5, 42.5);
    [cell.contentView addSubview:iconImage];
    
    UILabel *name = [[UILabel alloc] init];
    name.frame = CGRectMake(70, 10, kScreenWitdth/2, 20);
    [cell.contentView addSubview:name];
    
    UILabel *connent = [[UILabel alloc] init];
    connent.frame = CGRectMake(70, 30, kScreenWitdth/2, 20);
    [HYMTool initLabel:connent withFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor grayColor] withTextAlignment:NSTextAlignmentLeft];
    [cell.contentView addSubview:connent];
    
    UILabel *time = [[UILabel alloc] init];
    time.frame = CGRectMake(cell.contentView.frame.size.width-50, 13, 50, 20);
    time.text = @"昨天";
    [HYMTool initLabel:time withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor grayColor] withTextAlignment:NSTextAlignmentLeft];
    
    
    if (indexPath.section == 0) {
         iconImage.image = [UIImage imageNamed:@"bbb"];
        name.text = @"我的私人客服";
        name.textColor = [UIColor orangeColor];
        name.font = [UIFont systemFontOfSize:16];
        
        connent.text = @"您好,有什么能帮助到您的？";
    }else{
    
         iconImage.image = [UIImage imageNamed:@"aaa"];
        name.text = @"青青的小草";
        name.textColor = [UIColor blackColor];
        name.font = [UIFont systemFontOfSize:15];
        
        connent.text = @"今天干什么去";
        [cell.contentView addSubview:time];
    }
    
    return cell;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        return 0.001;
    }

    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    

    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 57.5;
}
@end
