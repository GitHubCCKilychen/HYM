//
//  HYMPublishTableView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/3.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPublishTableView.h"
#import "HYMPublishBottomView.h"
@interface HYMPublishTableView ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWitdth-30,12 , 20, 20)];
        label.tag = 1;
        [HYMTool initLabel:label withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
        
        UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWitdth-130,10, 100, 30)];
        textfield.delegate = self;
        [textfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
        textfield.tag = indexPath.row;

       textfield.textAlignment = NSTextAlignmentRight;
       textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        if (indexPath.section == 0) {
            
            cell.textLabel.text = self.titleArr[indexPath.row];
            label.text = self.labelArr[indexPath.row];
            label.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:label];
            [cell.contentView addSubview:textfield];
            
        }else if (indexPath.section == 1 ){
            
            cell.textLabel.text = self.otherArr [indexPath.row];
            
            
            if (indexPath.row == 0) {
                textfield.frame = CGRectMake(kScreenWitdth-110, 6, 100, 30);
                [cell.contentView addSubview:textfield];
            }else if (indexPath.row == 1){
                
                label.text = @"个";
                [cell.contentView addSubview:label];
                textfield.frame  = CGRectMake(kScreenWitdth-130, 6, 100, 30);
                [cell.contentView addSubview:textfield];
                
            }else if (indexPath.row == 2){
                
                textfield.frame = self.textfield.frame = CGRectMake(kScreenWitdth/2-kScreenWitdth/4, 6, cell.contentView.frame.size.width - 80, 30);
                [cell.contentView addSubview:textfield];
            }else{
                
                textfield.frame = textfield.frame = CGRectMake(kScreenWitdth-110, 6, 100, 30);
        
                [cell.contentView addSubview:textfield];
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
    }
    
    //输入数据

    
    
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

#pragma mark 代理实现
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//
//
//    [UIView beginAnimations:@"scrollView" context:nil];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationCurve:0.275f];
//    self.frame = CGRectMake(self.frame.origin.x, 0 , self.frame.size.width, self.frame.size.height);
//    [UIView commitAnimations];
//    
//    return YES;
//}
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//
//    CGFloat keyboardHeight = 216.0f;
//    if(self.frame.size.height - keyboardHeight > textField.frame.origin.y + textField.frame.size.height){
//        
//    }
//    else{
//        CGFloat moveHeight = textField.frame.origin.y - (self.frame.size.height - keyboardHeight - textField.frame.size.height);
//        [UIView beginAnimations:@"scrollView" context:nil];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [UIView setAnimationDuration:0.275f];
//        self.frame = CGRectMake(self.frame.origin.x, -moveHeight, self.frame.size.width, self.frame.size.height);
//        [UIView commitAnimations];
//    }
//    
//}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}

- (void) textFieldDidChange:(UITextField *) textField{
    
    HYMPublishBottomView *bottom = [[HYMPublishBottomView alloc] init];
    bottom.textFiled2 = textField;
    switch (textField.tag) {
        case 0:
            //通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeValue1" object:textField];
            break;
        case 1:
            //通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeValue1" object:textField];
            break;
        case 2:
            //通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeValue1" object:textField];
            break;
        default:
            break;
    }
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
}
@end
