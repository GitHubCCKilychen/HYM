//
//  HYMPushSingleCell.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/9.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPushSingleCell.h"
#define textColor [UIColor colorWithRed:251/256.f green:149/256.f blue:89/256.f alpha:1]
#import "HYMUploadTask.h"
@implementation HYMPushSingleCell

- (UIView *)lineView{

    if (_lineView == nil) {
        
        _lineView = [[UIView alloc] init];
        
        _lineView.backgroundColor = [UIColor colorWithRed:251/256.f green:149/256.f blue:89/256.f alpha:1];
    }
    return _lineView;
}


- (UIView *)centerView{

    if (_centerView == nil) {
        
        _centerView = [[UIView alloc] init];
        _centerView.layer.borderColor = [UIColor brownColor].CGColor;
        _centerView.layer.borderWidth = 1;
        
    }
    return _centerView;
}

- (UILabel *)connetTitle{

    if (_connetTitle == nil) {
        
        _connetTitle = [[UILabel alloc] init];
        _connetTitle.text = @"发布任务专区,成交付费";
        [HYMTool initLabel:_connetTitle withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _connetTitle;
}

- (UILabel *)connect{

    if (_connect == nil) {
        
        _connect = [[UILabel alloc] init];
        _connect.text = @"“寻寻觅觅，原来小白都在这里”……";
        [HYMTool initLabel:_connect withFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor grayColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _connect;
}

- (UIButton *)detailBtn{

    if (_detailBtn == nil) {
        
        _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_detailBtn setTitle:@"详情" forState:UIControlStateNormal];
        [_detailBtn setTitleColor:textColor forState:UIControlStateNormal];
        _detailBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _detailBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _detailBtn;
}

- (UIButton *)rightBtn{

    if (_rightBtn == nil) {
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.backgroundColor = [UIColor orangeColor];
        NSString *string = @"我要推单赚钱";
        [_rightBtn setTitle:string forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        
    }
    return _rightBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [ super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        [self initWithView];
        
    }
    return self;
}

- (void)initWithView{

    [self.contentView addSubview:self.lineView];
 
    self.lineView.sd_layout
    .leftSpaceToView(self.contentView,20).topSpaceToView(self.contentView,10)
    .widthIs(1).heightIs(18);
    
    
    
}
- (void)initCell1{

    [self.contentView addSubview:self.centerView];
    [self.centerView addSubview:self.connetTitle];
    [self.centerView addSubview:self.connect];
    [self.centerView addSubview:self.detailBtn];
    [self.contentView addSubview:self.rightBtn];
    
    
    self.centerView.backgroundColor = [UIColor whiteColor];
    self.centerView.sd_layout
    .leftSpaceToView(self.contentView,20).bottomSpaceToView(self.contentView,10)
    .topSpaceToView(self.lineView,10).widthIs(kScreenWitdth- 100);
    
    self.connetTitle.sd_layout
    .leftSpaceToView(self.centerView,8).topSpaceToView(self.centerView,8)
    .heightIs(15).widthIs(self.contentView.frame.size.width-20);
    
    
    self.connect.sd_layout
    .leftSpaceToView(self.centerView,2).bottomSpaceToView(self.centerView,3)
    .heightIs(15).widthIs(self.centerView.frame.size.width-35);
    
    
    self.detailBtn.sd_layout
    .rightSpaceToView(self.centerView,0).bottomSpaceToView(self.centerView,3)
    .heightIs(15).widthIs(40);
    
    self.rightBtn.sd_layout
    .leftSpaceToView(self.centerView,5).bottomSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,10).topSpaceToView(self.lineView,10);
    
}
- (void)initCell2{

    NSArray *titleArr = @[@"待付款",@"待发货",@"待收货",@"待评价",@"退货/售后"];
    
    for (int i = 0; i < 5; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15+i*kScreenWitdth/6+i*10, 35, 30, 30);
        btn.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:btn];
        
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(10+i*kScreenWitdth/6+i*10, 60, 60, 30);
        title.text = titleArr[i];
        [HYMTool initLabel:title withFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:title];
    }
    
}

//登录之后，
- (void)loginBtn{
    
     NSArray *titleArr = @[@"上传",@"发布",@"审核报单",@"推单列表",@"中心资产"];

    for (int i = 0; i < 5; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15+i*kScreenWitdth/6+i*10, 35, 30, 30);
        btn.backgroundColor = [UIColor grayColor];
        btn.tag = i;
        [btn addTarget:self action:@selector(buttonAct:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(10+i*kScreenWitdth/6+i*10, 60, 60, 30);
        title.text = titleArr[i];
        [HYMTool initLabel:title withFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:title];
        
    }
    
}

- (void)buttonAct:(UIButton *)btn{

    
    switch (btn.tag ) {
        case 0:
            
        {
            HYMUploadTask *uploadTask = [[HYMUploadTask alloc] init];
            uploadTask.hidesBottomBarWhenPushed = YES;
            [self.viewController.navigationController pushViewController:uploadTask animated:YES];
        }
            
            break;
        case 1:
            break;
        default:
            break;
    }
    
}
@end
