//
//  HYMPushSingleCell.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/9.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPushSingleCell.h"
#import "HYMCheckForm.h"
#import "HYMListVC.h"
#import "HYMLunTanJoinVC.h"
#import "HYMMyOrderVC.h"
#import "HYMSystemMessageVC.h"
#import "HYMCenterAssets.h"
#import "HYMFormList.h"
#import "HYMSecurityDeposit.h"//暂时引入
#import "HYMFreezeVC.h"
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
        _centerView.layer.borderColor = [UIColor colorWithRed:165/256.f green:117/256.f blue:86/256.f alpha:1].CGColor;
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
        [_rightBtn addTarget:self action:@selector(makeMoney:) forControlEvents:UIControlEventTouchUpInside];
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
    .leftSpaceToView(self.contentView,15).bottomSpaceToView(self.contentView,10)
    .topSpaceToView(self.lineView,10).widthIs(kScreenWitdth- 100);
    
    self.connetTitle.sd_layout
    .leftSpaceToView(self.centerView,5).topSpaceToView(self.centerView,5)
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
    
    CGFloat margin = 30;
    CGFloat btnWidht = (kScreenWitdth-170)/5;
    
    CGFloat labelWidth = kScreenWitdth/5;
//    CGFloat labelMargin = 20;
    
    for (int i = 0; i < 5; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(25+i*margin+i*btnWidht, 35, btnWidht                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             , 30);
        btn.backgroundColor = [UIColor grayColor];
        btn.tag = i;
        [btn addTarget:self action:@selector(shopAct:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(0+i*labelWidth+i*0, 65, labelWidth                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             , 20);//字体居中
        title.text = titleArr[i];
        [HYMTool initLabel:title withFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentCenter];
//        if (i == 4) {
//            title.frame = CGRectMake(25+i*labelMargin+i*labelWidth, 65, 65                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            , 20);
//            title.textAlignment = NSTextAlignmentCenter;
//        }
        [self.contentView addSubview:title];
    }
    
}

//登录之后，
- (void)loginBtn{
    
     NSArray *titleArr = @[@"上传",@"发布",@"审核报单",@"推单列表",@"中心资产"];

    CGFloat margin = 30;
    CGFloat btnWidht = (kScreenWitdth-170)/5;
    
    CGFloat labelWidth = kScreenWitdth/5;
    
    for (int i = 0; i < titleArr.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(25+i*margin+i*btnWidht, 35, btnWidht                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             , 30);
        btn.backgroundColor = [UIColor grayColor];
        btn.tag = i;
        [btn addTarget:self action:@selector(buttonAct:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(i*labelWidth+i*0, 60, labelWidth                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             , 30);
        title.text = titleArr[i];
        [HYMTool initLabel:title withFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:title];
        
    }
    
}
//推单店铺
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
        case 2:
        {
            HYMCheckForm *check = [[HYMCheckForm alloc] init];
            [self.viewController.navigationController pushViewController:check animated:YES];
        
        }   break;
        case 3:{
        
            HYMListVC *list = [[HYMListVC alloc] init];
            [self.viewController.navigationController pushViewController:list animated:YES];
            
        }break;
        case 4:
        
        {
        
//            HYMCenterAssets *message = [[HYMCenterAssets alloc] init];
//            [self.viewController.navigationController pushViewController:message animated:YES];
            
            //暂时添加保证金页面
//            HYMSecurityDeposit *security = [[HYMSecurityDeposit alloc] init];
//            [self.viewController.navigationController pushViewController:security animated:YES];
            
//            //冻结备付金
            HYMFreezeVC *freeVC = [[HYMFreezeVC alloc] init];
            [self.viewController.navigationController pushViewController:freeVC animated:YES];
        }
        default:
            break;   
    }
    
}

#pragma mark 全部待付款－评价－－
- (void)shopAct:(UIButton *)btn{

    
//    NSLog(@"++_%ld",(long)btn.tag);
    HYMMyOrderVC *order = [[HYMMyOrderVC alloc] init];
    order.index = btn.tag;
    [self.viewController.navigationController pushViewController:order animated:YES];

}


#pragma mark 我要推单赚钱
- (void)makeMoney:(UIButton *)btn{

    HYMFormList *list = [[HYMFormList alloc] init];
    [self.viewController.navigationController pushViewController:list animated:YES];
    
}
@end
