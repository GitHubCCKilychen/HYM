//
//  UserOrderListVC.m
//  PingChuan
//
//  Created by pengli on 15/10/21.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "UserOrderListVC.h"
#import "BBButton.h"
#import "OrderGoodCell.h"
#import "OrderDetailVC.h"
#import "RefundListVC.h"
#import "OrderCreateVC.h"

@interface UserOrderListVC ()<UIAlertViewDelegate>
{
    MBProgressHUD *waitMB;
    BOOL isEnd;
    NSInteger currentPage;
    NSInteger touchSection;
    NSTimer * _timer;
}
@property(nonatomic,retain)NSMutableArray *dataSource;

@end

@implementation UserOrderListVC
@synthesize dataSource;
@synthesize keytype;

-(void)dealloc
{
    [dataSource release];dataSource = nil;
    [keytype release];keytype = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BB_NOTIFICATION_OrderRefresh object:nil];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadSet];
}

-(void)loadSet
{
    self.view.backgroundColor = BB_Back_Color_Here;
    [self.navigationItem setNewTitle:@"订单列表"];
    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftBtnPressed:) image:@"common_return.png" imageH:@"common_return.png.png"];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderMessage:) name:BB_NOTIFICATION_OrderRefresh object:nil];
    [mytable setFrame:CGRectMake(0, 0, WIDTH, UI_View_Hieght-53.5)];
    [footerView setFrame:CGRectMake(0, UI_View_Hieght-53.5, WIDTH, 30)];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshActivityList) userInfo:nil repeats:YES];
}


- (void)refreshActivityList
{
    if (dataSource.count > 0)
    {
        for (int i = 0; i < dataSource.count; i++)
        {
            NSMutableDictionary * temDic = [dataSource objectAtIndex:i];
            if ([[temDic objectForKey:@"tradetype"] integerValue] == 0)
            {
                
                NSString *end_last_time = [temDic objectForKey:@"left_seconds"];
                NSLog(@"%@", end_last_time);
                if (![XtomFunction xfunc_check_strEmpty:end_last_time])
                {
                    int carttime=[[temDic objectForKey:@"left_seconds"] intValue];
                    
                    if (carttime>=1)
                    {
                        carttime--;
                        
                        [temDic setValue:[NSString stringWithFormat:@"%d",carttime] forKey:@"left_seconds"];
                    }
                    else
                    {
                        if (_timer)
                        {
                            [_timer invalidate]; _timer = nil;
                        }
                        [self requestBillList];
                    }
                }
                
            }
        }
        [mytable reloadData];
    }
}

- (void)getmyData
{
    [self refresh];
}

-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)cancelBtnPressed:(BBButton *)button
{
    touchSection = button.btnSection;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"取消订单" message:@"确定要取消您的订单吗？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"确定", nil];
    alert.cancelButtonIndex = 0;
    [alert show];
    alert.tag = 200;
    alert.delegate = self;
    [alert release];
}


- (void)deleteBtnPressed:(BBButton *)button
{
    touchSection = button.btnSection;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"删除订单" message:@"一旦删除，不可恢复" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"确定", nil];
    alert.cancelButtonIndex = 0;
    [alert show];
    alert.tag = 100;
    alert.delegate = self;
    [alert release];
}


- (void)gotoRefund:(BBButton *)button
{
    touchSection = button.btnSection;
    UIViewController *temVC = self;
    if(!self.navigationController)
    {
        UIView *view = self.view.superview;
        temVC = [XtomFunction traverseResponderChainForUIViewController:view];
    }
    RefundListVC * refund = [[[RefundListVC alloc] init] autorelease];
    refund.keyid = [[dataSource objectAtIndex:touchSection] objectForKey:@"id"];
    refund.keytype = @"1";
    [temVC.navigationController pushViewController:refund animated:YES];
}


- (void)payBtnPressed:(BBButton *)button
{
    UIViewController *temVC = self;
    if(!self.navigationController)
    {
        UIView *view = self.view.superview;
        temVC = [XtomFunction traverseResponderChainForUIViewController:view];
    }
    touchSection = button.btnSection;
    NSMutableDictionary *temDic = [dataSource objectAtIndex:touchSection];
    OrderCreateVC * create = [[[OrderCreateVC alloc]init]autorelease];
    create.keytype = @"3";
    create.sectionNum = 1;
    create.keyid = [temDic objectForKey:@"id"];
    create.dataSource = [NSMutableArray arrayWithObjects:temDic, nil];
    [temVC.navigationController pushViewController:create animated:YES];
}


