//
//  HYMPostedTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPostedTable.h"

@interface HYMPostedTable ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong)NSArray *dataList;
@end
@implementation HYMPostedTable

-(NSArray *)dataList{

    if (_dataList == nil) {
        
        _dataList = [NSArray array];
    }
    return _dataList;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

   
    
    if (section == 0) {
        return 3;
    }else if (section == 1){
    
        return 2;
    }
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        
        
        //选中不变色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        NSArray *title = @[@"任务总数",@"本次推单所需备付金",@"账户余额"];
        if (indexPath.section == 0) {
            
            //label
            UILabel *rightLabel = [[UILabel alloc] init];
            rightLabel.frame = CGRectMake(kScreenWitdth-70, cell.contentView.frame.size.height/2-12, 55, 24);
            rightLabel.tag = 1;
            rightLabel.font = [UIFont systemFontOfSize:15];
            rightLabel.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:rightLabel];
            
            cell.textLabel.text = title[indexPath.row];
            
            if (indexPath.row == 2) {
                cell.textLabel.textColor = [UIColor grayColor];
                rightLabel.textColor = [UIColor grayColor];
            }else if (indexPath.row == 1)
            {
                rightLabel.textColor = [UIColor orangeColor];
                
            }
        }else if (indexPath.section == 1 ){
        
            if (indexPath.row == 0) {
                cell.textLabel.text = @"备付金须知";
            }else{
            
                for (int i = 0; i < 2; i++) {
                    
                    UILabel *label = [[UILabel alloc] init];
                    label.frame = CGRectMake(15, 10+i*20+i*3, kScreenWitdth-10, 20);
                    label.tag = i+102;
                    [HYMTool initLabel:label withFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor grayColor] withTextAlignment:NSTextAlignmentLeft];
                    [cell.contentView addSubview:label];
                }
            }
            
            
           
        }else if (indexPath.section == 2){
        
                if(indexPath.row == 0){
            
                cell.imageView.image = [UIImage imageNamed:@"bbb"];
                cell.textLabel.text = @"修改任务数";
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(kScreenWitdth-50, (55-25)/2, 35, 25);
                [btn setTitle:@"修改" forState:UIControlStateNormal];
                [btn setTitleColor:TextColor forState:UIControlStateNormal];
                btn.titleLabel.textAlignment = NSTextAlignmentRight;
                btn.tag = 10;
                btn.titleLabel.font = [UIFont systemFontOfSize:13];
                btn.layer.borderColor = TextColor.CGColor;
                btn.layer.borderWidth = 0.5;
                btn.layer.cornerRadius = 3;
                [cell.contentView addSubview:btn];
                
                
                }else{
    
                     cell.contentView.backgroundColor = Cell_BackColr;
                    
                    for (int i = 0; i<2; i++) {
                        
                        NSArray *title = @[@"任务总数(个):",@"所需冻结备付金(元):"];
                        UILabel *task = [[UILabel alloc] init];
                        task.frame = CGRectMake(20, 20+i*20+i*20, kScreenWitdth/2.5, 20);
                        task.text = title[i];
                        task.textColor = TextColor;
                        task.font = [UIFont systemFontOfSize:12];
                        task.textAlignment = NSTextAlignmentRight;
                        [cell.contentView addSubview:task];
                        
                        NSArray *placher = @[@"请输入任务总数",@"请输入冻结备付金额"];
                        UITextField *textF = [[UITextField alloc] init];
                        textF.frame = CGRectMake(20+task.frame.size.width+15, 15+i*25+i*18, kScreenWitdth/3, 25);
                        textF.layer.borderColor = [UIColor grayColor].CGColor;
                        textF.tag = i+200;
                        textF.font = [UIFont systemFontOfSize:11];
                        textF.placeholder = placher[i];
                        textF.layer.borderWidth = 0.5;
                        textF.delegate = self;
                        textF.clearButtonMode = UITextFieldViewModeWhileEditing;
                        textF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                        [cell.contentView addSubview:textF];
                    }
                }
        
        }
        
        
    }
    
    UILabel *title = [cell.contentView viewWithTag:1];
    title.text = @"1344";
    
    UILabel *label1 = [cell.contentView viewWithTag:102];
    label1.text = @"1.备付金不足，可立即充值不付备付金";
    UILabel *label2 = [cell.contentView viewWithTag:103];
    label2.text = @"2.备付金不足，可立即充值不付备付金";
    
    UIButton *btn = [cell.contentView viewWithTag:10];
    [btn addTarget:self action:@selector(changeTask:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        
        return 0.0001;
    }
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 2) {
        return 80;
    }

    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

      
    if (indexPath.section ==1){
    
        if (indexPath.row == 1) {
            
            return 60;
        }
    }else if (indexPath.section == 2){
    
        if (indexPath.row == 1) {
            
            return 100;
        }else{
        
            return 55;
        }
    }
    
    return 44.f;

    
}

#pragma mark 修改任务
- (void)changeTask:(UIButton *)btn{

    //移除充值界面
    //添加修改发布界面
    
    
    if (btn.selected == NO) {
        
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        if ( [self.postedTableDelegate respondsToSelector:@selector(removeBottomView)]) {
            
            
            [self.postedTableDelegate removeBottomView];
        }

        
        btn.selected = YES;
    }else if (btn.selected == YES){
    
        [btn setTitle:@"修改" forState:UIControlStateNormal];
        
        btn.selected = NO;
        
        if ([self.postedTableDelegate respondsToSelector:@selector(addBotttomView)]) {
            
            [self.postedTableDelegate addBotttomView];
            
        }
    }
}

#pragma mark 文字编辑-键盘移动
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    textField.layer.borderColor = TextColor.CGColor;
    textField.layer.borderWidth = 0.5;
  

    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    textField.layer.borderColor = [UIColor grayColor].CGColor;
    textField.layer.borderWidth = 0.5;

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    NSLog(@"%ld",(long)textField.tag);
    

    if (textField.tag == 200) {
        
        //键盘上移
        [UIView animateWithDuration:0.35 animations:^{
            
            
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y-180, kScreenWitdth, self.frame.size.height);
        }];
    }else if (textField.tag == 201){
    
        
        //键盘上移
        [UIView animateWithDuration:0.35 animations:^{
            
            
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y-155, kScreenWitdth, self.frame.size.height);
        }];
    }
    
  
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    
    if (textField.tag == 200) {
        
        //键盘上移
        [UIView animateWithDuration:0.35 animations:^{
            
            
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y+180, kScreenWitdth, self.frame.size.height);
        }];
    }else if (textField.tag == 201){
        
        
        //键盘上移
        [UIView animateWithDuration:0.35 animations:^{
            
            
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y+155, kScreenWitdth, self.frame.size.height);
        }];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}
@end
