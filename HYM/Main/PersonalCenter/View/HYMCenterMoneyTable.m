//
//  HYMCenterMoneyTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/31.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMCenterMoneyTable.h"
#import "HYMSecurityDeposit.h"
#import "HYMFreezeVC.h"
#import "HYMInfoVC.h"
@interface HYMCenterMoneyTable ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSArray *titleArr;
@end
@implementation HYMCenterMoneyTable

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        
        self.titleArr = @[@"个人信息",@"保证金",@"冻结推单备付金"];
        
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(15, 15, 1, 20);
        lineView.backgroundColor = [UIColor orangeColor];
        [cell.contentView addSubview:lineView];
        
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(15+10, 15, kScreenWitdth/2, 20);
        title.textColor = [UIColor orangeColor];
        title.font = [UIFont systemFontOfSize:15];
        title.text = self.titleArr[indexPath.section];
        [cell.contentView addSubview:title];
        
        UIButton *lookDetail = [UIButton buttonWithType:UIButtonTypeCustom];
        lookDetail.frame = CGRectMake(kScreenWitdth-100, 12, 80, 30);
        lookDetail.layer.cornerRadius = 3;
        lookDetail.layer.borderWidth = 1;
        lookDetail.tag = indexPath.section;
        lookDetail.layer.borderColor = [UIColor colorWithRed:44/255.f green:108/255.f blue:140/255.f alpha:1].CGColor;
        [lookDetail setTitle:@"查看详情" forState:UIControlStateNormal];
        [lookDetail setTitleColor:[UIColor colorWithRed:44/255.f green:108/255.f blue:140/255.f alpha:1] forState:UIControlStateNormal];
        lookDetail.titleLabel.font = [UIFont systemFontOfSize:16];
        [lookDetail addTarget:self action:@selector(lookDetails:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:lookDetail];
        
        
        if (indexPath.section == 0) {
            
            UILabel *name = [[UILabel alloc] init];
            name.frame = CGRectMake(15, 50, kScreenWitdth/2-15, 20);
            name.font = [UIFont systemFontOfSize:15];
            name.text = @"姓名:尚未填写真实";
            [cell.contentView addSubview:name];
            
            
            UILabel *phoneNum = [[UILabel alloc] init];
            phoneNum.frame = CGRectMake(kScreenWitdth/2, 50, kScreenWitdth/2, 20);
            phoneNum.text = @"手机号:13562012191";
            phoneNum.font = [UIFont systemFontOfSize:15];
            [cell.contentView addSubview:phoneNum];
            
        }else{
            
            UILabel *RNB = [[UILabel alloc] init];
            RNB.frame = CGRectMake(15, 50, kScreenWitdth/2, 20);
            RNB.font = [UIFont systemFontOfSize:15];
            RNB.text = @"人民币:1000.00元";
            [cell.contentView addSubview:RNB];
            
            
        }
        
        
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 15;
}

#pragma mark 查看详情
- (void)lookDetails:(UIButton *)btn{

    switch (btn.tag) {
        case 0:
        {
        
            HYMInfoVC *info = [[HYMInfoVC alloc] init];
            [self.viewController.navigationController pushViewController:info animated:YES];
        }
            break;
        case 1:
        {
            //暂时添加保证金页面
            HYMSecurityDeposit *security = [[HYMSecurityDeposit alloc] init];
            [self.viewController.navigationController pushViewController:security animated:YES];
            
        
        }
            break;
        case 2:
        {
   
        //冻结备付金
        HYMFreezeVC *freeVC = [[HYMFreezeVC alloc] init];
        [self.viewController.navigationController pushViewController:freeVC animated:YES];
        }
            break;
        default:
            break;
    }

    
}
@end
