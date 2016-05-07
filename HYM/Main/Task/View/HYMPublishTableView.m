//
//  HYMPublishTableView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/3.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPublishTableView.h"

@interface HYMPublishTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSArray *titleArr;
@property (nonatomic,strong)UITextField *textfield;
@property (nonatomic,strong)NSArray *otherArr;
@property (nonatomic,strong)NSArray *labelArr;
@end


@implementation HYMPublishTableView

-(NSArray *)titleArr{

    if (_titleArr == nil) {
        
        _titleArr = [NSArray array];
        _titleArr = @[@"投资本金",@"投资期限",@"投资收益",@"任务返利"];
    }
    return _titleArr;
}

- (NSArray *)otherArr{

    if (_otherArr == nil) {
        
        _otherArr = [NSArray array];
        _otherArr = @[@"任务有限期至",@"任务数量",@"任务链接",@"邀请码"];
    }
    
    return _otherArr;
}

- (NSArray *)labelArr{

    if (_labelArr == nil) {
        
        _labelArr = [NSArray  array];
        _labelArr = @[@"元",@"天",@"元",@"元"];
    }
    return _labelArr;
}


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self = [super initWithFrame:frame style:style]) {
     
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
    }
    
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 4;
    }else if (section == 1)
    {
        return 4;
    }

    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

//    cell.textLabel.font = [UIFont systemFontOfSize:15];
//
//
//    NSArray *timeArr = @[@"2013/3/15",@"2014/4/56"];
//    if (indexPath.row == 3) {
//        [self.textfield removeFromSuperview];
//        //开始时间－结束时间
//        for (int i = 0; i < 2; i++) {
//            
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn.frame = CGRectMake(140+(80*i+20)*i, 12, 80, 20);
//            [btn setTitle:timeArr[i] forState:UIControlStateNormal];
//            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//            btn.titleLabel.font = [UIFont systemFontOfSize:15];
//            [btn addTarget:self action:@selector(timeSelectedAct:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.contentView addSubview:btn];
//            UILabel *title = [[UILabel alloc] init];
//            title.frame = CGRectMake(220, 12, 20, 20);
//            title.text = @"至";
//            title.textAlignment = NSTextAlignmentCenter;
//            title.font = [UIFont systemFontOfSize:15];
//            [cell.contentView addSubview:title];
//        }
//        
//        
//    }
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.frame.size.width-25,12 , 20, 20)];
    [HYMTool initLabel:label withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
    
    self.textfield = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWitdth-130, 12, 100, 20)];
    self.textfield.backgroundColor = [UIColor orangeColor];
    self.textfield.textAlignment = NSTextAlignmentRight;

    
  
     cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (indexPath.section == 0) {
        
        cell.textLabel.text = self.titleArr[indexPath.row];
        label.text = self.labelArr[indexPath.row];
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:self.textfield];
        
    }else if (indexPath.section == 1 ){
    
        cell.textLabel.text = self.otherArr [indexPath.row];

        
        if (indexPath.row == 0) {
            self.textfield.frame = CGRectMake(kScreenWitdth-110, 12, 100, 20);
            [cell.contentView addSubview:self.textfield];
        }else if (indexPath.row == 1){
        
            label.text = @"个";
            [cell.contentView addSubview:label];
            self.textfield.frame = self.textfield.frame = CGRectMake(kScreenWitdth-130, 12, 100, 20);
            [cell.contentView addSubview:self.textfield];
            
        }else if (indexPath.row == 2){
        
            self.textfield.frame = self.textfield.frame = CGRectMake(kScreenWitdth/2-kScreenWitdth/4, 12, cell.contentView.frame.size.width - 80, 20);
            [cell.contentView addSubview:self.textfield];
        }else{
        
            self.textfield.frame = self.textfield.frame = CGRectMake(kScreenWitdth-110, 12, 100, 20);
            self.textfield.backgroundColor = [UIColor grayColor];
            [cell.contentView addSubview:self.textfield];
        }
        
    }else{
        
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(15, 15, 80, 20);
        title.text = @"所需备付金";
        [HYMTool initLabel:title withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
        [cell.contentView addSubview:title];
    
        
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(15, 40, kScreenWitdth-30, 50);
        view.layer.borderColor = [UIColor brownColor].CGColor;
        view.layer.borderWidth = 0.8;
        label.frame = CGRectMake(10, 0, view.frame.size.width-20, 50);
        label.text = @"说明:备付金为任何返利和退单费用的合计，备付金为任何返利和退单费用的合计";
        [HYMTool initLabel:label withFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor lightGrayColor] withTextAlignment:NSTextAlignmentLeft];
        label.numberOfLines = 0;
        [view addSubview:label];
        [cell.contentView addSubview:view];
       
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
        
        return 100;
    }
  

    return 44.0f;
}

#pragma mark 时间选择
- (void)timeSelectedAct:(UIButton *)timeSelected{

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 2) {
        return 0.001;
    }

    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10;
}
@end
