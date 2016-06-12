//
//  OrderCreateVC.m
//  PingChuan
//
//  Created by pengli on 15/10/12.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "OrderCreateVC.h"
#import "RechargeVC.h"
#import "UserAddressVC.h"

#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"

#import "UPPayPlugin.h"
#import "UPPayPluginDelegate.h"

#import <QuartzCore/QuartzCore.h>
#import <AdSupport/AdSupport.h>
#import <Security/Security.h>

#import "ChangPasswordVC.h"

#import "OrderDetailVC.h"
#import "UserOrderVC.h"

@interface OrderCreateVC ()<UITableViewDataSource, UITableViewDelegate, UPPayPluginDelegate, WXApiDelegate, SaveAddressInfoDelegate>
{
    MBProgressHUD * waitMB;
    NSInteger selectIndex;
    BOOL isDefaultAddress;
    NSInteger orderNum;
}
@property (nonatomic, retain) UITableView * myTableView;
@property (nonatomic, retain) NSMutableDictionary * addressDic;
@end

@implementation OrderCreateVC
@synthesize myTableView;
@synthesize addressDic;
@synthesize isReality;
@synthesize dataSource;
@synthesize keytype;
@synthesize keyid;
@synthesize sectionNum;
@synthesize buycount;

- (void)dealloc
{
    [myTableView release]; myTableView = nil;
    [addressDic release]; addressDic = nil;
    [dataSource release]; dataSource = nil;
    [keytype release]; keytype = nil;
    [keyid release]; keyid = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BB_NOTIFICATION_OrderOK object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BB_NOTIFICATION_OrderFail object:nil];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOkMessage) name:BB_NOTIFICATION_OrderOK object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getFailMessage) name:BB_NOTIFICATION_OrderFail object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadSet];
    [self loadData];
}