-(void)sureBtnPressed:(BBButton*)sender
{
    touchSection = sender.btnSection;
    NSMutableDictionary * temDict = [dataSource objectAtIndex:touchSection];
    if ([[temDict objectForKey:@"sendflag"] integerValue] == 0)
    {
        [XtomFunction openIntervalHUD:@"抱歉，商家未发货" view:self.view];
        return;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认收货" message:@"一旦确定，不可更改" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"确定", nil];
    alert.cancelButtonIndex = 0;
    [alert show];
    alert.tag = 300;
    alert.delegate = self;
    [alert release];
}


-(void)replyBtnPressed:(BBButton*)button
{
    touchSection = button.btnSection;
    UIViewController *temVC = self;
    if(!self.navigationController)
    {
        UIView *view = self.view.superview;
        temVC = [XtomFunction traverseResponderChainForUIViewController:view];
    }
    RefundListVC * refund = [[[RefundListVC alloc] init] autorelease];
    refund.keyid = [[dataSource objectAtIndex:touchSection] objectForKey:@"id"];
    refund.keytype = @"2";
    [temVC.navigationController pushViewController:refund animated:YES];
}


- (void)gotoGoodsDetail:(BBButton *)button
{
    touchSection = button.btnSection;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认收货" message:@"一旦确定，不可更改" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"确定", nil];
    alert.cancelButtonIndex = 0;
    [alert show];
    alert.tag = 400;
    alert.delegate = self;
    [alert release];

}


-(void)createAllBtn:(CGRect)btnFrame name:(NSString*)name color:(UIColor*)color action:(SEL)action titleColor:(UIColor*)titleColor tembtn:(BBButton*)tembtn backcolor:(UIColor *)backcolor
{
    tembtn.frame = btnFrame;
    [XtomFunction addbordertoView:tembtn radius:2.0f width:0.5f color:color];
    [tembtn setBackgroundColor:[UIColor clearColor]];
    tembtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    tembtn.titleLabel.textColor = titleColor;
    [tembtn setTitle:name forState:UIControlStateNormal];
    [tembtn setTitleColor:titleColor forState:UIControlStateNormal];
    tembtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [tembtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    tembtn.backgroundColor = backcolor;
}

-(void)timerSetNotice:(NSTimer*)sender
{
    if (waitMB)
    {
        [XtomFunction closeHUD:waitMB];waitMB = nil;
    }
    [self reShowView];
}

-(void)getOrderMessage:(NSNotification*)sender
{
    NSDictionary *myDic = sender.userInfo;
    
    for (int i = 0; i<dataSource.count; i++)
    {
        NSMutableDictionary *temDic = [dataSource objectAtIndex:i];
        
        if ([[myDic objectForKey:@"id"]isEqualToString:[temDic objectForKey:@"id"]])
        {
            
            if ([[myDic objectForKey:@"ischange"]integerValue] == 0)
            {
                [dataSource removeObject:temDic];
                [mytable reloadData];
            }
            
            if ([[myDic objectForKey:@"ischange"]integerValue] == 1)
            {
                for(NSString *key in myDic.allKeys)
                {
                    NSString *value = [myDic objectForKey:key];
                    if(![XtomFunction xfunc_check_strEmpty:value])
                    {
                        [temDic setObject:value forKey:key];
                    }
                }
                [mytable reloadData];
            }
            
            if ([[myDic objectForKey:@"ischange"]integerValue] == 2)
            {
                [temDic setObject:@"1" forKey:@"tradetype"];
                [mytable reloadData];
            }
            break;
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (100 == alertView.tag && 1 == buttonIndex)
    {
        [self requestSaveOperateDelete];
    }
    if (200 == alertView.tag && 1 == buttonIndex)
    {
        [self requestSaveOperateDelete];
    }
    if (300 == alertView.tag && 1 == buttonIndex)
    {
        [self requestSaveOperateGet];
    }
    if (400 == alertView.tag && 1 == buttonIndex)
    {
        [self requestSaveOperateGet];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1+[[[dataSource objectAtIndex:section]objectForKey:@"childItems"]count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row)
    {
        static NSString * CellIdentifier = @"UserOrderListCell00";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
            cell.backgroundColor = BB_White_Color;
            
            
            UILabel *labLeft = [[[UILabel alloc]init]autorelease];
            labLeft.backgroundColor = [UIColor clearColor];
            labLeft.textAlignment = NSTextAlignmentLeft;
            labLeft.font = [UIFont systemFontOfSize:13];
            labLeft.textColor = BB_Gray;
            [labLeft setFrame:CGRectMake(14, 0, WIDTH-74, 35)];
            labLeft.tag = 10;
            [cell.contentView addSubview:labLeft];
            
            
            UILabel * labRight = [[[UILabel alloc]init]autorelease];
            labRight.backgroundColor = [UIColor clearColor];
            labRight.textAlignment = NSTextAlignmentCenter;
            labRight.font = [UIFont systemFontOfSize:14];
            labRight.textColor = BB_Button_Color;
            [labRight setFrame:CGRectMake(WIDTH-60, 0, 60, 35)];
            labRight.tag = 14;
            [cell.contentView addSubview:labRight];
            
            
            UILabel * timerLabel = [[[UILabel alloc]init]autorelease];
            timerLabel.backgroundColor = [UIColor clearColor];
            timerLabel.textAlignment = NSTextAlignmentCenter;
            timerLabel.font = [UIFont systemFontOfSize:12];
            timerLabel.textColor = BB_Gray;
            [timerLabel setFrame:CGRectMake(WIDTH-121, 35, 121, 15)];
            timerLabel.tag = 15;
            [cell.contentView addSubview:timerLabel];
        }
        NSMutableDictionary * temDic = [dataSource objectAtIndex:indexPath.section];
        
        UILabel * labLeft = (UILabel*)[cell viewWithTag:10];
        [labLeft setText:[temDic objectForKey:@"shop_name"]];
        
        UILabel * labRight = (UILabel*)[cell viewWithTag:14];
        if ([[temDic objectForKey:@"bill_type"] integerValue] == 1)
        {
            switch ([[temDic objectForKey:@"tradetype"] intValue])
            {
                case 0:
                {
                    [labRight setText:@"待付款"];
                }
                    break;
                case 1:
                {
                    [labRight setText:@"待消费"];
                }
                    break;
                case 3:
                {
                    [labRight setText:@"待评价"];
                }
                    break;
                case 4:
                {
                    [labRight setText:@"交易完成"];
                }
                    break;
                default:
                    break;
            }
        }
        else if ([[temDic objectForKey:@"bill_type"] integerValue] == 2)
        {
            switch ([[temDic objectForKey:@"tradetype"] intValue])
            {
                case 0:
                {
                    [labRight setText:@"待付款"];
                }
                    break;
                case 1:
                {
                    [labRight setText:@"待收货"];
                }
                    break;
                case 2:
                {
                    [labRight setText:@"待收货"];
                }
                    break;
                case 3:
                {
                    [labRight setText:@"待评价"];
                }
                    break;
                case 4:
                {
                    [labRight setText:@"交易完成"];
                }
                    break;
                default:
                    break;
            }
        }
        UILabel * timerLabel = (UILabel *)[cell viewWithTag:15];
        if ([[temDic objectForKey:@"tradetype"] intValue] == 0)
        {
            [timerLabel setHidden:NO];
            int carttime = [[temDic objectForKey:@"left_seconds"] intValue];
            timerLabel.text = [NSString stringWithFormat:@"付款倒计时 %@",[XtomFunction getStringTime:carttime]];
        }
        else
        {
            [timerLabel setHidden:YES];
        }
        
        return cell;
    }
    if ([[[dataSource objectAtIndex:indexPath.section]objectForKey:@"childItems"]count]+1 == indexPath.row)
    {
        static NSString *CellIdentifier = @"UserOrderListCell01";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.separatorInset = UIEdgeInsetsMake(0, 14, 0, 0);
            cell.backgroundColor = BB_White_Color;
            
            UILabel *labLeft = [[[UILabel alloc]init]autorelease];
            labLeft.backgroundColor = [UIColor clearColor];
            labLeft.textAlignment = NSTextAlignmentLeft;
            [labLeft setFrame:CGRectMake(15, 0, 150, 40)];
            labLeft.tag = 10;
            [cell.contentView addSubview:labLeft];
            
            
            BBButton *oneBtn = [BBButton buttonWithType:UIButtonTypeCustom];
            oneBtn.tag = 11;
            [cell.contentView addSubview:oneBtn];
            
            BBButton *twoBtn = [BBButton buttonWithType:UIButtonTypeCustom];
            twoBtn.tag = 12;
            [cell.contentView addSubview:twoBtn];
        }
        NSMutableDictionary *temDic = [dataSource objectAtIndex:indexPath.section];
        
        UILabel *labLeft = (UILabel*)[cell viewWithTag:10];
        
        NSString *temStr = [NSString stringWithFormat:@"合计：%.2f元",[[temDic objectForKey:@"total_fee"] floatValue]];
        
        NSMutableAttributedString *str = [[[NSMutableAttributedString alloc] initWithString:temStr]autorelease];
        
        [str addAttribute:NSForegroundColorAttributeName value:BB_Gray range:NSMakeRange(0,3)];
        [str addAttribute:NSForegroundColorAttributeName value:BB_Blake range:NSMakeRange(3,[str length]-3)];
        
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0,3)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(3,[str length]-3)];
        
        [labLeft setAttributedText:str];
        
        
        BBButton *oneBtn = (BBButton*)[cell viewWithTag:11];
        BBButton *twoBtn = (BBButton*)[cell viewWithTag:12];
        
        [oneBtn setHidden:YES];
        [twoBtn setHidden:YES];
        
        [oneBtn removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
        [twoBtn removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
        
        oneBtn.btnSection = indexPath.section;
        twoBtn.btnSection = indexPath.section;
        
        if ([[temDic objectForKey:@"bill_type"] integerValue] == 1)
        {
            switch ([[temDic objectForKey:@"tradetype"] intValue])
            {
                case 0:
                {
                    [oneBtn setHidden:NO];
                    [twoBtn setHidden:NO];
                    [self createAllBtn:CGRectMake(182, 6.5, 60, 27) name:@"取消订单" color:BB_Graylight action:@selector(cancelBtnPressed:) titleColor:BB_Gray tembtn:oneBtn backcolor:[UIColor whiteColor]];
                    [self createAllBtn:CGRectMake(247, 6.5, 60, 27) name:@"去付款" color:[UIColor clearColor] action:@selector(payBtnPressed:) titleColor:[UIColor whiteColor] tembtn:twoBtn backcolor:BB_Button_Color];
                }
                    break;
                case 1:
                {
                    [twoBtn setHidden:NO];
                    
                    [self createAllBtn:CGRectMake(247, 6.5, 60, 27) name:@"确认收货" color:[UIColor clearColor] action:@selector(gotoGoodsDetail:) titleColor:[UIColor whiteColor] tembtn:twoBtn backcolor:BB_Button_Color];
                }
                    break;
                case 3:
                {
                    [oneBtn setHidden:NO];
                    [twoBtn setHidden:NO];
                    
                    [self createAllBtn:CGRectMake(182, 6.5, 60, 27) name:@"删除订单" color:BB_Graylight action:@selector(deleteBtnPressed:) titleColor:BB_Gray tembtn:oneBtn backcolor:[UIColor whiteColor]];
                    [self createAllBtn:CGRectMake(247, 6.5, 60, 27) name:@"去评价" color:[UIColor clearColor] action:@selector(replyBtnPressed:) titleColor:[UIColor whiteColor] tembtn:twoBtn backcolor:BB_Button_Color];
                }
                    break;
                case 4:
                {
                    [twoBtn setHidden:NO];
                    
                    [self createAllBtn:CGRectMake(247, 6.5, 60, 27) name:@"删除订单" color:BB_Graylight action:@selector(deleteBtnPressed:) titleColor:BB_Gray tembtn:twoBtn backcolor:[UIColor whiteColor]];
                }
                    break;
                default:
                    break;
            }
        }
        else if ([[temDic objectForKey:@"bill_type"] integerValue] == 2)
        {
            switch ([[temDic objectForKey:@"tradetype"] intValue])
            {
                case 0:
                {
                    [oneBtn setHidden:NO];
                    [twoBtn setHidden:NO];
                    [self createAllBtn:CGRectMake(182, 6.5, 60, 27) name:@"取消订单" color:BB_Graylight action:@selector(cancelBtnPressed:) titleColor:BB_Gray tembtn:oneBtn backcolor:[UIColor whiteColor]];
                    [self createAllBtn:CGRectMake(247, 6.5, 60, 27) name:@"去付款" color:[UIColor clearColor] action:@selector(payBtnPressed:) titleColor:[UIColor whiteColor] tembtn:twoBtn backcolor:BB_Button_Color];
                }
                    break;
                case 1:
                case 2:
                {
                    [oneBtn setHidden:NO];
                    [twoBtn setHidden:NO];
                    
                    [self createAllBtn:CGRectMake(182, 6.5, 60, 27) name:@"申请退款" color:BB_Graylight action:@selector(gotoRefund:) titleColor:BB_Gray tembtn:oneBtn backcolor:[UIColor whiteColor]];
                    [self createAllBtn:CGRectMake(247, 6.5, 60, 27) name:@"确认收货" color:[UIColor clearColor] action:@selector(sureBtnPressed:) titleColor:[UIColor whiteColor] tembtn:twoBtn backcolor:BB_Button_Color];
                }
                    break;
                case 3:
                {
                    [oneBtn setHidden:NO];
                    [twoBtn setHidden:NO];
                    
                    [self createAllBtn:CGRectMake(182, 6.5, 60, 27) name:@"删除订单" color:BB_Graylight action:@selector(deleteBtnPressed:) titleColor:BB_Gray tembtn:oneBtn backcolor:[UIColor whiteColor]];
                    [self createAllBtn:CGRectMake(247, 6.5, 60, 27) name:@"去评价" color:[UIColor clearColor] action:@selector(replyBtnPressed:) titleColor:[UIColor whiteColor] tembtn:twoBtn backcolor:BB_Button_Color];
                }
                    break;
                case 4:
                {
                    [twoBtn setHidden:NO];
                    
                    [self createAllBtn:CGRectMake(247, 6.5, 60, 27) name:@"删除订单" color:BB_Graylight action:@selector(deleteBtnPressed:) titleColor:BB_Gray tembtn:twoBtn backcolor:[UIColor whiteColor]];
                }
                    break;
                default:
                    break;
            }
        }
        return cell;
    }
    
    static NSString *CellIdentifier = @"UserOrderListCell02";
    OrderGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[[OrderGoodCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = BB_White_Color;
    }
    NSMutableDictionary *temDic = [[[dataSource objectAtIndex:indexPath.section]objectForKey:@"childItems"] objectAtIndex:indexPath.row-1];
    
    NSString * fileName = [temDic objectForKey:@"imgurl"];
    [cell.topImgView setImage:[UIImage imageNamed:@"商城_默认广告页3.png"]];
    if(![XtomFunction xfunc_check_strEmpty:fileName])
    {
        NSString *document = [NSString stringWithFormat:@"%@/%@",BB_CASH_DOCUMENT,BB_CASH_AVATAR];
        [[XtomCashManager sharedManager] addImgToImgViewFromDocumentORURL:cell.topImgView document:document url:fileName];
    }
    
    
    [cell.nameLable setText:[temDic objectForKey:@"name"]];
    
    cell.goodsPrice.text = [NSString stringWithFormat:@"%.2f元",[[temDic objectForKey:@"price"] floatValue]];
    
    cell.priceLable.text = [NSString stringWithFormat:@"X%@", [temDic objectForKey:@"buycount"]];
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[[UIView alloc]init]autorelease];
    headView.backgroundColor = [UIColor clearColor];
    
    return headView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[[UIView alloc]init]autorelease];
    footView.backgroundColor = [UIColor clearColor];
    
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (0 == section)
    {
        return 8;
    }
    return 0.1;
    for (UIViewController * controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[UserOrderListVC class]])
        {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row)
    {
        NSMutableDictionary * temDic = [dataSource objectAtIndex:indexPath.section];

        if ([[temDic objectForKey:@"tradetype"] integerValue] == 0)
        {
            return 60;
        }
        return 35;
    }
    if ([[[dataSource objectAtIndex:indexPath.section]objectForKey:@"childItems"]count]+1 == indexPath.row)
    {
        return 40;
    }
    return 95;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath
{
    NSMutableDictionary *temDic = [dataSource objectAtIndex:indexPath.section];
    NSLog(@"%@,%@", [temDic objectForKey:@"bill_type"], [temDic objectForKey:@"tradetype"]);
    UIViewController *temVC = self;
    if(!self.navigationController)
    {
        UIView *view = self.view.superview;
        temVC = [XtomFunction traverseResponderChainForUIViewController:view];
    }
    if ([[temDic objectForKey:@"bill_type"] integerValue] == 1)
    {
        switch ([[temDic objectForKey:@"tradetype"] intValue])
        {
            case 0:
            {
                
//                VirtualOrderDetailVC * order = [[[VirtualOrderDetailVC alloc] init] autorelease];
//                order.keytype = @"1";
//                order.keyid = [temDic objectForKey:@"id"];
//                [temVC.navigationController pushViewController:order animated:YES];
            }
                break;
            case 1:
            {
                
//                VirtualDetailVC * order = [[[VirtualDetailVC alloc] init] autorelease];
//                order.keytype = @"2";
//                order.keyid = [[[temDic objectForKey:@"childItems"] objectAtIndex:0] objectForKey:@"blog_id"];
//                [temVC.navigationController pushViewController:order animated:YES];
            }
                break;
            case 3:
            {
                
//                VirtualOrderDetailVC * order = [[[VirtualOrderDetailVC alloc] init] autorelease];
//                order.keytype = @"2";
//                order.keyid = [temDic objectForKey:@"id"];
//                [temVC.navigationController pushViewController:order animated:YES];
            }
                break;
            default:
                break;
        }
    }
    else if ([[temDic objectForKey:@"bill_type"] integerValue] == 2)
    {
        if ([[temDic objectForKey:@"tradetype"] intValue] == 4)
        {
            return;
        }
        
        OrderDetailVC * order = [[[OrderDetailVC alloc]init]autorelease];
        order.keytype = [temDic objectForKey:@"tradetype"];
        order.blogId = [temDic objectForKey:@"id"];
        [temVC.navigationController pushViewController:order animated:YES];
    }
}

- (void)requestSaveOperateGet
{
    NSString *token = [[XtomManager sharedManager] userToken];
    
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token?token:@"0" forKey:@"token"];
    [dic setObject:@"2" forKey:@"keytype"];
    [dic setObject:[[dataSource objectAtIndex:touchSection] objectForKey:@"id"] forKey:@"keyid"];
    [dic setObject:@"无" forKey:@"reason"];
    [dic setObject:@"无" forKey:@"description"];
    [dic setObject:@"无" forKey:@"shipping_name"];
    [dic setObject:@"无" forKey:@"shipping_num"];
    waitMB = [XtomFunction openHUD:@"正在处理" view:self.view];
    
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_BILL_SAVEOPERATE] target:self selector:@selector(responseSaveOperateGet:) parameter:dic];
}
- (void)responseSaveOperateGet:(NSDictionary*)info
{
    if (waitMB)
    {
        [XtomFunction closeHUD:waitMB];waitMB = nil;
    }
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        NSMutableDictionary *temDic = [dataSource objectAtIndex:touchSection];
        [temDic setObject:@"3" forKey:@"tradetype"];
        [mytable reloadData];
    }
    else
    {
        if([info objectForKey:@"msg"])
        {
            [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:self.view];
        }
    }
}

