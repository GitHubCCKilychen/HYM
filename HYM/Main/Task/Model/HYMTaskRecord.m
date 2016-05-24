//
//  HYMTaskRecord.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/28.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTaskRecord.h"
#import "HYMTaskDeailsCell.h"
#import "HYMTaskDeailsTableView.h"
@interface HYMTaskRecord ()


@end
@implementation HYMTaskRecord

#pragma mark 懒加载

- (UIView *)backView{

    if (_backView == nil) {
        
        _backView = [[UIView alloc] init];
    }
    return _backView;

}
- (UIView *)lineView{

    if (_lineView == nil) {
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor =  [UIColor orangeColor];
        _lineView.layer.cornerRadius = 4;
    }
    return _lineView;
}

- (UILabel *)taskRecord{

    if (_taskRecord == nil) {
        
        _taskRecord = [[UILabel alloc] init];
        _taskRecord.text = @"任务流程";
        [HYMTool initLabel:_taskRecord withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _taskRecord;
}

- (UIImageView *)imageView{

    if (_imageView == nil) {
        
        _imageView = [[UIImageView alloc] init];
        
        _imageView.image = [UIImage imageNamed:@"任务进度"];
    }
    return _imageView;
}


- (UILabel *)moreContent{

    if (_moreContent == nil) {
        
        _moreContent = [[UILabel alloc] init];
        _moreContent.text = @"若有多项报单，请直接联系客服";
        [HYMTool initLabel:_moreContent withFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor lightGrayColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _moreContent;
}

- (UILabel *)officeNumber{

    if (_officeNumber == nil) {
        
        _officeNumber = [[UILabel alloc] init];
        _officeNumber.text = @"点击链接官方客服：";
        [HYMTool initLabel:_officeNumber withFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor lightGrayColor] withTextAlignment:NSTextAlignmentLeft];
        
    }
    return _officeNumber;
}

- (UIView *)userline{

    if (_userline == nil) {
        
        _userline = [[UIView alloc] init];
        _userline.backgroundColor = [UIColor orangeColor];
        _userline.layer.cornerRadius = 4;
    }
    return _userline;
}

-(UILabel *)userEvaluation{

    if (_userEvaluation == nil) {
        
        _userEvaluation = [[UILabel alloc] init];
        _userEvaluation.text = @"用户介绍";
        [HYMTool initLabel:_userEvaluation withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _userEvaluation;
}
- (UIButton *)chatBtn{

    if (_chatBtn == nil) {
        
        _chatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _chatBtn.backgroundColor = [UIColor grayColor];
    }
    
    return _chatBtn;
}

#pragma mark --
- (void)setNewIndex:(int)newIndex{

    _newIndex = newIndex;
    
    
    NSArray *titleArr = @[@"参与",@"报单",@"审核",@"完成"];
    NSArray *titleNewArr = @[@"参与",@"记账"];
    if (_newIndex == 2) {
        
        for (int i = 0 ; i < titleNewArr.count; i++) {
            
            UILabel *title = [[UILabel alloc] init];
            title.frame = CGRectMake((kScreenWitdth-150)/2+i*40+i*75, 85, 40, 20);
            title.text = titleArr[i];
            title.font = [UIFont systemFontOfSize:14];
            title.textAlignment = NSTextAlignmentCenter;
            
            if (i > 1) {
                
                title.textColor = [UIColor lightGrayColor];
            }
            [self addSubview:title];
        }
    }else{
    
        for (int i = 0 ; i < titleArr.count; i++) {
            
            UILabel *title = [[UILabel alloc] init];
            title.frame = CGRectMake((kScreenWitdth-235)/2+i*40+i*28, 85, 40, 20);
            title.text = titleArr[i];
            title.font = [UIFont systemFontOfSize:14];
            title.textAlignment = NSTextAlignmentCenter;
            
            if (i > 1) {
                
                title.textColor = [UIColor lightGrayColor];
            }
            [self addSubview:title];
        }
    }
    
    
    if (_newIndex == 2) {
        
        self.taskRecord.text = @"新手单任务进度";
        
        self.imageView.image = [UIImage imageNamed:@"新手单"];
        
        self.imageView.sd_layout
        .leftSpaceToView(self,(kScreenWitdth-150)/2).rightSpaceToView(self,(kScreenWitdth-150)/2).widthIs(150)
        .heightIs(25).topSpaceToView(self.lineView,20);
        
        
    }
    
    
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        [self initWithView];
        [self initWithBtn];
    }
    
    return self;
}

#pragma mark view
- (void)initWithView{

    
    [self addSubview:self.lineView];
    [self addSubview:self.taskRecord];
    [self addSubview:self.imageView];
    [self addSubview:self.backView];
    [self addSubview:self.moreContent];
    [self addSubview:self.officeNumber];
    
    [self addSubview:self.userline];
    [self addSubview:self.userEvaluation];

    [self addSubview:self.chatBtn];
    
    self.lineView.sd_layout
    .leftSpaceToView(self,15).topSpaceToView(self,10)
    .widthIs(8).heightIs(20);
    
//    self.taskRecord.backgroundColor = [UIColor orangeColor];
    self.taskRecord.sd_layout
    .leftSpaceToView(self.lineView,10).topSpaceToView(self,10)
    .widthIs(kScreenWitdth/2).heightIs(20);
    
    

    self.imageView.sd_layout
    .leftSpaceToView(self,(kScreenWitdth-235)/2).rightSpaceToView(self,(kScreenWitdth-235)/2)
    .topSpaceToView(self.lineView,20).heightIs(22.5).widthIs(235);
    
    self.backView.backgroundColor = [UIColor colorWithRed:235/255.f green:235/255.f blue:235/255.f alpha:1];
    self.backView.sd_layout
    .leftSpaceToView(self,0).rightSpaceToView(self,0)
    .topSpaceToView(self,120).heightIs(55);
    
    self.moreContent.sd_layout
    .leftSpaceToView(self,20).topSpaceToView(self.imageView,50)
    .heightIs(20).widthRatioToView(self,0.6);
    
//    self.officeNumber.backgroundColor =[UIColor brownColor];
    self.officeNumber.sd_layout
    .leftSpaceToView(self,20).topSpaceToView(self.moreContent,5)
    .widthRatioToView(self,0.4).heightIs(20);
    
    
    self.userline.sd_layout
    .leftSpaceToView(self,15).topSpaceToView(self.officeNumber,20)
    .heightIs(20).widthIs(8);
    
    self.userEvaluation.sd_layout
    .leftSpaceToView(self.userline,10).topEqualToView(self.userline)
    .heightIs(20).widthIs(80);
   
    self.chatBtn.sd_layout
    .leftSpaceToView(self.officeNumber,2).topSpaceToView(self.moreContent,5)
    .widthIs(30).heightIs(20);
    
   
}

#pragma mark 转发评论
- (void)initWithBtn{
    
    NSString *forward = [NSString stringWithFormat:@"时间"];
    NSString *comment = [NSString stringWithFormat:@"评论量"];
    NSString *zanCount = [NSString stringWithFormat:@"点赞量"];
    NSArray *title = @[forward,comment,zanCount];
    for (int i = 0; i < title.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15+i*60,250-40, 60, 40);
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:title[i] forState:UIControlStateNormal];
        [self addSubview:btn];
    }
    
}


#pragma mark 点击复制事件
- (void)websiteAct:(UITapGestureRecognizer *)tap{

    if (tap.state == UIGestureRecognizerStateRecognized &&
        [tap.view isKindOfClass:[UILabel class]]) {
        
        UILabel *someLabel = (UILabel *)tap.view;
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:someLabel.text];
    }
    
}

#pragma mark 长按复制
- (void)textLongAct:(UILongPressGestureRecognizer *)longGes{

    if (longGes.state == UIGestureRecognizerStateRecognized &&
        [longGes.view isKindOfClass:[UILabel class]])
    {
        UILabel *someLabel = (UILabel *)longGes.view;
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:someLabel.text];
        
    }
    
}
#pragma mark 用户评价事件
- (void)btnAct:(UIButton *)btn{

    
    
    switch (btn.tag) {
        case 0:
            
            break;
        case 1:
            
            //评论量
             [self commentData];
            break;
        case 2:
            
            //获取点赞数据
            [self zanData];
            break;
        default:
            break;
            
    }
    
 
   
   
    
  
}


#pragma mark 任务ID
- (void)setIndex:(int)index{

    _index = index;
    
   
}
- (void)zanData{
    
    NSString *indexString = [NSString stringWithFormat:@"%d",self.index];

    NSDictionary *dic = @{@"keytype":@"6",@"keyid":indexString,@"oper":@"1",@"token":@"1"};
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    //网络请求
    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/v203/follow_collect_operator" target:self selector:@selector(zanData:) parameter:infoDic];
}

- (void)zanData:(NSDictionary *)dic{

    
    /**
     *      infor = "<null>";
            msg = "\U64cd\U4f5c\U6210\U529f\Uff01";
            success = 1;
     */
    NSLog(@"%@",dic);
}

#pragma mark 评论
- (void)commentData{

    NSString *indexString = [NSString stringWithFormat:@"%d",self.index];
    
    NSDictionary *dic = @{@"id":indexString,@"type":@"1",@"parentid":@"1",@"token":@"1",@"content":@"1234"};
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    //网络请求
    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/task/comment_operate" target:self selector:@selector(commentData:) parameter:infoDic];
}

- (void)commentData:(NSDictionary *)dic{

    NSLog(@"%@- %@",dic,[dic objectForKey:@"msg"]);
    
}
@end