- (void)loadSet
{
    if ([keytype integerValue] == 3)
    {
        [self.navigationItem setNewTitle:@"订单支付"];
    }
    else
    {
        [self.navigationItem setNewTitle:@"确定订单"];
    }
    self.view.backgroundColor = BB_Back_Color_Here;
    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftBtnPressed) image:@"common_return.png" imageH:@"common_return.png"];
    self.myTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, UI_View_Hieght) style:UITableViewStyleGrouped]autorelease];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    [myTableView setBackgroundView:nil];
    [myTableView setSeparatorInset:UIEdgeInsetsMake(0, 13, 0, 0)];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myTableView];
    UIView * downView = [[[UIView alloc]init]autorelease];
    [downView setFrame:CGRectMake(0, 0, WIDTH, 100)];
    myTableView.tableFooterView = downView;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [downView addSubview:btn];
    btn.frame = CGRectMake(24, 45, WIDTH-48, 40);
    [XtomFunction addbordertoView:btn radius:1.0f width:0.0f color:[UIColor clearColor]];
    [btn setBackgroundColor:BB_Button_Color];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.titleLabel.textColor = BB_White_Color;
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:BB_White_Color forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [btn addTarget:self action:@selector(sureButtonPress:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)loadData
{
    self.addressDic = [[[NSMutableDictionary alloc] init] autorelease];
    if ([keytype integerValue] == 1 && [dataSource count] > 1)
    {
        orderNum = dataSource.count;
    }
    else
    {
        orderNum = 1;
    }
    if ([keytype integerValue] != 3 || isReality)
    {
        [self requestAddressList];
    }
}
- (void)leftBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)sureButtonPress:(id)sender
{
    if (0 == selectIndex)
    {
        NSInteger myAccount = [[[[XtomManager sharedManager] motherInfor] objectForKey:@"feeaccount"] integerValue];
        NSInteger needAccount = 0;
        switch ([keytype integerValue])
        {
            case 1:
            {
                CGFloat goodsTotalFee = 0;
                CGFloat yunTotalFree = 0;
                CGFloat goodsFee = 0;
                CGFloat yunFee = 0;
                BOOL isFree = YES;
                for (int i = 0; i < dataSource.count; i++)
                {
                    NSMutableArray * temArr = [dataSource objectAtIndex:i];
                    for (int j = 0; j < temArr.count; j++)
                    {
                        NSMutableDictionary * temDict = [temArr objectAtIndex:j];
                        goodsFee = [[temDict objectForKey:@"price"] floatValue]*[[temDict objectForKey:@"buycount"] integerValue];
                        if (goodsFee>=[[temDict objectForKey:@"expressforfree"] floatValue])
                        {
                            yunFee = 0;
                        }
                        else
                        {
                            isFree = NO;
                            yunFee = [[temDict objectForKey:@"expressfee"] floatValue]*[[temDict objectForKey:@"buycount"] integerValue];
                        }
                        goodsTotalFee = goodsFee + goodsTotalFee;
                        yunTotalFree = yunTotalFree + yunFee;
                    }
                }
                if (isFree)
                {
                    needAccount = goodsTotalFee;
                }
                else
                {
                    needAccount = goodsTotalFee + yunTotalFree;
                }
            }
                break;
            case 2:
            {
                NSMutableDictionary * temDict = [dataSource objectAtIndex:0];
                CGFloat goodTotal = [[temDict objectForKey:@"price"] floatValue]*buycount;
                CGFloat yunFree = [[temDict objectForKey:@"expressforfree"] floatValue]*buycount;
                if (goodTotal>=yunFree)
                {
                    needAccount = goodTotal;
                }
                else
                {
                    needAccount = goodTotal + yunFree;
                }
            }
                break;
            case 3:
            {
                NSMutableDictionary * temDict = [dataSource objectAtIndex:0];
                needAccount = [[temDict objectForKey:@"total_fee"] floatValue];
            }
                break;
            default:
                break;
        }
        if (myAccount>=needAccount)
        {
            if ([keytype integerValue] == 3)
            {
                NSString * paypassword = [[[XtomManager sharedManager] motherInfor] objectForKey:@"paypassword"];
                if ([XtomFunction xfunc_check_strEmpty:paypassword])
                {
                    ChangPasswordVC *set = [[[ChangPasswordVC alloc]init]autorelease];
                    set.isZhiFu = YES;
                    set.isFirst = YES;
                    [self.navigationController pushViewController:set animated:YES];
                }
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入钱包支付密码，包含数字和字母" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
                    [alert show];
                    alert.tag = 1999;
                    alert.delegate = self;
                    [alert release];
                }
            }
            else
            {
                [self requestBillSave];
            }
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"余额不足，马上充值？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            alert.tag = 999;
            alert.delegate = self;
            [alert release];
        }
        return;
    }
    if ([keytype integerValue] == 3)
    {
        [self requestSanPay];
    }
    else
    {
        [self requestBillSave];
    }
}
-(void)okPay:(NSString*)titleStr
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titleStr message:@"支付成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    alert.tag = 100;
    alert.delegate = self;
    [alert release];
}
-(void)failPay:(NSString*)titleStr
{
    if ([keytype integerValue] == 3)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titleStr message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        alert.tag = 101;
        alert.delegate = self;
        [alert release];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titleStr message:@"支付失败，已生成未付款订单" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        alert.tag = 101;
        alert.delegate = self;
        [alert release];
    }
}
-(void)getOkMessage
{
    [self okPay:@"支付成功"];
}
-(void)getFailMessage
{
    if ([keytype integerValue] == 3)
    {
        [XtomFunction openIntervalHUD:@"支付失败" view:nil];
    }
    else
    {
        [self failPay:@"取消操作，支付失败"];
    }
}
-(void)UPPayPluginResult:(NSString*)result
{
    if ([result isEqualToString:@"success"])
    {
        [self okPay:@"支付成功"];
        return;
    }
    if ([keytype integerValue] == 3)
    {
        [XtomFunction openIntervalHUD:@"支付失败" view:nil];
    }else
    {
        [self failPay:@"支付失败"];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (403 == alertView.tag && 1 == buttonIndex)
    {
        [self leftBtnPressed];
    }
    if(999 == alertView.tag&&1 == buttonIndex)
    {
        RechargeVC * recharge = [[[RechargeVC alloc]init]autorelease];
        [self.navigationController pushViewController:recharge animated:YES];
    }
    if(1999 == alertView.tag&&1 == buttonIndex)
    {
        UITextField *textf = [alertView textFieldAtIndex:0];
        if ([XtomFunction xfunc_check_strEmpty:textf.text])
        {
            NSString * paypassword = [[[XtomManager sharedManager] motherInfor] objectForKey:@"paypassword"];
            if ([XtomFunction xfunc_check_strEmpty:paypassword])
            {
                ChangPasswordVC *set = [[[ChangPasswordVC alloc]init]autorelease];
                set.isZhiFu = YES;
                set.isFirst = YES;
                [self.navigationController pushViewController:set animated:YES];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入钱包支付密码，包含数字和字母" message:@"密码不能为空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
                [alert show];
                alert.tag = 1999;
                alert.delegate = self;
                [alert release];
                    return;
            }
            
        }
        [textf resignFirstResponder];
        [self requestClientAccountpay:textf.text];
    }
    if(1999 == alertView.tag&&0 == buttonIndex)
    {
        if ([keytype integerValue] == 3)
        {
            [XtomFunction openIntervalHUD:@"支付失败" view:nil];
        }
        else
        {
            [self failPay:@"取消操作，支付失败"];
        }
    }
    if(100 == alertView.tag&&0 == buttonIndex)
    {
        if ([keytype integerValue] == 3)
        {
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        }
        if ([keytype integerValue] == 2)
        {
            if (!isReality)
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:BUY_SUCCESS_XUNI object:nil userInfo:nil];
            }
            else
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:BUY_SUCCESS_SHIQU object:nil userInfo:nil];
            }
        }
        [self leftBtnPressed];
    }
    if(101 == alertView.tag&&0 == buttonIndex)
    {
        if ([keytype integerValue] == 1)
        {
            UserOrderVC * order = [[[UserOrderVC alloc] init] autorelease];
            order.navSelectType = 1;
            order.isCart = YES;
            [self.navigationController pushViewController:order animated:YES];
        }
        else if ([keytype integerValue] == 2)
        {
            if (isReality)
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:BUY_SUCCESS_SHIQU object:nil userInfo:nil];
                OrderDetailVC * detail = [[[OrderDetailVC alloc] init] autorelease];
                detail.keytype = @"0";
                detail.blogId = [addressDic objectForKey:@"bill_ids"];
                detail.isCartOrBuy = YES;
                [self.navigationController pushViewController:detail animated:YES];
            }
            else
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:BUY_SUCCESS_XUNI object:nil userInfo:nil];
             //   VirtualOrderDetailVC * detail = [[[VirtualOrderDetailVC alloc] init] autorelease];
               // detail.keytype = @"1";
                //detail.keyid = [addressDic objectForKey:@"bill_ids"];
                //detail.isCartOrBuy = YES;
                //[self.navigationController pushViewController:detail animated:YES];
            }
        }
        else if ([keytype integerValue] == 3)
        {
            [self leftBtnPressed];
        }
    }
}
- (void)saveAddressInfo:(NSDictionary *)info
{
    for(NSString *key in info.allKeys)
    {
        NSString *value = [info objectForKey:key];
        if(![XtomFunction xfunc_check_strEmpty:value])
        {
            [addressDic setObject:value forKey:key];
        }
    }
    [myTableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sectionNum;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (sectionNum-1 == section)
    {
        return 5;
    }
    if (isReality)
    {
        if (sectionNum-2 == section)
        {
            if ([keytype integerValue] == 1)
            {
                return 1;
            }
            return 0;
        }
    }
    if ([keytype integerValue] != 3)
    {
        if (isReality)
        {
            if (0 == section)
            {
                return 1;
            }
            if ([keytype integerValue] == 1)
            {
                NSMutableArray * temArr = [dataSource objectAtIndex:section-1];
                return 2+temArr.count+1;
            }
            return 4;
        }
        else
        {
            return 2;
        }
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (sectionNum-1 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            static NSString * CellIdentifier = @"OrderCell00";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if(cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = BB_White_Color;
                UILabel * labLeft = [[[UILabel alloc]init]autorelease];
                labLeft.backgroundColor = [UIColor clearColor];
                labLeft.textAlignment = NSTextAlignmentLeft;
                labLeft.font = [UIFont systemFontOfSize:15];
                labLeft.textColor = BB_Blake;
                [labLeft setFrame:CGRectMake(13, 0, 250, 56)];
                labLeft.tag = 10;
                [cell.contentView addSubview:labLeft];
                UIImageView *rightImgView = [[[UIImageView alloc]init]autorelease];
                [rightImgView setFrame:CGRectMake(280, 13, 22, 22)];
                rightImgView.tag = 12;
                [cell.contentView addSubview:rightImgView];
            }
            UILabel *labLeft = (UILabel*)[cell viewWithTag:10];
            NSString *temStr = @"";
            NSString *rightStr = [NSString stringWithFormat:@"（可用 ￥%@元）",[[[XtomManager sharedManager] motherInfor] objectForKey:@"feeaccount"]];
            temStr = [NSString stringWithFormat:@"余额支付%@",rightStr];
            NSMutableAttributedString *str = [[[NSMutableAttributedString alloc] initWithString:temStr]autorelease];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0,[temStr length]-[rightStr length])];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange([temStr length]-[rightStr length],[rightStr length])];
            [str addAttribute:NSForegroundColorAttributeName value:BB_Blake range:NSMakeRange(0,[temStr length]-[rightStr length])];
            [str addAttribute:NSForegroundColorAttributeName value:BB_Gray range:NSMakeRange([temStr length]-[rightStr length],[rightStr length])];
            [labLeft setAttributedText:str];
            UIImageView *rightImgView = (UIImageView*)[cell viewWithTag:12];
            if (selectIndex == indexPath.row)
            {
                [rightImgView setImage:[UIImage imageNamed:@"支付方式_选中.png"]];
                [XtomFunction addbordertoView:rightImgView radius:0.0f width:0.0f color:[UIColor clearColor]];
            }
            else
            {
                [rightImgView setImage:nil];
                [XtomFunction addbordertoView:rightImgView radius:11.0f width:1.0f color:BB_Graylight];
            }
            return cell;
        }
        if (1 == indexPath.row)
        {
            static NSString *CellIdentifier = @"OrderCell01";
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
                [labLeft setFrame:CGRectMake(13, 0, 150, 48.5)];
                [labLeft setText:@"选择其他支付方式"];
                [cell.contentView addSubview:labLeft];
            }
            return cell;
        }
        static NSString * CellIdentifier = @"OrderCell02";
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
        if (2 == indexPath.row)
        {
            [leftImgView setFrame:CGRectMake(13, 29, 56, 19.9)];
            [leftImgView setImage:[UIImage imageNamed:@"支付宝.png"]];
        }
        if (3 == indexPath.row)
        {
            [leftImgView setFrame:CGRectMake(15, 24, 51, 27.5)];
            [leftImgView setImage:[UIImage imageNamed:@"银联.png"]];
        }
        if (4 == indexPath.row)
        {
            [leftImgView setFrame:CGRectMake(23, 20, 36, 36)];
            [leftImgView setImage:[UIImage imageNamed:@"微信充值.png"]];
        }
        UILabel *labLeft = (UILabel*)[cell viewWithTag:10];
        labLeft.frame = CGRectMake(80, 20, 200, 17);
        labLeft.text = [temArr objectAtIndex:indexPath.row-2];
        UILabel *labRight = (UILabel*)[cell viewWithTag:11];
        labRight.frame = CGRectMake(80, 43, 200, 14);
        labRight.text = [temArr1 objectAtIndex:indexPath.row-2];
        UIImageView *rightImgView = (UIImageView*)[cell viewWithTag:12];
        if (selectIndex == indexPath.row)
        {
            [rightImgView setImage:[UIImage imageNamed:@"支付方式_选中.png"]];
            [XtomFunction addbordertoView:rightImgView radius:0.0f width:0.0f color:[UIColor clearColor]];
        }
        else
        {
            [rightImgView setImage:nil];
            [XtomFunction addbordertoView:rightImgView radius:11.0f width:1.0f color:BB_Graylight];
        }
        
        return cell;
    }
    if (isReality)
    {
        if (sectionNum-2 == indexPath.section)
        {
            static NSString * CellIdentifier = @"OrderCell1000";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if(cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = BB_White_Color;
                
                UILabel * labLeft = [[[UILabel alloc] init] autorelease];
                labLeft.backgroundColor = [UIColor clearColor];
                labLeft.textAlignment = NSTextAlignmentRight;
                labLeft.font = [UIFont systemFontOfSize:12];
                labLeft.textColor = BB_Blake;
                [labLeft setFrame:CGRectMake(13, 0, WIDTH-26, 45)];
                labLeft.tag = 10;
                [cell.contentView addSubview:labLeft];
            }
            UILabel * labLeft = (UILabel *)[cell viewWithTag:10];
            if (isReality)
            {
                if ([keytype integerValue] == 1)
                {
                    CGFloat goodsTotalFee = 0;
                    CGFloat yunTotalFee = 0;
                    CGFloat goodsFee = 0;
                    CGFloat yunFee = 0;
                    for (int i = 0; i < dataSource.count; i++)
                    {
                        NSMutableArray * temArr = [dataSource objectAtIndex:i];
                        yunFee = 0;
                        for (int j = 0; j < temArr.count; j++)
                        {
                            NSMutableDictionary * temDict = [temArr objectAtIndex:j];
                            goodsFee = [[temDict objectForKey:@"price"] floatValue]*[[temDict objectForKey:@"buycount"] integerValue];
                            goodsTotalFee = goodsFee + goodsTotalFee;
                            if (yunFee < [[temDict objectForKey:@"expressfee"] floatValue])
                            {
                                if (goodsFee>=[[temDict objectForKey:@"expressforfree"] floatValue])
                                {
                                    continue;
                                }
                                yunFee = [[temDict objectForKey:@"expressfee"] floatValue];
                            }
                        }
                        yunTotalFee = yunTotalFee + yunFee;
                    }
                    labLeft.text = [NSString stringWithFormat:@"总计(包含运费):%.2f元", goodsTotalFee+yunTotalFee];
                    NSString * price = [NSString stringWithFormat:@"%.2f", goodsTotalFee+yunTotalFee];
                    NSString * price1 = [NSString stringWithFormat:@"%.2f元", goodsTotalFee+yunTotalFee];
                    NSMutableAttributedString *str = [[[NSMutableAttributedString alloc] initWithString:labLeft.text]autorelease];
                    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[labLeft.text rangeOfString:price]];
                    [str addAttribute:NSForegroundColorAttributeName value:BB_Button_Color range:[labLeft.text rangeOfString:price1]];
                    [labLeft setAttributedText:str];
                }
                else
                {
                    
                }
            }
            return cell;
        }
    }
    if ([keytype integerValue] != 3)
    {
        if (isReality)
        {
            if (0 == indexPath.section)
            {
                static NSString *CellIdentifier = @"OrderCell03";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if(cell == nil)
                {
                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.backgroundColor = [UIColor clearColor];
                    UIView * defaultView = [[[UIView alloc] init] autorelease];
                    defaultView.frame = CGRectMake(0, 0, WIDTH, 80);
                    defaultView.backgroundColor = [UIColor colorWithRed:255/255.f green:113/255.f blue:63/255.f alpha:1];
                    defaultView.tag = 1;
                    [cell.contentView addSubview:defaultView];
                    [defaultView setHidden:YES];
                    UIImageView * headImage = [[[UIImageView alloc] init] autorelease];
                    headImage.frame = CGRectMake(15, 18.5, 16.5, 16.5);
                    headImage.image = [UIImage imageNamed:@"地址_名称图标.png"];
                    headImage.userInteractionEnabled = YES;
                    [defaultView addSubview:headImage];
                    UILabel * name = [[[UILabel alloc] init] autorelease];
                    name.tag = 2;
                    name.frame = CGRectMake(38.5, 14, 90, 23);
                    name.textColor = [UIColor whiteColor];
                    name.textAlignment = NSTextAlignmentLeft;
                    name.font = [UIFont systemFontOfSize:15];
                    [defaultView addSubview:name];
                    UIImageView * telImage = [[[UIImageView alloc] init] autorelease];
                    telImage.frame = CGRectMake(133.5, 18.5, 16.5, 16.5);
                    telImage.image = [UIImage imageNamed:@"地址_电话图标.png"];
                    telImage.userInteractionEnabled = YES;
                    [defaultView addSubview:telImage];
                    UILabel * tel = [[[UILabel alloc] init] autorelease];
                    tel.tag = 3;
                    tel.frame = CGRectMake(153.5, 14, WIDTH-185, 23);
                    tel.textColor = [UIColor whiteColor];
                    tel.textAlignment = NSTextAlignmentLeft;
                    tel.font = [UIFont systemFontOfSize:15];
                    [defaultView addSubview:tel];
                    tel.backgroundColor = [UIColor clearColor];
                    UILabel * address = [[[UILabel alloc] init] autorelease];
                    address.tag = 4;
                    address.textColor = [UIColor whiteColor];
                    address.textAlignment = NSTextAlignmentLeft;
                    address.font = [UIFont systemFontOfSize:15];
                    address.numberOfLines = 0;
                    [defaultView addSubview:address];
                    UIView * noDefaultView = [[[UIView alloc] init] autorelease];
                    noDefaultView.frame = CGRectMake(0, 0, WIDTH, 60);
                    noDefaultView.backgroundColor = [UIColor colorWithRed:255/255.f green:113/255.f blue:63/255.f alpha:1];
                    [cell.contentView addSubview:noDefaultView];
                    noDefaultView.tag = 5;
                    [noDefaultView setHidden:YES];
                    UILabel *labNo = [[[UILabel alloc]init]autorelease];
                    labNo.backgroundColor = [UIColor clearColor];
                    labNo.textAlignment = NSTextAlignmentLeft;
                    labNo.font = [UIFont systemFontOfSize:14];
                    labNo.textColor = [UIColor whiteColor];
                    [labNo setFrame:CGRectMake(45, 0, 200, 60)];
                    labNo.text = @"添加收货地址";
                    [noDefaultView addSubview:labNo];
                    UIImageView * addView = [[[UIImageView alloc]init]autorelease];
                    [addView setImage:[UIImage imageNamed:@"添加地址.png"]];
                    [addView setFrame:CGRectMake(14, 17.5, 24.5, 25)];
                    [noDefaultView addSubview:addView];
                }
                UIView * defaultView = (UIView *)[cell viewWithTag:1];
                UILabel * name = (UILabel *)[cell viewWithTag:2];
                UILabel * tel = (UILabel *)[cell viewWithTag:3];
                UILabel * address = (UILabel *)[cell viewWithTag:4];
                UIView * noDefaultView = (UIView *)[cell viewWithTag:5];
                if (![XtomFunction xfunc_check_strEmpty:[addressDic objectForKey:@"name"]])
                {
                    [defaultView setHidden:NO];
                    [noDefaultView setHidden:YES];
                    [name setText:[addressDic objectForKey:@"name"]];
                    [tel setText:[addressDic objectForKey:@"tel"]];
                    [address setText:[NSString stringWithFormat:@"%@%@", [addressDic objectForKey:@"position"], [addressDic objectForKey:@"address"]]];
                    CGSize addressSize = [XtomFunction getSizeWithStrNo:address.text width:WIDTH-71 font:16];
                    address.frame = CGRectMake(15, 42, WIDTH-71, addressSize.height);
                    defaultView.frame = CGRectMake(0, 0, WIDTH, 42+addressSize.height+10);
                }
                else
                {
                    [defaultView setHidden:YES];
                    [noDefaultView setHidden:NO];
                }
                return cell;
            }
            if ([keytype integerValue] == 1)
            {
                NSMutableArray * temArr = [dataSource objectAtIndex:indexPath.section-1];
                if (0 == indexPath.row)
                {
                    static NSString *CellIdentifier = @"OrderCell0400";
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    if(cell == nil)
                    {
                        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        [cell setSeparatorInset:UIEdgeInsetsMake(0, 13, 0, 0)];
                        cell.backgroundColor = BB_White_Color;
                    }
                    cell.textLabel.text = dataSource[indexPath.section-1][0][@"shop_name"];
                    cell.textLabel.textColor = BB_Blake;
                    return cell;
                }
                if (temArr.count+1 == indexPath.row)
                {
                    static NSString *CellIdentifier = @"OrderCell04";
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
                        labLeft.font = [UIFont systemFontOfSize:18];
                        labLeft.textColor = BB_Blake;
                        labLeft.tag = 10;
                        [cell.contentView addSubview:labLeft];
                        UILabel *labRight = [[[UILabel alloc]init]autorelease];
                        labRight.backgroundColor = [UIColor clearColor];
                        labRight.textAlignment = NSTextAlignmentRight;
                        labRight.textColor = BB_Gray;
                        labRight.numberOfLines = 0;
                        labRight.font = [UIFont systemFontOfSize:16];
                        labRight.tag = 11;
                        [cell.contentView addSubview:labRight];
                    }
                    UILabel *labLeft = (UILabel*)[cell viewWithTag:10];
                    labLeft.text = @"运费";
                    UILabel *labRight = (UILabel*)[cell viewWithTag:11];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    [labRight setFrame:CGRectMake(110, 0, 196, 48)];
                    [labLeft setFrame:CGRectMake(13, 0, 90, 48)];
                    CGFloat goodsTotalFee = 0;
                    CGFloat yunTotalFree = 0;
                    CGFloat goodsFee = 0;
                    CGFloat yunFee = 0;
                    BOOL isFree = YES;
                    for (int i = 0; i < temArr.count; i++)
                    {
                        NSMutableDictionary * temDict = [temArr objectAtIndex:i];
                        goodsFee = [[temDict objectForKey:@"price"] floatValue]*[[temDict objectForKey:@"buycount"] integerValue];
                        if (goodsFee>=[[temDict objectForKey:@"expressforfree"] floatValue])
                        {
                            yunFee = 0;
                        }
                        else
                        {
                            isFree = NO;
                            yunFee = [[temDict objectForKey:@"expressfee"] floatValue]*[[temDict objectForKey:@"buycount"] integerValue];
                        }
                        goodsTotalFee = goodsFee + goodsTotalFee;
                        yunTotalFree = yunTotalFree + yunFee;
                    }
                    if (isFree)
                    {
                        [labRight setText:@"包邮"];
                    }
                    else
                    {
                        [labRight setText:[NSString stringWithFormat:@"%.2f元", yunTotalFree]];
                    }
                    return cell;
                }
                if (temArr.count+2 == indexPath.row)
                {
                    static NSString *CellIdentifier = @"OrderCell05";
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    if(cell == nil)
                    {
                        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        cell.backgroundColor = BB_White_Color;
                        [cell setSeparatorInset:UIEdgeInsetsMake(0, 13, 0, 0)];
                        UILabel *labLeft = [[[UILabel alloc]init]autorelease];
                        labLeft.backgroundColor = [UIColor clearColor];
                        labLeft.textAlignment = NSTextAlignmentRight;
                        labLeft.font = [UIFont systemFontOfSize:15];
                        labLeft.textColor = BB_Blake;
                        [labLeft setFrame:CGRectMake(50, 0, 256, 50)];
                        labLeft.tag = 10;
                        [cell.contentView addSubview:labLeft];
                    }
                    UILabel *labLeft = (UILabel*)[cell viewWithTag:10];
                    NSString *temStr = @"";
                    NSString *rightStr = @"";
                    CGFloat goodsTotalFee = 0;
                    CGFloat yunTotalFree = 0;
                    CGFloat goodsFee = 0;
                    CGFloat yunFee = 0;
                    BOOL isFree = YES;
                    NSInteger buycountAll = 0;
                    for (int i = 0; i < temArr.count; i++)
                    {
                        NSMutableDictionary * temDict = [temArr objectAtIndex:i];
                        goodsFee = [[temDict objectForKey:@"price"] floatValue]*[[temDict objectForKey:@"buycount"] integerValue];
                        if (goodsFee>=[[temDict objectForKey:@"expressforfree"] floatValue])
                        {
                            yunFee = 0;
                        }
                        else
                        {
                            isFree = NO;
                            yunFee = [[temDict objectForKey:@"expressfee"] floatValue]*[[temDict objectForKey:@"buycount"] integerValue];
                        }
                        goodsTotalFee = goodsFee + goodsTotalFee;
                        yunTotalFree = yunTotalFree + yunFee;
                        buycountAll = buycountAll + [[temDict objectForKey:@"buycount"] integerValue];
                    }
                    if (isFree)
                    {
                        rightStr = [NSString stringWithFormat:@"%.2f",goodsTotalFee];
                    }
                    else
                    {
                        rightStr = [NSString stringWithFormat:@"%.2f", goodsTotalFee + yunTotalFree];
                    }
                    temStr = [NSString stringWithFormat:@"共%zd件  合计：%@元",buycountAll,rightStr];
                    NSMutableAttributedString *str = [[[NSMutableAttributedString alloc] initWithString:temStr]autorelease];
                    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0,[temStr length]-[rightStr length])];
                    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange([temStr length]-[rightStr length],[rightStr length])];
                    [labLeft setAttributedText:str];
                    return cell;
                }
                static NSString *CellIdentifier = @"OrderCell06";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if(cell == nil)
                {
                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = BB_White_Color;
                    [cell setSeparatorInset:UIEdgeInsetsMake(0, 13, 0, 0)];
                    UIImageView * logoImage = [[[UIImageView alloc] init] autorelease];
                    logoImage.userInteractionEnabled = NO;
                    [XtomFunction addbordertoView:logoImage radius:2 width:0.5 color:BB_lineColor];
                    logoImage.frame = CGRectMake(11, 10, 70, 60);
                    logoImage.contentMode = UIViewContentModeScaleAspectFill;
                    [logoImage setClipsToBounds:YES];
                    [cell.contentView addSubview:logoImage];
                    logoImage.tag = 100;
                    UILabel * goodsTitle = [[[UILabel alloc]init]autorelease];
                    goodsTitle.backgroundColor = [UIColor clearColor];
                    goodsTitle.textAlignment = NSTextAlignmentLeft;
                    goodsTitle.font = [UIFont systemFontOfSize:15];
                    goodsTitle.textColor = BB_Blake;
                    [goodsTitle setFrame:CGRectMake(90, 10, WIDTH-190, 23)];
                    goodsTitle.tag = 1;
                    goodsTitle.numberOfLines = 0;
                    [cell.contentView addSubview:goodsTitle];
                    UILabel * goodsPrice = [[[UILabel alloc]init]autorelease];
                    goodsPrice.backgroundColor = [UIColor clearColor];
                    goodsPrice.textAlignment = NSTextAlignmentRight;
                    goodsPrice.font = [UIFont systemFontOfSize:15];
                    goodsPrice.textColor = BB_Button_Color;
                    [goodsPrice setFrame:CGRectMake(WIDTH-100, 7.5, 90, 32)];
                    goodsPrice.tag = 3;
                    [cell.contentView addSubview:goodsPrice];
                    UILabel * goodsNum = [[[UILabel alloc]init]autorelease];
                    goodsNum.backgroundColor = [UIColor clearColor];
                    goodsNum.textAlignment = NSTextAlignmentRight;
                    goodsNum.font = [UIFont systemFontOfSize:13];
                    goodsNum.textColor = BB_Blake;
                    [goodsNum setFrame:CGRectMake(WIDTH-100, 40, 90, 28)];
                    goodsNum.tag = 4;
                    [cell.contentView addSubview:goodsNum];
                }
                NSMutableDictionary * temDict = [[dataSource objectAtIndex:indexPath.section-1] objectAtIndex:indexPath.row-1];
                UIImageView * logoImage = (UIImageView *)[cell viewWithTag:100];
                logoImage.image = [UIImage imageNamed:@"商城_默认广告页3.png"];
                NSString *downavatar = [temDict objectForKey:@"imgurl"];
                if(![XtomFunction xfunc_check_strEmpty:downavatar])
                {
                    NSString *document = [NSString stringWithFormat:@"%@/%@",BB_CASH_DOCUMENT,BB_CASH_AVATAR];
                    [[XtomCashManager sharedManager] addImgToImgViewFromDocumentORURL:logoImage document:document url:downavatar];
                }
                UILabel * goodsTitle = (UILabel *)[cell viewWithTag:1];
                goodsTitle.text = [temDict objectForKey:@"name"];
                CGSize size = [XtomFunction getSizeWithStrNo:goodsTitle.text width:WIDTH-190 font:15];
                [goodsTitle setFrame:CGRectMake(90, 10, WIDTH-190, size.height)];
                UILabel * goodsPrice = (UILabel *)[cell viewWithTag:3];
                goodsPrice.text = [NSString stringWithFormat:@"%@元", [temDict objectForKey:@"price"]];
                UILabel * goodsNum = (UILabel *)[cell viewWithTag:4];
                goodsNum.text = [NSString stringWithFormat:@"X%@", [temDict objectForKey:@"buycount"]];
                return cell;
            }
            else
            {
                NSMutableDictionary * temDict = [dataSource objectAtIndex:0];
                if (0 == indexPath.row)
                {
                    static NSString *CellIdentifier = @"OrderCell0400";
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    
                    if(cell == nil)
                    {
                        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        [cell setSeparatorInset:UIEdgeInsetsMake(0, 13, 0, 0)];
                        cell.backgroundColor = BB_White_Color;
                    }
                    cell.textLabel.text = temDict[@"shopInfo"][0][@"shop_name"];
                    cell.textLabel.textColor = BB_Blake;
                    return cell;
                }
                if (1 == indexPath.row)
                {
                    static NSString *CellIdentifier = @"OrderCell07";
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    if(cell == nil)
                    {
                        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        cell.backgroundColor = BB_White_Color;
                        [cell setSeparatorInset:UIEdgeInsetsMake(0, 13, 0, 0)];
                        UIImageView * logoImage = [[[UIImageView alloc] init] autorelease];
                        logoImage.userInteractionEnabled = NO;
                        [XtomFunction addbordertoView:logoImage radius:2 width:0.5 color:BB_lineColor];
                        logoImage.frame = CGRectMake(11, 10, 70, 60);
                        logoImage.contentMode = UIViewContentModeScaleAspectFill;
                        [logoImage setClipsToBounds:YES];
                        [cell.contentView addSubview:logoImage];
                        logoImage.tag = 100;
                        UILabel * goodsTitle = [[[UILabel alloc]init]autorelease];
                        goodsTitle.backgroundColor = [UIColor clearColor];
                        goodsTitle.textAlignment = NSTextAlignmentLeft;
                        goodsTitle.font = [UIFont systemFontOfSize:15];
                        goodsTitle.textColor = BB_Blake;
                        [goodsTitle setFrame:CGRectMake(90, 10, WIDTH-190, 23)];
                        goodsTitle.tag = 1;
                        goodsTitle.numberOfLines = 0;
                        [cell.contentView addSubview:goodsTitle];
                        UILabel * goodsPrice = [[[UILabel alloc]init]autorelease];
                        goodsPrice.backgroundColor = [UIColor clearColor];
                        goodsPrice.textAlignment = NSTextAlignmentRight;
                        goodsPrice.font = [UIFont systemFontOfSize:15];
                        goodsPrice.textColor = BB_Button_Color;
                        [goodsPrice setFrame:CGRectMake(WIDTH-100, 7.5, 90, 32)];
                        goodsPrice.tag = 3;
                        [cell.contentView addSubview:goodsPrice];
                        UILabel * goodsNum = [[[UILabel alloc]init]autorelease];
                        goodsNum.backgroundColor = [UIColor clearColor];
                        goodsNum.textAlignment = NSTextAlignmentRight;
                        goodsNum.font = [UIFont systemFontOfSize:12];
                        goodsNum.textColor = BB_Blake;
                        [goodsNum setFrame:CGRectMake(WIDTH-100, 40, 90, 28)];
                        goodsNum.tag = 4;
                        [cell.contentView addSubview:goodsNum];
                    }
                    UIImageView * logoImage = (UIImageView *)[cell viewWithTag:100];
                    logoImage.image = [UIImage imageNamed:@"商城_默认广告页3.png"];
                    NSString *downavatar = [temDict objectForKey:@"imgurl"];
                    if(![XtomFunction xfunc_check_strEmpty:downavatar])
                    {
                        NSString *document = [NSString stringWithFormat:@"%@/%@",BB_CASH_DOCUMENT,BB_CASH_AVATAR];
                        [[XtomCashManager sharedManager] addImgToImgViewFromDocumentORURL:logoImage document:document url:downavatar];
                    }
                    UILabel * goodsTitle = (UILabel *)[cell viewWithTag:1];
                    goodsTitle.text = [temDict objectForKey:@"name"];
                    CGSize size = [XtomFunction getSizeWithStrNo:goodsTitle.text width:WIDTH-190 font:15];
                    [goodsTitle setFrame:CGRectMake(90, 10, WIDTH-190, size.height)];
                
                    UILabel * goodsPrice = (UILabel *)[cell viewWithTag:3];
                    goodsPrice.text = [NSString stringWithFormat:@"%@元", [temDict objectForKey:@"price"]];
                    UILabel * goodsNum = (UILabel *)[cell viewWithTag:4];
                    goodsNum.text = [NSString stringWithFormat:@"X%zd", buycount];
                    return cell;
                }
                if (2 == indexPath.row)
                {
                    static NSString *CellIdentifier = @"OrderCell08";
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
                        labLeft.tag = 10;
                        [cell.contentView addSubview:labLeft];
                        UILabel *labRight = [[[UILabel alloc]init]autorelease];
                        labRight.backgroundColor = [UIColor clearColor];
                        labRight.textAlignment = NSTextAlignmentRight;
                        labRight.textColor = BB_Gray;
                        labRight.numberOfLines = 0;
                        labRight.font = [UIFont systemFontOfSize:13];
                        labRight.tag = 11;
                        [cell.contentView addSubview:labRight];
                    }
                    UILabel *labLeft = (UILabel*)[cell viewWithTag:10];
                    labLeft.text = @"运费";
                    UILabel *labRight = (UILabel*)[cell viewWithTag:11];
                    [labRight setFrame:CGRectMake(110, 0, 196, 48)];
                    [labLeft setFrame:CGRectMake(13, 0, 90, 48)];
                    CGFloat goodTotal = [[temDict objectForKey:@"price"] floatValue]*buycount;
                    CGFloat yunFree = [[temDict objectForKey:@"expressforfree"] floatValue];
                    if (goodTotal>=yunFree)
                    {
                        [labRight setText:@"包邮"];
                    }
                    else
                    {
                        [labRight setText:[NSString stringWithFormat:@"%.2f元", [[temDict objectForKey:@"expressfee"] floatValue]]];
                    }
                    return cell;
                }
                if (3 == indexPath.row)
                {
                    static NSString *CellIdentifier = @"OrderCell09";
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    if(cell == nil)
                    {
                        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        cell.backgroundColor = BB_White_Color;
                        [cell setSeparatorInset:UIEdgeInsetsMake(0, 13, 0, 0)];
                        UILabel *labLeft = [[[UILabel alloc]init]autorelease];
                        labLeft.backgroundColor = [UIColor clearColor];
                        labLeft.textAlignment = NSTextAlignmentRight;
                        labLeft.font = [UIFont systemFontOfSize:15];
                        labLeft.textColor = BB_Blake;
                        [labLeft setFrame:CGRectMake(50, 0, 256, 50)];
                        labLeft.tag = 10;
                        [cell.contentView addSubview:labLeft];
                    }
                    UILabel *labLeft = (UILabel*)[cell viewWithTag:10];
                    NSString *temStr = @"";
                    NSString *rightStr = @"";
                    CGFloat goodTotal = [[temDict objectForKey:@"price"] floatValue]*buycount;
                    CGFloat yunFree = [[temDict objectForKey:@"expressforfree"] floatValue];
                    if (![XtomFunction xfunc_check_strEmpty:[temDict objectForKey:@"expressfee"]])
                    {
                        if (goodTotal>=yunFree)
                        {
                            rightStr = [NSString stringWithFormat:@"￥%.2f",goodTotal];
                        }
                        else
                        {
                            rightStr = [NSString stringWithFormat:@"￥%.2f",goodTotal + [[temDict objectForKey:@"expressfee"] floatValue]];
                        }
                    }
                    else
                    {
                        rightStr = [NSString stringWithFormat:@"￥%.2f",goodTotal];
                    }
                    temStr = [NSString stringWithFormat:@"共%zd件  合计：%@元",buycount,rightStr];
                    NSMutableAttributedString *str = [[[NSMutableAttributedString alloc] initWithString:temStr]autorelease];
                    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0,[temStr length]-[rightStr length])];
                    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange([temStr length]-[rightStr length],[rightStr length])];
                    [labLeft setAttributedText:str];
                    return cell;
                }
            }
        }
        else
        {
            if (0 == indexPath.row)
            {
                static NSString * cellID = @"OrderCell10";
                UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                if(cell == nil)
                {
                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = BB_White_Color;
                    UIImageView *logoImage = [[[UIImageView alloc] init] autorelease];
                    logoImage.userInteractionEnabled = YES;
                    [XtomFunction addbordertoView:logoImage radius:0 width:0.5 color:BB_lineColor];
                    logoImage.frame = CGRectMake(0, 10, 82.5, 65);
                    [cell.contentView addSubview:logoImage];
                    logoImage.contentMode = UIViewContentModeScaleAspectFill;
                    [logoImage setClipsToBounds:YES];
                    logoImage.tag = 4;
                    UILabel * goodsTitle = [[[UILabel alloc]init]autorelease];
                    goodsTitle.backgroundColor = [UIColor clearColor];
                    goodsTitle.textAlignment = NSTextAlignmentLeft;
                    goodsTitle.font = [UIFont systemFontOfSize:16];
                    goodsTitle.textColor = BB_Blake;
                    [goodsTitle setFrame:CGRectMake(90, 5, WIDTH-100, 45)];
                    goodsTitle.tag = 1;
                    [cell.contentView addSubview:goodsTitle];
                    UILabel * goodsPrice = [[[UILabel alloc]init]autorelease];
                    goodsPrice.backgroundColor = [UIColor clearColor];
                    goodsPrice.textAlignment = NSTextAlignmentLeft;
                    goodsPrice.font = [UIFont systemFontOfSize:21];
                    goodsPrice.textColor = BB_Button_Color;
                    [goodsPrice setFrame:CGRectMake(90, 53, 80, 27)];
                    goodsPrice.tag = 2;
                    [cell.contentView addSubview:goodsPrice];
                    UILabel * goodsNum = [[[UILabel alloc]init]autorelease];
                    goodsNum.backgroundColor = [UIColor clearColor];
                    goodsNum.textAlignment = NSTextAlignmentLeft;
                    goodsNum.font = [UIFont systemFontOfSize:12];
                    goodsNum.textColor = BB_Blake;
                    [goodsNum setFrame:CGRectMake(190, 60, 90, 20)];
                    goodsNum.tag = 3;
                    [cell.contentView addSubview:goodsNum];
                }
                UIImageView *logoImage = (UIImageView *)[cell viewWithTag:4];
                UILabel * goodsTitle = (UILabel *)[cell viewWithTag:1];
                UILabel * goodsPrice = (UILabel *)[cell viewWithTag:2];
                UILabel * goodsNum = (UILabel *)[cell viewWithTag:3];
                NSMutableDictionary * temDict = [dataSource objectAtIndex:0];
                NSString *downavatar = [temDict objectForKey:@"imgurl0"];
                logoImage.image = [UIImage imageNamed:@"商城_默认广告页3.png"];
                if(![XtomFunction xfunc_check_strEmpty:downavatar])
                {
                    NSString *document = [NSString stringWithFormat:@"%@/%@",BB_CASH_DOCUMENT,BB_CASH_AVATAR];
                    [[XtomCashManager sharedManager] addImgToImgViewFromDocumentORURL:logoImage document:document url:downavatar];
                }
                goodsTitle.text = [temDict objectForKey:@"name"];
                goodsTitle.numberOfLines = 0;
                goodsPrice.text = [NSString stringWithFormat:@"%@元", [temDict objectForKey:@"price"]];
                NSMutableAttributedString * attrString =
                [[NSMutableAttributedString alloc] initWithString:goodsPrice.text];
                UIFont *smallFont = [UIFont systemFontOfSize:14];
                [attrString addAttribute:NSFontAttributeName value:smallFont range:[goodsPrice.text rangeOfString:@"元"]];
                goodsPrice.attributedText = attrString;
                goodsNum.text = @"X1";
                return cell;
            }
            static NSString * cellID = @"OrderCell11";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = BB_White_Color;
                UILabel *labLeft = [[[UILabel alloc]init]autorelease];
                labLeft.backgroundColor = [UIColor clearColor];
                labLeft.textAlignment = NSTextAlignmentLeft;
                labLeft.font = [UIFont systemFontOfSize:15];
                labLeft.textColor = BB_Blake;
                labLeft.tag = 10;
                [cell.contentView addSubview:labLeft];
                UILabel *labRight = [[[UILabel alloc]init]autorelease];
                labRight.backgroundColor = [UIColor clearColor];
                labRight.textAlignment = NSTextAlignmentRight;
                labRight.textColor = BB_Gray;
                labRight.numberOfLines = 0;
                labRight.font = [UIFont systemFontOfSize:13];
                labRight.tag = 11;
                [cell.contentView addSubview:labRight];
            }
            UILabel *labLeft = (UILabel*)[cell viewWithTag:10];
            labLeft.text = @"订单总额";
            UILabel *labRight = (UILabel*)[cell viewWithTag:11];
            labRight.text = [[dataSource objectAtIndex:0] objectForKey:@"price"];
            [labRight setFrame:CGRectMake(110, 0, 196, 55)];
            [labLeft setFrame:CGRectMake(13, 0, 90, 55)];
            return cell;
        }
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (sectionNum-1 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            return 56;
        }
        if (1 == indexPath.row)
        {
            return 48.5;
        }
        return 70;
    }
    if (isReality)
    {
        if (sectionNum-2 == indexPath.section)
        {
            if ([keytype integerValue] == 1)
            {
                return 45;
            }
            return 0;
        }
    }
    if ([keytype integerValue] != 3)
    {
        if (isReality)
        {
            if (0 == indexPath.section)
            {
                if ([XtomFunction xfunc_check_strEmpty:[addressDic objectForKey:@"name"]])
                {
                    return 60;
                }
                else
                {
                    CGSize addressSize = [XtomFunction getSizeWithStrNo:[NSString stringWithFormat:@"%@%@", [addressDic objectForKey:@"position"], [addressDic objectForKey:@"address"]] width:WIDTH-71 font:16];
                    return 42 + addressSize.height + 10;
                }
            }
            if ([keytype integerValue] == 1)
            {
                NSMutableArray * temArr = [dataSource objectAtIndex:indexPath.section-1];
                if (0 == indexPath.row)
                {
                    return 40;
                }
                if (temArr.count+1 == indexPath.row)
                {
                    return 48;
                }
                if (temArr.count+2 == indexPath.row)
                {
                    return 50;
                }
                return 80;
            }
            if (0 == indexPath.row)
            {
                return 40;
            }
            if (1 == indexPath.row)
            {
                return 80;
            }
            if (2 == indexPath.row)
            {
                return 48;
            }
            if (3 == indexPath.row)
            {
                return 50;
            }
        }
        else
        {
            if (0 == indexPath.row)
            {
                return 95;
            }
            return 55;
        }
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section && isReality)
    {
        UserAddressVC *list = [[[UserAddressVC alloc]init]autorelease];
        list.delegate = self;
        [self.navigationController pushViewController:list animated:YES];
    }
    if (sectionNum-1 == indexPath.section && 1 != indexPath.row)
    {
        selectIndex = indexPath.row;
        [myTableView reloadData];
    }
}
- (void)requestAddressList
{
    waitMB = [XtomFunction openHUD:@"正在加载" view:self.view];
    NSString *token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token forKey:@"token"];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_ADDRESS_LIST] target:self selector:@selector(responseAddressList:) parameter:dic];
}
- (void)responseAddressList:(NSDictionary*)info
{
    if (waitMB)
    {
        [XtomFunction closeHUD:waitMB];waitMB = nil;
    }
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        if(![XtomFunction xfunc_check_strEmpty:[[info objectForKey:@"infor"]objectForKey:@"listItems"]])
        {
            if (!addressDic)
            {
                self.addressDic = [[[NSMutableDictionary alloc]init]autorelease];
            }
            [addressDic removeAllObjects];
            
            NSMutableArray *temArr = [[info objectForKey:@"infor"]objectForKey:@"listItems"];
            
            for (int i = 0; i<1; i++)
            {
                NSDictionary *temDict = [temArr objectAtIndex:i];
                for(NSString *key in temDict.allKeys)
                {
                    NSString *value = [temDict objectForKey:key];
                    if(![XtomFunction xfunc_check_strEmpty:value])
                    {
                        [addressDic setObject:value forKey:key];
                    }
                }
            }
            [myTableView reloadData];
        }
    }
    else
    {
        if([info objectForKey:@"msg"])
        {
            [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:self.view];
        }
    }
}
- (void)requestBillSave
{
    if (isReality)
    {
        if ([XtomFunction xfunc_check_strEmpty:[addressDic objectForKey:@"id"]])
        {
            [XtomFunction openIntervalHUD:@"请填写收货地址" view:nil];
            return;
        }
    }
    waitMB = [XtomFunction openHUD:@"正在生成订单" view:self.view];
    NSString *token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token?token:@"0" forKey:@"token"];
    [dic setObject:self.keytype forKey:@"keytype"];
    if (!isReality)
    {
        [dic setObject:@"1" forKey:@"goods_type"];
    }
    else
    {
        [dic setObject:@"2" forKey:@"goods_type"];
    }
    [dic setObject:self.keyid forKey:@"keyid"];
    [dic setObject:[addressDic objectForKey:@"id"]?[addressDic objectForKey:@"id"]:@"无" forKey:@"address_id"];
    [dic setObject:[NSString stringWithFormat:@"%zd", buycount] forKey:@"buycount"];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_BILL_SAVE] target:self selector:@selector(responseBillSave:) parameter:dic];
}
- (void)responseBillSave:(NSDictionary*)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:BB_NOTIFICATION_CheRefresh object:nil userInfo:nil];
        NSString *bill_ids = [[[info objectForKey:@"infor"] objectAtIndex:0] objectForKey:@"bill_ids"];
        NSString *total_fee = [[[info objectForKey:@"infor"] objectAtIndex:0] objectForKey:@"total_fee"];
        [addressDic setObject:bill_ids forKey:@"bill_ids"];
        [addressDic setObject:total_fee forKey:@"total_fee"];
        if (0 == selectIndex)
        {
            if (waitMB)
            {
                [XtomFunction closeHUD:waitMB];waitMB = nil;
            }
            NSString * paypassword = [[[XtomManager sharedManager] motherInfor] objectForKey:@"paypassword"];
            if ([XtomFunction xfunc_check_strEmpty:paypassword])
            {
                ChangPasswordVC *set = [[[ChangPasswordVC alloc]init]autorelease];
                set.isZhiFu = YES;
                set.isFirst = YES;
                [self.navigationController pushViewController:set animated:YES];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入钱包支付密码，包含数字和字母" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
                [alert show];
                alert.tag = 1999;
                alert.delegate = self;
                [alert release];
            }
            return;
        }
        [self requestSanPay];
    }
    else
    {
        if (waitMB)
        {
            [XtomFunction closeHUD:waitMB];waitMB = nil;
        }
        if ([[info objectForKey:@"error_code"]integerValue] == 403)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[info objectForKey:@"msg"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alert.cancelButtonIndex = 0;
            [alert show];
            alert.tag = 406;
            alert.delegate = self;
            [alert release];
        }
        else
        {
            if([info objectForKey:@"msg"])
            {
                [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:self.view];
            }
        }
    }
}
- (void)requestClientAccountpay:(NSString*)paypassword
{
    waitMB = [XtomFunction openHUD:@"正在支付" view:self.view];
    NSString *token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token forKey:@"token"];
    [dic setObject:@"1" forKey:@"keytype"];
    [dic setObject:[XtomFunction encodePassword:paypassword] forKey:@"paypassword"];
    if ([keytype integerValue] == 3)
    {
        [dic setObject:self.keyid forKey:@"keyid"];
        [dic setObject:[NSString stringWithFormat:@"%@",[[dataSource objectAtIndex:0] objectForKey:@"total_fee"]] forKey:@"total_fee"];
    }
    else
    {
        [dic setObject:[addressDic objectForKey:@"bill_ids"] forKey:@"keyid"];
        [dic setObject:[addressDic objectForKey:@"total_fee"] forKey:@"total_fee"];
    }
    
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_CLIENT_ACCOUNTPAY] target:self selector:@selector(responseClientAccountpay:) parameter:dic];
}
- (void)responseClientAccountpay:(NSDictionary*)info
{
    if (waitMB)
    {
        [XtomFunction closeHUD:waitMB];waitMB = nil;
    }
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        NSString * oldFee = [[[XtomManager sharedManager] motherInfor] objectForKey:@"feeaccount"];
        CGFloat nowFee = [oldFee floatValue] - [[addressDic objectForKey:@"total_fee"] floatValue];
        [[[XtomManager sharedManager] motherInfor] setObject:[NSString stringWithFormat:@"%.2f", nowFee] forKey:@"feeaccount"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付成功" message:@"请到我的订单查看" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        alert.tag = 100;
        alert.delegate = self;
        [alert release];
    }
    else
    {
        if ([[info objectForKey:@"error_code"]integerValue] == 102)
        {
            [self failPay:@"密码错误，支付失败"];
        }else
        {
            if([info objectForKey:@"msg"])
            {
                [self failPay:[NSString stringWithFormat:@"%@，支付失败",[info objectForKey:@"msg"]]];
            }
        }
    }
}
- (void)requestSanPay
{
    NSString *token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token forKey:@"token"];
    [dic setObject:@"2" forKey:@"keytype"];
    if ([keytype integerValue] == 3)
    {
        [dic setObject:self.keyid forKey:@"keyid"];
        [dic setObject:[NSString stringWithFormat:@"%@",[[dataSource objectAtIndex:0] objectForKey:@"total_fee"]] forKey:@"total_fee"];
    }
    else
    {
        [dic setObject:[addressDic objectForKey:@"bill_ids"] forKey:@"keyid"];
        [dic setObject:[addressDic objectForKey:@"total_fee"] forKey:@"total_fee"];
    }
    if (4 == selectIndex)
    {
        [dic setObject:@"1" forKey:@"paytype"];
        [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@OnlinePay/Weixinpay/weixinpay_get.php",[[[XtomManager sharedManager] myinitInfor] objectForKey:@"sys_plugins"]] target:self selector:@selector(responseSanPay:) parameter:dic];
    }
    if (3 == selectIndex)
    {
        [dic setObject:@"2" forKey:@"paytype"];
        [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@OnlinePay/Unionpay/unionpay_get.php",[[[XtomManager sharedManager] myinitInfor] objectForKey:@"sys_plugins"]] target:self selector:@selector(responseSanPay:) parameter:dic];
    }
    if (2 == selectIndex)
    {
        [dic setObject:@"3" forKey:@"paytype"];
        [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@OnlinePay/Alipay/alipaysign_get.php",[[[XtomManager sharedManager] myinitInfor] objectForKey:@"sys_plugins"]] target:self selector:@selector(responseSanPay:) parameter:dic];
    }
}
- (void)responseSanPay:(NSDictionary*)info
{
    if (waitMB)
    {
        [XtomFunction closeHUD:waitMB];waitMB = nil;
    }
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        if (4 == selectIndex)
        {
            NSMutableDictionary *temDic = [[info objectForKey:@"infor"]objectAtIndex:0];
            [WXApi registerApp:[temDic objectForKey:@"appid"]];
            PayReq *request = [[[PayReq alloc] init] autorelease];
            request.partnerId = [temDic objectForKey:@"partnerid"];
            request.prepayId= [temDic objectForKey:@"prepayid"];
            request.package = [temDic objectForKey:@"package"];
            request.nonceStr= [temDic objectForKey:@"noncestr"];
            request.timeStamp= [[temDic objectForKey:@"timestamp"]intValue];
            request.sign= [temDic objectForKey:@"sign"];
            [WXApi sendReq:request];
        }
        if (3 == selectIndex)
        {
            NSString *orderStr = [[[info objectForKey:@"infor"]objectAtIndex:0]objectForKey:@"tn"];
            [UPPayPlugin startPay:orderStr mode:BB_XCONST_IS_YLCeshi viewController:self delegate:self];
        }
        if (2 == selectIndex)
        {
            NSString *appScheme = @"haoyangmao";
            NSString *orderStr = [[[info objectForKey:@"infor"]objectAtIndex:0]objectForKey:@"alipaysign"];
            [[AlipaySDK defaultService] payOrder:orderStr fromScheme:appScheme callback:^(NSDictionary *resultDic)
             {
                 if ([[resultDic objectForKey:@"resultStatus"] integerValue] == 6001)
                 {
                     [self getFailMessage];
                 }
             }];
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