- (void)requestSaveOperateDelete
{
    NSString *token = [[XtomManager sharedManager] userToken];
    
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token?token:@"0" forKey:@"token"];
    [dic setObject:[[dataSource objectAtIndex:touchSection] objectForKey:@"id"] forKey:@"keyid"];
    [dic setObject:@"1" forKey:@"keytype"];
    [dic setObject:@"无" forKey:@"reason"];
    [dic setObject:@"无" forKey:@"description"];
    [dic setObject:@"无" forKey:@"shipping_name"];
    [dic setObject:@"无" forKey:@"shipping_num"];
    
    waitMB = [XtomFunction openHUD:@"正在删除" view:self.view];
    
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_BILL_SAVEOPERATE] target:self selector:@selector(responseSaveOperateDelete:) parameter:dic];
}
- (void)responseSaveOperateDelete:(NSDictionary*)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        //后续动作 动画
        [dataSource removeObjectAtIndex:touchSection];
        [mytable deleteSections:[NSIndexSet indexSetWithIndex:touchSection]  withRowAnimation:UITableViewRowAnimationFade];
        
        touchSection = -1;
        [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(timerSetNotice:) userInfo:nil repeats:NO];
    }else
    {
        if (waitMB)
        {
            [XtomFunction closeHUD:waitMB];waitMB = nil;
        }
        if([info objectForKey:@"msg"])
        {
            [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:self.view];
        }
    }
}

