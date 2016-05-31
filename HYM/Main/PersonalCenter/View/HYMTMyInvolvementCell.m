//
//  HYMTMyInvolvementCell.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/9.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTMyInvolvementCell.h"
#import "HYMLunTanJoinVC.h"
#import "HYMNeedHelp.h"
@implementation HYMTMyInvolvementCell

- (UIView *)lineView{
    
    if (_lineView == nil) {
        
        _lineView = [[UIView alloc] init];
        
        _lineView.backgroundColor = [UIColor colorWithRed:251/256.f green:149/256.f blue:89/256.f alpha:1];
    }
    return _lineView;
}


- (UILabel *)title{

    if (_title == nil) {
        
        _title = [[UILabel alloc] init];
        _title.text = @"我的参与";
        [HYMTool initLabel:_title withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _title;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [ super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
   
        [self initWithView];
    }
    return self;
}

- (void)initWithView{

    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.title];
    self.lineView.sd_layout
    .leftSpaceToView(self.contentView,20).topSpaceToView(self.contentView,10)
    .widthIs(1).heightIs(18);
    
    self.title.sd_layout
    .leftSpaceToView(self.lineView,5).topEqualToView(self.lineView)
    .widthIs(100).heightIs(20);
    
    CGFloat btnWidth = (kScreenWitdth -(42 *2 + 85*2))/3;
//    CGFloat labelWidth = (kScreenWitdth- (30*2+60*2))/3;
    CGFloat labelWidth = kScreenWitdth/3;
   
    NSArray *titleArr = @[@"论坛参与",@"我的足迹",@"需要帮助"];
    NSArray *imgArr = @[@"参与－1",@"参与－2",@"参与－3"];
    for (int i = 0; i < titleArr.count; i++) {
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(42 + i*btnWidth+i*85, 45, btnWidth, 30);
        btn.tag = i;
        [btn addTarget:self action:@selector(joinAct:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
//        btn.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:btn];
        
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(i*labelWidth, 70, labelWidth, 30);
        title.text = titleArr[i];
        [HYMTool initLabel:title withFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:title];
        
        if (i < 2) {
            
            UIView *lineView = [[UIView alloc] init];
            lineView.frame = CGRectMake(i*(kScreenWitdth/3-0.5)+(kScreenWitdth/3-0.5), 45, 1, 40);
            lineView.backgroundColor = [UIColor grayColor];
            [self.contentView addSubview:lineView];
        }
        
       
    }
}

#pragma mark 我的参与
- (void)joinAct:(UIButton *)btn{
    
    
    //NSLog(@"%ld",(long)btn.tag);
    switch (btn.tag) {
        case 0:
            
        {
            HYMLunTanJoinVC *joinVC = [[HYMLunTanJoinVC alloc] init];
            [self.viewController.navigationController pushViewController:joinVC animated:YES];
        }
            break;
        case 1:
            break;
        case 2:
        {
            HYMNeedHelp *needHelp = [[HYMNeedHelp alloc] init];
            needHelp.indexString = @"4";
            [self.viewController.navigationController pushViewController:needHelp animated:YES];
        }
            break;
        default:
            break;
    }
    
    
}
@end
