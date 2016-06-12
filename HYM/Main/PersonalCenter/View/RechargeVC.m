//
//  RechargeVC.m
//  PingChuan
//
//  Created by pengli on 15/8/24.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "RechargeVC.h"
#import <AlipaySDK/AlipaySDK.h>
#import "UPPayPlugin.h"
#import "UPPayPluginDelegate.h"
#import "MyTextField.h"

@interface RechargeVC ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UPPayPluginDelegate, WXApiDelegate>
{
    NSInteger paySection;
    BOOL _isTextField;
}
@property (nonatomic, retain) UITableView * myTableView;
@property (nonatomic, retain) UITextField * textFeild;
@property (nonatomic, copy) NSString * orderStr;
@end

@implementation RechargeVC
@synthesize myTableView;
@synthesize textFeild;
@synthesize orderStr;

- (void)dealloc
{
    [myTableView release]; myTableView = nil;
    [textFeild release]; textFeild = nil;
    [orderStr release]; orderStr = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BB_NOTIFICATION_OrderOK object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BB_NOTIFICATION_OrderFail object:nil];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadSet];
}

- (void)loadSet
{
    
//    [self.navigationItem setNewTitle:@"账户充值"];
    
//    [self.navigationController.navigationBar setBarTintColor:NavigationColor];
//    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftBtnPressed:) image:@"common_return.png" imageH:@"common_return.png"];
    self.view.backgroundColor = BB_Back_Color_Here;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOkMessage) name:BB_NOTIFICATION_OrderOK object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getFailMessage) name:BB_NOTIFICATION_OrderFail object:nil];
    
    self.myTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UI_View_Hieght) style:UITableViewStyleGrouped] autorelease];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    paySection = -1;
}


- (void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)okButtonPress:(id)sender
{
   
    if ([XtomFunction xfunc_check_strEmpty:textFeild.text])
    {
        [XtomFunction openIntervalHUD:@"请输入充值金额" view:nil];
        return;
    }
    if (paySection == -1)
    {
        [XtomFunction openIntervalHUD:@"请选择支付方式" view:nil];
        return;
    }
    [self requestGetOrder];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _isTextField = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _isTextField = NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}


-(void)getOkMessage
{
    [XtomFunction openIntervalHUDOK:@"支付成功" view:nil];
}

-(void)getFailMessage
{
    [XtomFunction openIntervalHUD:@"支付失败" view:nil];
}


