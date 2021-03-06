//
//  HYMInfoTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/16.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMInfoTable.h"
#import "HYMInfoSectionView.h"
#import "HYMUserView.h"
#import "ChooseCityVC.h"
@interface HYMInfoTable ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong)NSArray *titleArr;
@property (nonatomic,strong)UIButton *sumbit;
@property (nonatomic,weak)UITextField *texF;
@end
@implementation HYMInfoTable

- (UIButton *)sumbit{
    
    if (_sumbit == nil) {
        
        _sumbit = [UIButton buttonWithType:UIButtonTypeCustom];
        _sumbit.frame = CGRectMake(15, 25, kScreenWitdth-30, 35);
        [_sumbit setTitle:@"提交" forState:UIControlStateNormal];
        [_sumbit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sumbit.titleLabel.textAlignment = NSTextAlignmentCenter;
        _sumbit.backgroundColor = [UIColor orangeColor];
        _sumbit.titleLabel.font = [UIFont systemFontOfSize:15];
        _sumbit.layer.cornerRadius = 3;
        [_sumbit addTarget:self action:@selector(submitAct:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sumbit;
}

-(NSArray *)titleArr{
    
    if (_titleArr == nil) {
        
        _titleArr = [NSArray array];
        _titleArr = @[@"昵称",@"性别",@"所在地区"];
    }
    return _titleArr;
}
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    if (self = [super initWithFrame:frame style:style]) {
        
        
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
    
    }
    return self;
}


#pragma mark DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        return 1;
    }
    
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  
        if (indexPath.section == 0) {
            
            cell.textLabel.text = self.titleArr[indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.textLabel.textColor = [UIColor grayColor];
            if (indexPath.row == 0) {
                
                UITextField *name = [[UITextField alloc] init];
                name.frame = CGRectMake(kScreenWitdth/2-kScreenWitdth/5, 10, kScreenWitdth/1.5, 20);
                name.delegate = self;
                name.tag = 22;
                name.placeholder = @"请输入昵称(不能超过五个字符)";
                name.textAlignment = NSTextAlignmentRight;
                name.font = [UIFont systemFontOfSize:13];
                [name addTarget:self action:@selector(changeTextValue:) forControlEvents:UIControlEventEditingChanged];
                [cell.contentView addSubview:name];
            }else if(indexPath.row == 1){
                
                UISegmentedControl *sex = [[UISegmentedControl alloc] initWithItems:@[@"男",@"女"]];
                sex.frame = CGRectMake(kScreenWitdth-70, 10, 60, 20);
                sex.selectedSegmentIndex = 0;
                sex.tag = 1;
                sex.tintColor = [UIColor orangeColor];
                [sex addTarget:self action:@selector(changeSex:) forControlEvents:UIControlEventValueChanged];
                [cell.contentView addSubview:sex];
                
            
            }else if (indexPath.row == 2){
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }else if (indexPath.section == 1){
            
            cell.backgroundColor = BB_Back_Color_Here;
            [cell.contentView addSubview:self.sumbit];

        }
    }
   
    return cell;
}

#pragma mark  选择年龄
- (void)ageAct:(UIButton *)btn{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (indexPath.section == 0) {
        
        ChooseCityVC *city = [[ChooseCityVC alloc] init];
        [self.viewController.navigationController pushViewController:city animated:YES];
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 1) {
        
        return 75;
    }
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        return 15;
    }

    return 0.0001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 1) {
        
        HYMInfoSectionView *view = [[HYMInfoSectionView alloc] init];
        view.frame = CGRectMake(0, 0, kScreenWitdth, 0);
        return view;
        
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section ==1) {
       
        return 80.f;
    }
    return 44.f;
}

#pragma mark 文字改变
- (void)changeTextValue:(UITextField *)text{

   
    self.text =text.text;
   
}

#pragma mark 选择性别
- (void)changeSex:(UISegmentedControl *)sex{

    
    //默认是男
    if (sex.selectedSegmentIndex == 0) {
        
       self.seg = sex;
    }else{
    
       self.seg = sex;
    }
  
}

#pragma mark 提交事件
- (void)submitAct:(UIButton *)btn{

    
    NSString *sex;
    if (self.seg.selectedSegmentIndex == 0) {
        
       sex = @"男";
    }else{
    
        sex = @"女";
    }
    
    if (self.text == nil || self.text == NULL || sex == nil || sex == NULL) {
        
        //提示输入信息

            MBProgressHUD *proress = [MBProgressHUD showHUDAddedTo:self.viewController.view animated:YES];
            proress.mode = MBProgressHUDModeText;
            proress.labelText = @"请输入姓名";
            proress.margin = 10.f;
            proress.removeFromSuperViewOnHide = YES;
            [proress hide:YES afterDelay:3];
            
    
    }else{
    
        //提交数据
        
        
    }
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}
@end
