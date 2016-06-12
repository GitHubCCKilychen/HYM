//
//  TiXianDeatailVC.m
//  PingChuan
//
//  Created by pengli on 15/10/21.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "TiXianDeatailVC.h"

@interface TiXianDeatailVC ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, retain) UITableView * myTableView;

@end

@implementation TiXianDeatailVC
@synthesize myTableView;

@synthesize applyfee;
@synthesize keytype;

- (void)dealloc
{
    [myTableView release]; myTableView = nil;
    
    [applyfee release]; applyfee = nil;
    [keytype  release]; keytype = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadSet];
    [self loadData];
}

- (void)loadSet
{
    
    if ([keytype integerValue] == 1)
    {
        [self.navigationItem setNewTitle:@"支付宝提现"];
    }
    else if ([keytype integerValue] == 2)
    {
        [self.navigationItem setNewTitle:@"银行卡提现"];
    }
    else if ([keytype integerValue] == 3)
    {
        [self.navigationItem setNewTitle:@"微信提现"];
    }
    [self.navigationController.navigationBar setBarTintColor:NavigationColor];
    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftBtnPressed) image:@"common_return.png" imageH:@"common_return.png"];
    self.view.backgroundColor = BB_Back_Color_Here;
    

    self.myTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, UI_View_Hieght) style:UITableViewStyleGrouped]autorelease];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    [myTableView setBackgroundView:nil];
    [myTableView setSeparatorInset:UIEdgeInsetsMake(0, 14, 0, 0)];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myTableView];
    [myTableView setBounces:NO];
}

- (void)loadData
{
    
}

- (void)leftBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)okButtonPress:(UIButton *)button
{
    UITextField *textfield1 = (UITextField*)[myTableView viewWithTag:1];
    UITextField *textfield2 = (UITextField*)[myTableView viewWithTag:2];
    if ([keytype integerValue] == 2)
    {
        UITextField *textfield3 = (UITextField*)[myTableView viewWithTag:3];
        UITextField *textfield4 = (UITextField*)[myTableView viewWithTag:4];
        if (textfield3.text.length == 0||textfield4.text.length == 0)
        {
            [XtomFunction openIntervalHUD:@"输入框不能为空" view:self.view];
            return;
        }
    }
    if (textfield1.text.length == 0||textfield2.text.length == 0)
    {
        [XtomFunction openIntervalHUD:@"输入框不能为空" view:self.view];
        return;
    }
    switch ([keytype integerValue])
    {
        case 1:
        {
            [self requestAlipayInfo];
        }
            break;
        case 2:
        {
            [self requestBankInfo];
        }
            break;
        case 3:
        {
            [self requestWeiXinInfo];
        }
            break;
        default:
            break;
    }
}


-(void)keyboardWillShow:(NSNotification *)notification
{
    UIButton * button = (UIButton *)[myTableView viewWithTag:100000];
    button.userInteractionEnabled = NO;
}
-(void)keyboardWillHide:(NSNotification *)notification
{
    UIButton * button = (UIButton *)[myTableView viewWithTag:100000];
    button.userInteractionEnabled = YES;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(1999 == alertView.tag&&1 == buttonIndex)
    {
        UITextField *textf = [alertView textFieldAtIndex:0];
        if ([XtomFunction xfunc_check_strEmpty:textf.text])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入钱包支付密码，包含字母和数字" message:@"密码不能为空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
            [alert show];
            alert.tag = 1999;
            [alert release];
            return;
        }
        [textf resignFirstResponder];
        [self requestTiXian:textf.text];
    }
    if (100 == alertView.tag&&0 == buttonIndex)
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([keytype integerValue] == 2)
    {
        return 4;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"TiXianDetailCell00";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        
        
        UITextField * textFeild = [[[UITextField alloc] initWithFrame:CGRectMake(15, 0, WIDTH-30, 60)] autorelease];
        textFeild.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        textFeild.delegate = self;
        textFeild.returnKeyType = UIReturnKeyDone;
        textFeild.tag = indexPath.row+1;
        [cell.contentView addSubview:textFeild];
    }
    NSMutableArray * placeholders = nil;
    if ([keytype integerValue] == 1)
    {
        placeholders = [[[NSMutableArray alloc] initWithObjects:@"请输入支付宝账号", @"请输入支付宝真实姓名", nil] autorelease];
    }
    else if ([keytype integerValue] == 2)
    {
        placeholders = [[[NSMutableArray alloc] initWithObjects:@"请输入银行卡号", @"请输入银行开户行名称", @"请输入银行预留账户名称", @"请输入银行预留账户电话", nil] autorelease];
    }
    else if ([keytype integerValue] == 3)
    {
        placeholders = [[[NSMutableArray alloc] initWithObjects:@"请输入微信账户", @"请输入微信真实姓名", nil] autorelease];
    }
    UITextField * textFeild = (UITextField *)[cell viewWithTag:indexPath.row+1];
    textFeild.placeholder = placeholders[indexPath.row];
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footView = [[[UIView alloc] init] autorelease];
    footView.backgroundColor = [UIColor clearColor];
    
    
    UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setFrame:CGRectMake(24, 47, WIDTH-48, 42)];
    [loginButton addTarget:self action:@selector(okButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitle:@"确定" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setBackgroundColor:BB_Button_Color];
    loginButton.tag = 100000;
    [footView addSubview:loginButton];
    
    
    UILabel * infoLabel = [[[UILabel alloc] init] autorelease];
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.textAlignment = NSTextAlignmentLeft;
    infoLabel.font = [UIFont systemFontOfSize:15];
    infoLabel.textColor = [UIColor darkGrayColor];
    [infoLabel setFrame:CGRectMake(15, 47+42+17, WIDTH-30, 20)];
    infoLabel.text = @"提示：";
    [footView addSubview:infoLabel];
    
    
    UILabel * infoDetail = [[[UILabel alloc] init] autorelease];
    infoDetail.backgroundColor = [UIColor clearColor];
    infoDetail.textAlignment = NSTextAlignmentLeft;
    infoDetail.font = [UIFont systemFontOfSize:13];
    infoDetail.textColor = [UIColor lightGrayColor];
    [infoDetail setFrame:CGRectMake(15, 47+42+17+20, WIDTH-30, 18.5)];
    infoDetail.text = @"申请将在2-3个工作日处理完毕，敬请等待!";
    [footView addSubview:infoDetail];
    
    return footView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 175;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)requestTiXian:(NSString*)paypassword
{
    NSString * token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary * paraDic = [[[NSMutableDictionary alloc] init]autorelease];
    [paraDic setObject:token?token:@"" forKey:@"token"];
    switch ([keytype integerValue]) {
        case 1:
        {
            [paraDic setObject:@"2" forKey:@"keytype"];
        }
            break;
        case 2:
        {
            [paraDic setObject:@"1" forKey:@"keytype"];
        }
            break;
        case 3:
        {
            [paraDic setObject:@"3" forKey:@"keytype"];
        }
            break;
        default:
            break;
    }
    
    [paraDic setObject:applyfee forKey:@"applyfee"];
    [paraDic setObject:[XtomFunction encodePassword:paypassword] forKey:@"password"];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_CASH_ADD] target:self selector:@selector(responseTiXian:) parameter:paraDic];
    
}