- (void)requestBillList
{
    NSString *token = [[XtomManager sharedManager] userToken];
    
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    
    [dic setObject:@"1" forKey:@"token"];
    switch ([keytype integerValue])
    {
        case 0:
        {
            [dic setObject:@"1" forKey:@"keytype"];
        }
            break;
        case 1:
        {
            [dic setObject:@"2" forKey:@"keytype"];
        }
            break;
        case 2:
        {
            [dic setObject:@"4" forKey:@"keytype"];
        }
            break;
        case 3:
        {
            [dic setObject:@"5" forKey:@"keytype"];
        }
            break;
        case 4:
        {
            [dic setObject:@"6" forKey:@"keytype"];
        }
            break;
        default:
            break;
    }
    
    [dic setObject:[NSString stringWithFormat:@"%d",(int)currentPage] forKey:@"page"];
    
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_BILL_LIST] target:self selector:@selector(responseBillList:) parameter:dic];
}
- (void)responseBillList:(NSDictionary*)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        if (!dataSource)
            self.dataSource = [[[NSMutableArray alloc]init]autorelease];
        if(0 == currentPage)
        {
            if (dataSource.count != 0)
            {
                [mytable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            }
            [dataSource removeAllObjects];//如果是刷新，原数据清空
        }
        NSString *val=[[info objectForKey:@"infor"]objectForKey:@"listItems"];
        if ([XtomFunction xfunc_check_strEmpty:val])
        {
            [self forbidAddMore];
            isEnd = YES;
            if(isMore)
                [self getNoMoreData];
        }else
        {
            NSArray *temArr = [[info objectForKey:@"infor"]objectForKey:@"listItems"];
            if ([temArr count] == 0)
            {
                [self forbidAddMore];
                isEnd = YES;
                if(isMore)
                    [self getNoMoreData];
            }else
            {
                //如果有数据
                if (temArr.count < 20)
                {
                    [self forbidAddMore];
                }else
                {
                    [self canAddMore];
                }
                for (int i = 0; i<temArr.count; i++)
                {
                    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] init] autorelease];
                    NSDictionary *temDict = [temArr objectAtIndex:i];
                    for(NSString *key in temDict.allKeys)
                    {
                        NSString *value = [temDict objectForKey:key];
                        if(![XtomFunction xfunc_check_strEmpty:value])
                        {
                            [dict setObject:value forKey:key];
                        }
                    }
                    [self.dataSource addObject:dict];
                }
            }
        }
    }else
    {
        if([info objectForKey:@"msg"])
        {
            [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:self.view];
        }
    }
    [self reShowView];
    if(isMore)
    {
        [self stopAddMore];
    }
    if(isLoading)
    {
        [self stopLoading];
    }
}

-(void)reShowView
{
    if(0 == dataSource.count)
    {
        [self showNoDataView:@"暂无订单"];
        [self showNoDataImg:@"暂无数据"];
    }
    else
    {
        [self hideNoDataView];
    }
    [mytable reloadData];
}

- (void)refresh
{
    currentPage = 0;
    isEnd = NO;
    [self requestBillList];
}
-(void)addMore
{
    if (!isEnd)
    {
        currentPage++;
    }
    [self requestBillList];
}
@end
