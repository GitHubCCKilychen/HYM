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
@end

@implementation HYMPublishTableView

-(NSArray *)titleArr{

    if (_titleArr == nil) {
        
        _titleArr = [NSArray array];
        _titleArr = @[@"投资本金",@"投资期限",@"投资收益",@"任务返利"];
    }
    return _titleArr;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
     
        self.dataSource = self;
        self.delegate = self;
        
        self.showsVerticalScrollIndicator = NO;
    }
    
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 5;
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
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
////    cell.textLabel.text = self.titleArr[indexPath.row];
//    cell.textLabel.font = [UIFont systemFontOfSize:15];
//    self.textfield = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWitdth-120, 12, 100, 20)];
////    self.textfield.backgroundColor = [UIColor orangeColor];
//    self.textfield.textAlignment = NSTextAlignmentRight;
//    [cell.contentView addSubview:self.textfield];
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
//    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44.0f;
}

#pragma mark 时间选择
- (void)timeSelectedAct:(UIButton *)timeSelected{

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}
@end
