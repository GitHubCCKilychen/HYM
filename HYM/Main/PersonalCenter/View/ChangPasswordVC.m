//
//  changPasswordVC.m
//  BAOWEN
//
//  Created by 李朋 on 13-10-14.
//  Copyright (c) 2013年 平川嘉恒. All rights reserved.
//

#import "ChangPasswordVC.h"
#import "XtomConst.h"

@interface ChangPasswordVC ()
{
    MBProgressHUD *waitMB;
    
    BOOL isNum;
    BOOL isChar;
}
@property(nonatomic,retain)UITableView *myTableView;
@property(nonatomic,retain)NSMutableArray *dataSource;
@end

@implementation ChangPasswordVC

@synthesize myTableView;
@synthesize dataSource;
@synthesize isZhiFu;
@synthesize isFirst;

-(void)dealloc
{
    [myTableView release];myTableView = nil;
    [dataSource release];dataSource = nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	[self loadData];
    [self loadset];
}
-(void)loadData
{
    self.dataSource = [[[NSMutableArray alloc]init]autorelease];
}
-(void)loadset
{
    
    if (isZhiFu)
    {
        if (isFirst)
        {
            [self.navigationItem setNewTitle:@"设置钱包支付密码"];
        }
        else
        {
            [self.navigationItem setNewTitle:@"修改钱包支付密码"];
        }
    }else
    {
        [self.navigationItem setNewTitle:@"修改登录密码"];
    }
    [self.view setBackgroundColor:BB_Back_Color_Here];
    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftbtnPressed:) image:@"common_return.png" imageH:@"common_return.png"];
    
    
    self.myTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, UI_View_Hieght) style:UITableViewStyleGrouped]autorelease];
    [myTableView setBackgroundColor:BB_Back_Color_Here];
    [myTableView setBackgroundView:nil];
    [myTableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 0)];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myTableView];
    
    
    NSString *mystring = @"LETTER1";
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    
    if ([predicate evaluateWithObject:mystring] == YES)
    {
        NSLog(@"YES");
    }
    else
    {
        NSLog(@"NO");
    }
}