-(void)UPPayPluginResult:(NSString*)result
{
    if ([result isEqualToString:@"success"])
    {
        [XtomFunction openIntervalHUDOK:@"支付成功" view:nil];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    if ([result isEqualToString:@"fail"])
    {
        [XtomFunction openIntervalHUD:@"支付失败" view:nil];
        return;
    }
    if ([result isEqualToString:@"cancel"])
    {
        [XtomFunction openIntervalHUD:@"已取消支付" view:nil];
        return;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section)
    {
        return 1;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        static NSString * cellID = @"RechargeCell00";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            
            UILabel * moneyLabel = [[[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 25)] autorelease];
            moneyLabel.text = @"输入充值金额";
            moneyLabel.textColor = [UIColor grayColor];
            moneyLabel.font = [UIFont systemFontOfSize:15];
            [cell.contentView addSubview:moneyLabel];
            
            
            self.textFeild = [[[UITextField alloc] initWithFrame:CGRectMake(0, 55, WIDTH, 35)] autorelease];
            textFeild.textAlignment = NSTextAlignmentCenter;
            textFeild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            textFeild.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            textFeild.placeholder = @"请输入您要充值的金额";
            textFeild.delegate = self;
            textFeild.returnKeyType = UIReturnKeyDone;
            [cell.contentView addSubview:self.textFeild];
        }
        return cell;
    }
    if (1 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            static NSString *CellIdentifier = @"OrderCell05";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if(cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell setSeparatorInset:UIEdgeInsetsMake(0, 13, 0, 0)];
                cell.backgroundColor = BB_White_Color;
                
                
                UILabel *labLeft = [[[UILabel alloc]init]autorelease];
                labLeft.backgroundColor = [UIColor clearColor];
                labLeft.textAlignment = NSTextAlignmentLeft;
                labLeft.font = [UIFont systemFontOfSize:15];
                labLeft.textColor = BB_Blake;
                [labLeft setFrame:CGRectMake(13, 0, 150, 42)];
                [labLeft setText:@"选择其他支付方式"];
                [cell.contentView addSubview:labLeft];
            }
            
            return cell;
        }
        static NSString * CellIdentifier = @"OrderCell06";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsMake(0, 80, 0, 0)];
            cell.backgroundColor = BB_White_Color;
            
            
            UIImageView *leftImgView = [[[UIImageView alloc]init]autorelease];
            leftImgView.tag = 9;
            [cell.contentView addSubview:leftImgView];
            
           
            UILabel *labLeft = [[[UILabel alloc]init]autorelease];
            labLeft.backgroundColor = [UIColor clearColor];
            labLeft.textAlignment = NSTextAlignmentLeft;
            labLeft.font = [UIFont systemFontOfSize:15];
            labLeft.textColor = BB_Graydark;
            labLeft.tag = 10;
            [cell.contentView addSubview:labLeft];
            
            
            UILabel *labRight = [[[UILabel alloc]init]autorelease];
            labRight.backgroundColor = [UIColor clearColor];
            labRight.textAlignment = NSTextAlignmentLeft;
            labRight.textColor = BB_Gray;
            labRight.font = [UIFont systemFontOfSize:12];
            labRight.tag = 11;
            [cell.contentView addSubview:labRight];
            
            
            UIImageView *rightImgView = [[[UIImageView alloc]init]autorelease];
            [rightImgView setFrame:CGRectMake(280, 27, 22, 22)];
            rightImgView.tag = 12;
            [cell.contentView addSubview:rightImgView];
        }
        NSMutableArray *temArr = [[[NSMutableArray alloc]initWithObjects:@"支付宝客户端支付",@"银联手机支付",@"微信客户端支付",nil]autorelease];
        NSMutableArray *temArr1 = [[[NSMutableArray alloc]initWithObjects:@"推荐安装支付宝客户端的用户使用",@"推荐安装银联客户端的用户使用",@"推荐安装微信客户端的用户使用",nil]autorelease];
        
        
        UIImageView *leftImgView = (UIImageView*)[cell viewWithTag:9];
        if (1 == indexPath.row)
        {
            [leftImgView setFrame:CGRectMake(13, 29, 56, 19.9)];
            [leftImgView setImage:[UIImage imageNamed:@"支付宝.png"]];
        }
        if (2 == indexPath.row)
        {
            [leftImgView setFrame:CGRectMake(15, 24, 51, 27.5)];
            [leftImgView setImage:[UIImage imageNamed:@"银联.png"]];
        }
        if (3 == indexPath.row)
        {
            [leftImgView setFrame:CGRectMake(23, 20, 36, 36)];
            [leftImgView setImage:[UIImage imageNamed:@"微信充值.png"]];
        }
        
        UILabel *labLeft = (UILabel*)[cell viewWithTag:10];
        labLeft.frame = CGRectMake(80, 20, 200, 17);
        labLeft.text = [temArr objectAtIndex:indexPath.row-1];
        
        UILabel *labRight = (UILabel*)[cell viewWithTag:11];
        labRight.frame = CGRectMake(80, 43, 200, 14);
        labRight.text = [temArr1 objectAtIndex:indexPath.row-1];
        
        
        UIImageView *rightImgView = (UIImageView*)[cell viewWithTag:12];
        if (paySection == indexPath.row)
        {
            [rightImgView setImage:[UIImage imageNamed:@"支付方式_选中.png"]];
            [XtomFunction addbordertoView:rightImgView radius:0.0f width:0.0f color:[UIColor clearColor]];
        }else
        {
            [rightImgView setImage:nil];
            [XtomFunction addbordertoView:rightImgView radius:11.0f width:1.0f color:BB_Graylight];
        }
        
        return cell;
    }
    return nil;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footView = [[[UIView alloc] init] autorelease];
    footView.backgroundColor = [UIColor clearColor];
    if (1 == section) {
        
        UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginButton setFrame:CGRectMake(24, 40, WIDTH-48, 42)];
        [loginButton addTarget:self action:@selector(okButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginButton setBackgroundColor:BB_Button_Color];
        [footView addSubview:loginButton];
        
        [loginButton setTitle:@"充值" forState:UIControlStateNormal];
        
    }
    return footView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (1 == section)
    {
        return 10;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (1 == section)
    {
        return 90;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        return 115;
    }
    if (0 == indexPath.row)
    {
        return 42;
    }
    return 76.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isTextField)
    {
        [textFeild resignFirstResponder];
        return;
    }
    if (indexPath.section == 0)
    {
        return;
    }
    paySection = indexPath.row;
    [myTableView reloadData];
}