- (void)responseTiXian:(NSDictionary *)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提现成功" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        alert.tag = 100;
        alert.delegate = self;
        [alert release];
        NSString * oldFee = [[[XtomManager sharedManager] motherInfor] objectForKey:@"feeaccount"];
        CGFloat nowFee = [oldFee floatValue] - [applyfee floatValue];
        [[[XtomManager sharedManager] motherInfor] setObject:[NSString stringWithFormat:@"%.2f", nowFee] forKey:@"feeaccount"];
    }
    else
    {
        if([info objectForKey:@"msg"])
        {
            [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:nil];
        }
    }
}


- (void)requestBankInfo
{
    NSString * token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary * paraDic = [[[NSMutableDictionary alloc] init]autorelease];
    [paraDic setObject:token?token:@"" forKey:@"token"];
    UITextField *textfield1 = (UITextField*)[myTableView viewWithTag:1];
    UITextField *textfield2 = (UITextField*)[myTableView viewWithTag:2];
    UITextField *textfield3 = (UITextField*)[myTableView viewWithTag:3];
    UITextField *textfield4 = (UITextField*)[myTableView viewWithTag:4];
    [paraDic setObject:textfield1.text forKey:@"bankuser"];
    [paraDic setObject:textfield2.text forKey:@"bankname"];
    [paraDic setObject:textfield3.text forKey:@"bankcard"];
    [paraDic setObject:textfield4.text forKey:@"bankaddress"];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_BANK_SAVE] target:self selector:@selector(responseBankInfo:) parameter:paraDic];
}

- (void)responseBankInfo:(NSDictionary *)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入钱包支付支付密码，包含字母和数字" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
        [alert show];
        alert.tag = 1999;
        [alert release];
    }
    else
    {
        if([info objectForKey:@"msg"])
        {
            [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:nil];
        }
    }
}


- (void)requestAlipayInfo
{
    NSString * token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary * paraDic = [[[NSMutableDictionary alloc] init]autorelease];
    [paraDic setObject:token?token:@"" forKey:@"token"];
    UITextField *textfield1 = (UITextField*)[myTableView viewWithTag:1];
    UITextField *textfield2 = (UITextField*)[myTableView viewWithTag:2];
    [paraDic setObject:textfield1.text forKey:@"alipay"];
    [paraDic setObject:textfield2.text forKey:@"realname"];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_ALIPAY_SAVE] target:self selector:@selector(responseAlipayInfo:) parameter:paraDic];
}

- (void)responseAlipayInfo:(NSDictionary *)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入钱包支付密码，包含数字和字母" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
        [alert show];
        alert.tag = 1999;
        [alert release];
    }
    else
    {
        if([info objectForKey:@"msg"])
        {
            [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:nil];
        }
    }
}


- (void)requestWeiXinInfo
{
    NSString * token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary * paraDic = [[[NSMutableDictionary alloc] init]autorelease];
    [paraDic setObject:token?token:@"" forKey:@"token"];
    UITextField *textfield1 = (UITextField*)[myTableView viewWithTag:1];
    UITextField *textfield2 = (UITextField*)[myTableView viewWithTag:2];
    [paraDic setObject:textfield1.text forKey:@"weixin"];
    [paraDic setObject:textfield2.text forKey:@"realname"];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_WEIXIN_SAVE] target:self selector:@selector(responseWeiXinInfo:) parameter:paraDic];
}

- (void)responseWeiXinInfo:(NSDictionary *)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入钱包支付密码，包含数字和字母" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
        [alert show];
        alert.tag = 1999;
        [alert release];
    }
    else
    {
        if([info objectForKey:@"msg"])
        {
            [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:nil];
        }
    }
}

@end
