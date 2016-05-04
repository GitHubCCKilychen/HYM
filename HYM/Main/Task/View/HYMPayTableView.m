//
//  HYMPayTableView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/3.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPayTableView.h"

@interface HYMPayTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSArray *titleArr;
@property (nonatomic,strong)UITextField *textFiled;
@property (nonatomic,strong)NSArray *payArr;
@end
@implementation HYMPayTableView

-(NSArray *)titleArr{

    if (_titleArr == nil) {
        
        _titleArr = [NSArray array];
        _titleArr = @[@"任务总数",@"单项任务金额",@"总任务金额"];
    }
    return _titleArr;
}

- (NSArray *)payArr{

    if (_payArr == nil) {
        
        _payArr = [NSArray  array];
        _payArr = @[@"支付宝",@"微信",@"银联"];
    }
    return _payArr;
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        
    }
    return self;
}

#pragma mark datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 3;
    }else if (section == 1){
    
        return 2;
    }

    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (indexPath.section == 0) {
        
        cell.textLabel.text = self.titleArr[indexPath.row];

            
            self.textFiled = [[UITextField alloc] init];
            self.textFiled.frame = CGRectMake(kScreenWitdth-90, 7, 80, 30);
            self.textFiled.backgroundColor = [UIColor grayColor];
            self.textFiled.font = [UIFont systemFontOfSize:15];
            [cell.contentView addSubview:self.textFiled];
        
    }else if (indexPath.section == 1){
    
        if (indexPath.section == 1 && indexPath.row == 0) {
            
            cell.textLabel.text = @"预付须知";
        }else{
        
            cell.textLabel.text = @"1.预付须知预付须知预付须知预付须知 \n2.详情咨询：0531-885156989";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:12];
            cell.textLabel.numberOfLines = 0;
        }
        
    
    }else if(indexPath.section == 2){
    
        UIImageView *iconImage = [[UIImageView alloc] init];
        iconImage.frame = CGRectMake(15, 10, 40, 40);
        iconImage.backgroundColor = [UIColor grayColor];

        [cell.contentView addSubview:iconImage];
        
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(65, 20, 90, 20);
        title.text = self.payArr[indexPath.row];
        title.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:title];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(cell.contentView.frame.size.width-50, 20, 20, 20);
        btn.backgroundColor = [UIColor grayColor];
        btn.tag = indexPath.row;
        [btn addTarget:self action:@selector(selectPayStyle:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn];
        
    }
    
    
    return cell;
}

#pragma mark 选择支付
- (void)selectPayStyle:(UIButton *)payStytle{

    //选择当前的cell设置当前的cell为选中状态
    
    
}

#pragma mark delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return 0;
    }
    
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1 && indexPath.row == 1) {
        
        return 60;
        
    }else if (indexPath.section == 2){
    
        return 60;
        
    }
    
    return 44.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
@end