- (void)requestGetOrder
{
    NSString *token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    if(token)
    [dic setObject:token forKey:@"token"];
    [dic setObject:@"1" forKey:@"keytype"];
    [dic setObject:@"0" forKey:@"keyid"];
    [dic setObject:textFeild.text forKey:@"total_fee"];
    if (1 == paySection)
    {
        [dic setObject:@"1" forKey:@"paytype"];
        [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@OnlinePay/Alipay/alipaysign_get.php",[[[XtomManager sharedManager] myinitInfor] objectForKey:@"sys_plugins"]] target:self selector:@selector(responseGetOrder:) parameter:dic];
        return;
    }
    else if (2 == paySection)
    {
        [dic setObject:@"2" forKey:@"paytype"];
        [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@OnlinePay/Unionpay/unionpay_get.php",[[[XtomManager sharedManager] myinitInfor] objectForKey:@"sys_plugins"]] target:self selector:@selector(responseGetOrder:) parameter:dic];
    }
    else if (3 == paySection)
    {
        [dic setObject:@"3" forKey:@"paytype"];
        [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@OnlinePay/Weixinpay/weixinpay_get.php",[[[XtomManager sharedManager] myinitInfor] objectForKey:@"sys_plugins"]] target:self selector:@selector(responseGetOrder:) parameter:dic];
    }
}

- (void)responseGetOrder:(NSDictionary*)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        if (1 == paySection)
        {
            NSString *appScheme = @"haoyangmao";
            self.orderStr = [[[info objectForKey:@"infor"]objectAtIndex:0]objectForKey:@"alipaysign"];

            
            
            [[AlipaySDK defaultService] payOrder:self.orderStr fromScheme:appScheme callback:^(NSDictionary *resultDic)
             {
                 NSLog(@"reslut = %@",resultDic);
                 
                 NSString *result=[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
                 
                 
                 if ([result isEqualToString:@"9000"])
                 {

                 }
                 
                 if ([result isEqualToString:@"6001"])
                 {
                     [XtomFunction openIntervalHUDOK:@"已取消支付" view:self.view];
                 }
             }];
            
            
        }
        if (2 == paySection)
        {
            self.orderStr = [[[info objectForKey:@"infor"]objectAtIndex:0]objectForKey:@"tn"];
            NSLog(@"订单号：%@",self.orderStr);
            
            [UPPayPlugin startPay:self.orderStr mode:BB_XCONST_IS_YLCeshi viewController:self delegate:self];
        }
        if (3 == paySection)
        {
            NSMutableDictionary *temDic = [[info objectForKey:@"infor"]objectAtIndex:0];
            [WXApi registerApp:[temDic objectForKey:@"appid"]];
            PayReq *request = [[PayReq alloc] init];
            request.partnerId = [temDic objectForKey:@"partnerid"];
            request.prepayId= [temDic objectForKey:@"prepayid"];
            request.package = [temDic objectForKey:@"package"];
            request.nonceStr= [temDic objectForKey:@"noncestr"];
            request.timeStamp= [[temDic objectForKey:@"timestamp"]intValue];
            request.sign= [temDic objectForKey:@"sign"];
            [WXApi sendReq:request];
        }
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