-(void)leftbtnPressed:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)sureButtonPress:(UIButton*)sender
{
    UITextField *textfield1 = (UITextField*)[myTableView viewWithTag:11];
    UITextField *textfield2 = (UITextField*)[myTableView viewWithTag:12];
    UITextField *textfield3 = (UITextField*)[myTableView viewWithTag:13];
    
    if (isZhiFu)
    {
        if (isFirst)
        {
            if (textfield1.text.length == 0 || textfield2.text.length == 0)
            {
                [XtomFunction openIntervalHUD:@"请补全信息" view:self.view];
                return;
            }
            if (![textfield1.text isEqualToString:textfield2.text])
            {
                [XtomFunction openIntervalHUD:@"两次新密码输入不一致" view:self.view];
                return;
            }
            
            isNum = NO;
            isChar = NO;
            for (int i = 0; i < [textfield1.text length]; i++)
            {
                for (int j = 0; j < 10; j++)
                {
                    NSString * str1 = [NSString stringWithFormat:@"%C", [textfield1.text characterAtIndex:i]];
                    NSString * str2 = [NSString stringWithFormat:@"%d", j];
                    if ([str1 isEqualToString:str2])
                    {
                        isNum = YES;
                        break;
                    }
                }
            }
            for (int i = 0; i < [textfield1.text length]; i++)
            {
                NSLog(@"%C",[textfield1.text characterAtIndex:i]);
                for (char j = 'a'; j <= 'z'; j++)
                {
                    NSString * str1 = [NSString stringWithFormat:@"%C", [textfield1.text characterAtIndex:i]];
                    NSString * str2 = [NSString stringWithFormat:@"%c", j];
                    if ([str1 isEqualToString:str2])
                    {
                        isChar = YES;
                        break;
                    }
                }
            }
            for (int i = 0; i < [textfield1.text length]; i++)
            {
                NSLog(@"%C",[textfield1.text characterAtIndex:i]);
                for (char j = 'A'; j <= 'Z'; j++)
                {
                    NSString * str1 = [NSString stringWithFormat:@"%C", [textfield1.text characterAtIndex:i]];
                    NSString * str2 = [NSString stringWithFormat:@"%c", j];
                    if ([str1 isEqualToString:str2])
                    {
                        isChar = YES;
                        break;
                    }
                }
            }
            NSLog(@"isNum:%d,isChar:%d", isNum, isChar);
            if (!isNum)
            {
                [XtomFunction openIntervalHUD:@"密码中必须包含数字" view:self.view];
                return;
            }
            if (!isChar)
            {
                [XtomFunction openIntervalHUD:@"密码中必须包含字母" view:self.view];
                return;
            }
        }
        else
        {
            if (textfield1.text.length == 0)
            {
                [XtomFunction openIntervalHUD:@"初始密码不能为空" view:self.view];
                return;
            }
            if (textfield1.text.length < 6)
            {
                [XtomFunction openIntervalHUD:@"初始密码格式不正确" view:self.view];
                return;
            }
            if(textfield1.text.length > 12)
            {
                [XtomFunction openIntervalHUD:@"初始密码不正确" view:self.view];
                return;
            }
            if (textfield2.text.length< 6||textfield2.text.length > 12)
            {
                [XtomFunction openIntervalHUD:@"新密码6至12位" view:self.view];
                return;
            }
            if(![textfield2.text isEqualToString:textfield3.text])
            {
                [XtomFunction openIntervalHUD:@"两次新密码输入不一致" view:self.view];
                return;
            }
            
    
            isNum = NO;
            isChar = NO;
            for (int i = 0; i < [textfield2.text length]; i++)
            {
                for (int j = 0; j < 10; j++)
                {
                    NSString * str1 = [NSString stringWithFormat:@"%C", [textfield2.text characterAtIndex:i]];
                    NSString * str2 = [NSString stringWithFormat:@"%d", j];
                    if ([str1 isEqualToString:str2])
                    {
                        isNum = YES;
                        break;
                    }
                }
            }
            for (int i = 0; i < [textfield2.text length]; i++)
            {
                NSLog(@"%C",[textfield2.text characterAtIndex:i]);
                for (char j = 'a'; j <= 'z'; j++)
                {
                    NSString * str1 = [NSString stringWithFormat:@"%C", [textfield2.text characterAtIndex:i]];
                    NSString * str2 = [NSString stringWithFormat:@"%c", j];
                    if ([str1 isEqualToString:str2])
                    {
                        isChar = YES;
                        break;
                    }
                }
            }
            for (int i = 0; i < [textfield2.text length]; i++)
            {
                NSLog(@"%C",[textfield2.text characterAtIndex:i]);
                for (char j = 'A'; j <= 'Z'; j++)
                {
                    NSString * str1 = [NSString stringWithFormat:@"%C", [textfield2.text characterAtIndex:i]];
                    NSString * str2 = [NSString stringWithFormat:@"%c", j];
                    if ([str1 isEqualToString:str2])
                    {
                        isChar = YES;
                        break;
                    }
                }
            }
            NSLog(@"isNum:%d,isChar:%d", isNum, isChar);
            if (!isNum)
            {
                [XtomFunction openIntervalHUD:@"密码中必须包含数字" view:self.view];
                return;
            }
            if (!isChar)
            {
                [XtomFunction openIntervalHUD:@"密码中必须包含字母" view:self.view];
                return;
            }
            [textfield1 resignFirstResponder];
            [textfield2 resignFirstResponder];
            [textfield3 resignFirstResponder];
        }

    }
    else
    {
        if (textfield1.text.length == 0)
        {
            [XtomFunction openIntervalHUD:@"初始密码不能为空" view:self.view];
            return;
        }
        if (textfield1.text.length < 6)
        {
            [XtomFunction openIntervalHUD:@"初始密码格式不正确" view:self.view];
            return;
        }
        if(textfield1.text.length > 12)
        {
            [XtomFunction openIntervalHUD:@"初始密码不正确" view:self.view];
            return;
        }
        if (textfield2.text.length< 6||textfield2.text.length > 12)
        {
            [XtomFunction openIntervalHUD:@"新密码6至12位" view:self.view];
            return;
        }
        if(![textfield2.text isEqualToString:textfield3.text])
        {
            [XtomFunction openIntervalHUD:@"两次新密码输入不一致" view:self.view];
            return;
        }
        [textfield1 resignFirstResponder];
        [textfield2 resignFirstResponder];
        [textfield3 resignFirstResponder];
    }
    
    [self requestMyResetPassword:[XtomFunction encodePassword:textfield1.text] mynew:[XtomFunction encodePassword:textfield2.text]];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isFirst)
    {
        return 2;
    }
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"BWMChangePasswordCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = BB_White_Color;
    }else
    {
        for(UIView *view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
    }
    
    
    UILabel *labLeft = [[[UILabel alloc]init]autorelease];
    labLeft.backgroundColor = [UIColor clearColor];
    labLeft.textAlignment = NSTextAlignmentLeft;
    labLeft.font = [UIFont boldSystemFontOfSize:15];
    labLeft.tag = 10;
    labLeft.textColor = [UIColor grayColor];
    [cell.contentView addSubview:labLeft];
    [labLeft setHidden:YES];
    
    
    UITextField *password = [[[UITextField alloc]init]autorelease];
    password.textColor = [UIColor grayColor];
    password.font = [UIFont systemFontOfSize:15.0];
    password.secureTextEntry = YES;
    password.delegate = self;
    password.keyboardType = UIKeyboardTypeDefault;
    password.tag = 11+indexPath.row;
    password.frame = CGRectMake(15, 11, 160+120, 20);
    password.textAlignment = NSTextAlignmentLeft;
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    password.returnKeyType = UIReturnKeyDone;
    [cell.contentView addSubview:password];
    
    NSMutableArray *temArr = [[[NSMutableArray alloc]initWithObjects:@"原密码",@"新密码",@"确定新密码", nil]autorelease];
    
    labLeft.frame = CGRectMake(15, 0, 120, 44);
    password.placeholder = [temArr objectAtIndex:indexPath.row];
    
    password.text = @"";
    if (0 == indexPath.row)
    {
        [password becomeFirstResponder];
    }
    if (isZhiFu)
    {
        if (isFirst)
        {
            if (0 == indexPath.row)
            {
                password.placeholder = @"6-20位密码,包含字母和数字,区分大小写";
            }
            if (1 == indexPath.row)
            {
                password.placeholder = @"确认密码";
            }
        }
        else
        {
            if (1 == indexPath.row)
            {
                password.placeholder = @"6-20位密码,包含字母和数字,区分大小写";
            }
        }
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[[UIView alloc]init]autorelease];
    if (0 == section)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [footView addSubview:btn];
        btn.frame = CGRectMake(42, 23, 236, 44);
        [XtomFunction addbordertoView:btn radius:6.0f width:0.0f color:[UIColor clearColor]];
        [btn setBackgroundColor:BB_Button_Color];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        btn.titleLabel.textColor = BB_White_Color;
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn setTitleColor:BB_White_Color forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [btn addTarget:self action:@selector(sureButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return footView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(0 == section)
    {
        return 100;
    }
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath
{
    UITableViewCell *temCell = (UITableViewCell*)[myTableView cellForRowAtIndexPath:indexPath];
    UITextField *passwords = (UITextField*)[temCell viewWithTag:11];
    [passwords becomeFirstResponder];
}


- (BOOL)textFieldShouldReturn:(id)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)requestMyResetPassword:(NSString*)myold mynew:(NSString*)mynew
{
    NSString *token=[[XtomManager sharedManager]userToken];
    NSMutableDictionary *paraDic = [[[NSMutableDictionary alloc] init]autorelease];
    [paraDic setObject:token forKey:@"token"];
    if (isZhiFu)
    {
        [paraDic setObject:@"2" forKey:@"keytype"];
    }else
    {
        [paraDic setObject:@"1" forKey:@"keytype"];
    }
    [paraDic setObject:myold forKey:@"old_password"];
    [paraDic setObject:mynew forKey:@"new_password"];
    
    waitMB = [XtomFunction openHUD:@"正在保存" view:self.view];
    
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_SAVE_PASSWORD] target:self selector:@selector(responseMyResetPassword:) parameter:paraDic];
}
-(void)responseMyResetPassword:(NSDictionary*)info
{
    [XtomFunction closeHUD:waitMB];
    NSString *status = [info objectForKey:@"success"];
    if(![XtomFunction xfunc_check_strEmpty:status])
    {
        if(1 == [status intValue])
        {
            
            if (isZhiFu)
            {
                UITextField *textfield3 = (UITextField*)[myTableView viewWithTag:12];
                [[[XtomManager sharedManager] motherInfor] setObject:[XtomFunction encodePassword:textfield3.text] forKey:@"paypassword"];
                if (isFirst)
                {
                    [XtomFunction openIntervalHUDOK:@"交易密码设置成功" view:nil];
                }
                else
                {
                    [XtomFunction openIntervalHUDOK:@"交易密码修改成功" view:nil];
                }
            }else
            {
                UITextField *textfield3 = (UITextField*)[myTableView viewWithTag:12];
                [[NSUserDefaults standardUserDefaults] setValue:[XtomFunction encodePassword:textfield3.text] forKey:BB_XCONST_LOCAL_PASSWORD];
                [XtomFunction openIntervalHUDOK:@"修改登录密码" view:nil];
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            if([info objectForKey:@"msg"])
            {
                [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:nil];
            }
        }
    }
}
@end
