//
//  OrderDetailVC.m
//  PingChuan
//
//  Created by LarryRodic on 15/3/25.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "OrderDetailVC.h"
#import "OrderGoodCell.h"
#import "OrderCreateVC.h"
#import "RefundListVC.h"
#import "StoreDetailVC.h"
#import "RealityDetailVC.h"
#import "WebVC.h"

@interface OrderDetailVC ()<UITableViewDataSource,UITableViewDelegate, UIAlertViewDelegate>
{
    MBProgressHUD *waitMB;
    BOOL isCanTui;
    NSTimer * _timer;
}
@property(nonatomic,retain)UITableView *myTableView;
@property(nonatomic,retain)UIView *downView;
@property(nonatomic,retain)NSMutableDictionary *dataSource;

@end

@implementation OrderDetailVC
@synthesize keytype;
@synthesize myTableView;
@synthesize downView;
@synthesize blogId;
@synthesize dataSource;

@synthesize isCartOrBuy;

-(void)dealloc
{
    [myTableView release];myTableView = nil;
    [keytype release];keytype = nil;
    [downView release];downView = nil;
    [blogId release];blogId = nil;
    [dataSource release];dataSource = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BB_NOTIFICATION_OrderRefresh object:nil];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadSet];
    [self loadData];
}

-(void)loadSet
{
    
    [self.navigationItem setNewTitle:@"订单详情"];
    self.view.backgroundColor = BB_Back_Color_Here;
    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftBtnPressed:) image:@"common_return.png" imageH:@"common_return.png"];
    
    self.myTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, UI_View_Hieght-48) style:UITableViewStyleGrouped]autorelease];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    [myTableView setBackgroundView:nil];
    [myTableView setSeparatorInset:UIEdgeInsetsMake(0, 14, 0, 0)];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myTableView];
    
    
    
    self.downView = [[[UIView alloc]init]autorelease];
    [downView setFrame:CGRectMake(-1, UI_View_Hieght-48, 322, 49)];
    [XtomFunction addbordertoView:downView radius:0.0 width:0.5f color:BB_Graylight];
    [downView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:downView];
    if ([keytype integerValue] == 1)
    {
        keytype = @"2";
    }
    [downView setHidden:NO];
    [myTableView setFrame:CGRectMake(0, 0, WIDTH, UI_View_Hieght-48)];
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshActivityList) userInfo:nil repeats:YES];
    
    [self initDown];
    
}


- (void)refreshActivityList
{
    if ([keytype integerValue] == 0)
    {
        NSString *end_last_time = [dataSource objectForKey:@"left_seconds"];
        if (![XtomFunction xfunc_check_strEmpty:end_last_time])
        {
            int carttime=[[dataSource objectForKey:@"left_seconds"] intValue];
            
            if (carttime>=1)
            {
                carttime--;
                [dataSource setValue:[NSString stringWithFormat:@"%d",carttime] forKey:@"left_seconds"];
                UILabel * timerLabel = (UILabel *)[downView viewWithTag:15];
                timerLabel.text = [NSString stringWithFormat:@"付款倒计时 %@",[XtomFunction getStringTime:carttime]];
            }
            else
            {
                if (_timer)
                {
                    [_timer invalidate]; _timer = nil;
                }
                [self leftBtnPressed:nil];
            }
        }
    }
}

-(void)loadData
{
    [self requestGetBill];
}


-(void)initDown
{
   
    if ([keytype integerValue] == 0)
    {
        
        UILabel * timerLabel = [[[UILabel alloc]init]autorelease];
        timerLabel.backgroundColor = [UIColor clearColor];
        timerLabel.textAlignment = NSTextAlignmentLeft;
        timerLabel.font = [UIFont systemFontOfSize:12];
        timerLabel.textColor = BB_Gray;
        [timerLabel setFrame:CGRectMake(15, 17, 121, 15)];
        timerLabel.tag = 15;
        [downView addSubview:timerLabel];
        
        [self createAllBtn:CGRectMake(170, 11, 60, 27) name:@"取消订单" color:BB_Gray action:@selector(cancelBtnPressed:) titleColor:BB_Gray backColor:[UIColor whiteColor]];
        [self createAllBtn:CGRectMake(245, 11, 60, 27) name:@"去付款" color:BB_Button_Color action:@selector(payBtnPressed:) titleColor:[UIColor whiteColor] backColor:BB_Button_Color];
    }
    if ([keytype integerValue] == 2)
    {
        [self createAllBtn:CGRectMake(170, 11, 60, 27) name:@"申请退款" color:BB_Gray action:@selector(gotoRefund:) titleColor:BB_Gray backColor:[UIColor whiteColor]];
        [self createAllBtn:CGRectMake(245, 11, 60, 27) name:@"确认收货" color:BB_Button_Color action:@selector(sureBtnPressed:) titleColor:[UIColor whiteColor] backColor:BB_Button_Color];
    }
    if ([keytype integerValue] == 3)
    {
        [self createAllBtn:CGRectMake(170, 11, 60, 27) name:@"删除订单" color:BB_Gray action:@selector(deleteBtnPressed:) titleColor:BB_Gray backColor:[UIColor whiteColor]];
        [self createAllBtn:CGRectMake(245, 11, 60, 27) name:@"去评价" color:BB_Button_Color action:@selector(replyBtnPressed:) titleColor:[UIColor whiteColor] backColor:BB_Button_Color];
    }
}


-(void)leftBtnPressed:(id)sender
{
    if (isCartOrBuy)
    {
        NSInteger count = [self.navigationController.viewControllers count];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:count-3] animated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)cancelBtnPressed:(BBButton *)button
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"取消订单" message:@"确定要取消您的订单吗？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"确定", nil];
    alert.cancelButtonIndex = 0;
    [alert show];
    alert.tag = 200;
    alert.delegate = self;
    [alert release];
}


- (void)deleteBtnPressed:(BBButton *)button
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"删除订单" message:@"一旦删除，不可恢复" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"确定", nil];
    alert.cancelButtonIndex = 0;
    [alert show];
    alert.tag = 100;
    alert.delegate = self;
    [alert release];
}


- (void)gotoRefund:(BBButton *)button
{
    UIViewController *temVC = self;
    if(!self.navigationController)
    {
        UIView *view = self.view.superview;
        temVC = [XtomFunction traverseResponderChainForUIViewController:view];
    }
    RefundListVC * refund = [[[RefundListVC alloc] init] autorelease];
    refund.keyid = [dataSource objectForKey:@"id"];
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
    OrderCreateVC * create = [[[OrderCreateVC alloc]init]autorelease];
    create.keytype = @"3";
    create.sectionNum = 1;
    create.keyid = [dataSource objectForKey:@"id"];
    create.dataSource = [NSMutableArray arrayWithObjects:dataSource, nil];
    [temVC.navigationController pushViewController:create animated:YES];
}


-(void)sureBtnPressed:(BBButton*)sender
{
    if ([[dataSource objectForKey:@"sendflag"] integerValue] == 0)
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
    UIViewController *temVC = self;
    if(!self.navigationController)
    {
        UIView *view = self.view.superview;
        temVC = [XtomFunction traverseResponderChainForUIViewController:view];
    }
    RefundListVC * refund = [[[RefundListVC alloc] init] autorelease];
    refund.keyid = [dataSource objectForKey:@"id"];
    refund.keytype = @"2";
    [temVC.navigationController pushViewController:refund animated:YES];
}


-(void)createAllBtn:(CGRect)btnFrame name:(NSString*)name color:(UIColor*)color action:(SEL)action titleColor:(UIColor*)titleColor backColor:(UIColor *)backColor
{
    UIButton *deletebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deletebtn.frame = btnFrame;
    [XtomFunction addbordertoView:deletebtn radius:4.0f width:0.5f color:color];
    [deletebtn setBackgroundColor:[UIColor clearColor]];
    deletebtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    deletebtn.titleLabel.textColor = titleColor;
    [deletebtn setTitle:name forState:UIControlStateNormal];
    [deletebtn setTitleColor:titleColor forState:UIControlStateNormal];
    deletebtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [deletebtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:deletebtn];
    deletebtn.backgroundColor = backColor;
}


-(void)gotoBack
{
    [self leftBtnPressed:nil];
}

- (void)timerSetNotice:(NSTimer *)timer
{
    [self gotoBack];
}

-(void)getOrderMessage:(NSNotification*)sender
{
    NSDictionary *myDic = sender.userInfo;
    
    if ([[myDic objectForKey:@"ischange"]integerValue] != 2)
    {
        return;
    }
    if ([[myDic objectForKey:@"id"]isEqualToString:[dataSource objectForKey:@"id"]])
    {
        
        if ([[myDic objectForKey:@"ischange"]integerValue] == 2)
        {
            [self requestGetBill];
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
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([keytype integerValue] == 2)
    {
        return 4;
    }
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section)
    {
        return 2;
    }
    if (1 == section)
    {
        return [[dataSource objectForKey:@"childItems"]count]+2;//商品列表+合计
    }
    if (3 == section)
    {
        return 1;
    }
    if ([keytype integerValue] == 2)
    {
        return 2;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (0 == indexPath.section)
    {
        
        if (0 == indexPath.row)
        {
            static NSString * CellIdentifier = @"OrderDetailCell00";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if(cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = BB_White_Color;
                
                
                UIImageView * leftImgView = [[[UIImageView alloc] init] autorelease];
                leftImgView.tag = 9;
                [cell.contentView addSubview:leftImgView];
                
                
                UILabel * orderState = [[[UILabel alloc] init] autorelease];
                orderState.backgroundColor = [UIColor clearColor];
                orderState.textAlignment = NSTextAlignmentLeft;
                orderState.font = [UIFont systemFontOfSize:19];
                orderState.textColor = BB_Blake;
                [orderState setFrame:CGRectMake(63, 6.5, 200, 28)];
                orderState.tag = 10;
                [cell.contentView addSubview:orderState];
                
                
                UILabel * orderAllfee = [[[UILabel alloc]init]autorelease];
                orderAllfee.backgroundColor = [UIColor clearColor];
                orderAllfee.textAlignment = NSTextAlignmentLeft;
                orderAllfee.font = [UIFont systemFontOfSize:13];
                orderAllfee.textColor = [UIColor grayColor];
                orderAllfee.numberOfLines = 2;
                [orderAllfee setFrame:CGRectMake(63, 38, 200, 16.5)];
                orderAllfee.tag = 11;
                [cell.contentView addSubview:orderAllfee];
                
                
                UILabel * orderYunfee = [[[UILabel alloc]init]autorelease];
                orderYunfee.backgroundColor = [UIColor clearColor];
                orderYunfee.textAlignment = NSTextAlignmentLeft;
                orderYunfee.font = [UIFont systemFontOfSize:14];
                orderYunfee.textColor = [UIColor grayColor];
                [orderYunfee setFrame:CGRectMake(63, 54.5, 200, 17.5)];
                orderYunfee.tag = 12;
                [cell.contentView addSubview:orderYunfee];
            }
            UIImageView * leftImgView = (UIImageView *)[cell viewWithTag:9];
            
            UILabel * orderState = (UILabel*)[cell viewWithTag:10];
            switch ([keytype integerValue]){
                case 0:
                {
                    leftImgView.image = [UIImage imageNamed:@"待付款图标.png"];
                    leftImgView.frame = CGRectMake(16, 22, 27, 26);
                    [orderState setText:@"待付款!"];
                }
                    break;
                case 1:
                {
                    leftImgView.image = [UIImage imageNamed:@"待付款图标.png"];
                    leftImgView.frame = CGRectMake(16, 22, 27, 26);
                    [orderState setText:@"待发货!"];
                }
                    break;
                case 2:
                {
                    leftImgView.image = [UIImage imageNamed:@"待收货图标.png"];
                    leftImgView.frame = CGRectMake(16.5, 20.5, 25, 29.5);
                    [orderState setText:@"待收货!"];
                }
                    break;
                case 3:
                {
                    leftImgView.image = [UIImage imageNamed:@"待评价图标.png"];
                    leftImgView.frame = CGRectMake(12.5, 20.5, 32.5, 26.5);
                    [orderState setText:@"待评价!"];
                }
                    break;
                default:
                    break;
            }
            
            UILabel * orderAllfee = (UILabel*)[cell viewWithTag:11];
            
            UILabel * orderYunfee = (UILabel*)[cell viewWithTag:12];
            
            if (![XtomFunction xfunc_check_strEmpty:[dataSource objectForKey:@"consignee"]])
            {
                [orderAllfee setText:[NSString stringWithFormat:@"订单总额（含运费）：￥%@", [dataSource objectForKey:@"total_fee"]]];
                [orderYunfee setText:[NSString stringWithFormat:@"运费：￥%@", [dataSource objectForKey:@"shipping_fee"]]];
            }
            
            return cell;
        }
        static NSString *CellIdentifier = @"OrderDetailCell01";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = BB_White_Color;
            
            
            UIImageView *downImgView = [[[UIImageView alloc]init]autorelease];
            [downImgView setImage:[UIImage imageNamed:@"订单详情_地址图标.png"]];
            [downImgView setFrame:CGRectMake(22, 15.5, 17, 26.5)];
            [cell.contentView addSubview:downImgView];
            
            
            UILabel * nameAndTel = [[[UILabel alloc]init]autorelease];
            nameAndTel.backgroundColor = [UIColor clearColor];
            nameAndTel.textAlignment = NSTextAlignmentLeft;
            nameAndTel.font = [UIFont systemFontOfSize:17];
            nameAndTel.textColor = [UIColor blackColor];
            [nameAndTel setFrame:CGRectMake(63, 10.5, WIDTH-73, 24)];
            nameAndTel.tag = 13;
            [cell.contentView addSubview:nameAndTel];
            
            
            UILabel * detailAddr = [[[UILabel alloc]init]autorelease];
            detailAddr.backgroundColor = [UIColor clearColor];
            detailAddr.textAlignment = NSTextAlignmentLeft;
            detailAddr.font = [UIFont systemFontOfSize:13];
            detailAddr.textColor = [UIColor grayColor];
            detailAddr.numberOfLines = 2;
            [detailAddr setFrame:CGRectMake(63, 38.5, WIDTH-73, 20.5)];
            detailAddr.tag = 14;
            [cell.contentView addSubview:detailAddr];
        }
        
        UILabel * nameAndTel = (UILabel*)[cell viewWithTag:13];
        
        UILabel * detailAddr = (UILabel*)[cell viewWithTag:14];
        
        if (![XtomFunction xfunc_check_strEmpty:[dataSource objectForKey:@"consignee"]])
        {
            [nameAndTel setText:[NSString stringWithFormat:@"%@    %@",[dataSource objectForKey:@"consignee"], [dataSource objectForKey:@"phone"]]];
            [detailAddr setText:[dataSource objectForKey:@"address"]];
        }
        
        return cell;
    }
    if (1 == indexPath.section)
    {
        
        if (0 == indexPath.row)
        {
            static NSString *CellIdentifier = @"OrderDetailCell02";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if(cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = BB_White_Color;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                
                UILabel * shopName = [[[UILabel alloc]init]autorelease];
                shopName.backgroundColor = [UIColor clearColor];
                shopName.textAlignment = NSTextAlignmentLeft;
                shopName.font = [UIFont systemFontOfSize:14];
                shopName.textColor = BB_Blake;
                [shopName setFrame:CGRectMake(15, 0, WIDTH-45, 34)];
                shopName.tag = 10;
                [cell.contentView addSubview:shopName];
            }
            
            UILabel * shopName = (UILabel *)[cell viewWithTag:10];
            shopName.text = [[[dataSource objectForKey:@"childItems"] objectAtIndex:0] objectForKey:@"shop_name"];
            
            return cell;
        }
        
        if ([[dataSource objectForKey:@"childItems"]count]+1 == indexPath.row)
        {
            static NSString *CellIdentifier = @"OrderDetailCell03";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if(cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.separatorInset = UIEdgeInsetsMake(0, 14, 0, 0);
                cell.backgroundColor = BB_White_Color;
            }else
            {
                for(UIView *view in cell.contentView.subviews)
                {
                    [view removeFromSuperview];
                }
            }
            
            UILabel * shopName = [[[UILabel alloc]init]autorelease];
            shopName.backgroundColor = [UIColor clearColor];
            shopName.textAlignment = NSTextAlignmentLeft;
            shopName.font = [UIFont systemFontOfSize:14];
            shopName.textColor = BB_Blake;
            [shopName setFrame:CGRectMake(15, 0, WIDTH-45, 34)];
            shopName.tag = 10;
            [cell.contentView addSubview:shopName];
            [shopName setText:[NSString stringWithFormat:@"数量：%@", [dataSource objectForKey:@"buycount"]]];
            
            UILabel *labLeft = [[[UILabel alloc]init]autorelease];
            labLeft.backgroundColor = [UIColor clearColor];
            labLeft.textAlignment = NSTextAlignmentRight;
            [labLeft setFrame:CGRectMake(100, 0, 204, 40)];
            [cell.contentView addSubview:labLeft];
            
            NSString *temStr = [NSString stringWithFormat:@"合计：￥%.2f",[[dataSource objectForKey:@"total_fee"] floatValue]];
            
            NSMutableAttributedString *str = [[[NSMutableAttributedString alloc] initWithString:temStr]autorelease];
            
            [str addAttribute:NSForegroundColorAttributeName value:BB_Gray range:NSMakeRange(0,3)];
            [str addAttribute:NSForegroundColorAttributeName value:BB_Blake range:NSMakeRange(3,[str length]-3)];
            
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0,3)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(3,[str length]-3)];
            
            [labLeft setAttributedText:str];
            
            return cell;
        }
        
        static NSString *CellIdentifier = @"OrderDetailCell04";
        OrderGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell == nil)
        {
            cell = [[[OrderGoodCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = BB_White_Color;
        }
        
        NSMutableDictionary *temDic = [[dataSource objectForKey:@"childItems"] objectAtIndex:indexPath.row-1];
        
        [cell.topImgView setImage:[UIImage imageNamed:@"商城_默认广告页3.png"]];
        cell.topImgView.imgURL = [temDic objectForKey:@"imgurl"];
        NSString * fileName = [temDic objectForKey:@"imgurl"];
        if(![XtomFunction xfunc_check_strEmpty:fileName])
        {
            NSString *document = [NSString stringWithFormat:@"%@/%@",BB_CASH_DOCUMENT,BB_CASH_AVATAR];
            [[XtomCashManager sharedManager] addImgToImgViewFromDocumentORURL:cell.topImgView document:document url:fileName];
        }
        
        [cell.nameLable setText:[temDic objectForKey:@"name"]];
        
        
        cell.goodsPrice.text = [NSString stringWithFormat:@"%.2f元",[[temDic objectForKey:@"price"] floatValue]];
        cell.priceLable.text = [NSString stringWithFormat:@"X%@", [temDic objectForKey:@"buycount"]];
        
        [cell.rightBtn setHidden:YES];
        [cell.line setHidden:YES];
        
        return cell;
    }
    if (2 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            
            static NSString *CellIdentifier = @"OrderDetailCell05";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if(cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = BB_White_Color;
                
                
                UILabel * ordrNumber = [[[UILabel alloc] init] autorelease];
                ordrNumber.frame = CGRectMake(15, 11.5, WIDTH-30, 17);
                ordrNumber.textColor = [UIColor grayColor];
                ordrNumber.textAlignment = NSTextAlignmentLeft;
                ordrNumber.font = [UIFont systemFontOfSize:13];
                ordrNumber.tag = 10;
                [cell.contentView addSubview:ordrNumber];
                
                UILabel * orderTime = [[[UILabel alloc] init] autorelease];
                orderTime.frame = CGRectMake(15, 28.5, WIDTH, 17);
                orderTime.textColor = [UIColor grayColor];
                orderTime.textAlignment = NSTextAlignmentLeft;
                orderTime.font = [UIFont systemFontOfSize:13];
                orderTime.tag = 11;
                [cell.contentView addSubview:orderTime];
                
                UILabel * orderState = [[[UILabel alloc] init] autorelease];
                orderState.frame = CGRectMake(15, 45.5, WIDTH, 17);
                orderState.textColor = [UIColor grayColor];
                orderState.textAlignment = NSTextAlignmentLeft;
                orderState.font = [UIFont systemFontOfSize:13];
                [cell.contentView addSubview:orderState];
                orderState.tag = 12;
            }
            
            
            UILabel * ordrNumber = (UILabel *)[cell viewWithTag:10];
            
            UILabel * orderTime = (UILabel *)[cell viewWithTag:11];
            
            UILabel * orderState = (UILabel *)[cell viewWithTag:12];
            ordrNumber.text = [NSString stringWithFormat:@"订单号：%@", [dataSource objectForKey:@"bill_sn"]?[dataSource objectForKey:@"bill_sn"]:@"暂无信息"];
            orderTime.text = [NSString stringWithFormat:@"下单时间：%@", [dataSource objectForKey:@"regdate"]?[dataSource objectForKey:@"regdate"]:@"暂无信息"];
            switch ([keytype integerValue]) {
                case 0:
                {
                    orderState.text = @"订单状态：待付款";
                }
                    break;
                case 1:
                {
                    orderState.text = @"订单状态：待发货";
                }
                    break;
                case 2:
                {
                    orderState.text = @"订单状态：待收货";
                }
                    break;
                case 3:
                {
                    orderState.text = @"订单状态：待评价";
                }
                    break;
                default:
                    break;
            }
            return cell;
        }
        
        static NSString *CellIdentifier = @"OrderDetailCell06";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = BB_White_Color;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            

        }

        cell.textLabel.text = @"查看物流信息";
        return cell;
    }
  
    static NSString *CellIdentifier = @"OrderDetailCell07";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = BB_White_Color;
        cell.accessoryType = UITableViewCellAccessoryNone;
        
       
        UILabel * ordrNumber = [[[UILabel alloc] init] autorelease];
        ordrNumber.frame = CGRectMake(15, 11.5, WIDTH-30, 17);
        ordrNumber.textColor = [UIColor grayColor];
        ordrNumber.textAlignment = NSTextAlignmentLeft;
        ordrNumber.font = [UIFont systemFontOfSize:13];
        ordrNumber.tag = 10;
        [cell.contentView addSubview:ordrNumber];
        
        UILabel * orderTime = [[[UILabel alloc] init] autorelease];
        orderTime.frame = CGRectMake(15, 28.5, WIDTH, 17);
        orderTime.textColor = [UIColor grayColor];
        orderTime.textAlignment = NSTextAlignmentLeft;
        orderTime.font = [UIFont systemFontOfSize:13];
        orderTime.tag = 11;
        [cell.contentView addSubview:orderTime];
    }
    
    UILabel * ordrNumber = (UILabel *)[cell viewWithTag:10];
    
    UILabel * orderTime = (UILabel *)[cell viewWithTag:11];
    ordrNumber.text = [NSString stringWithFormat:@"快递公司：%@", [dataSource objectForKey:@"shipping_name"]?[dataSource objectForKey:@"shipping_name"]:@"暂无信息"];
    orderTime.text = [NSString stringWithFormat:@"快递单号：%@", [dataSource objectForKey:@"shipping_num"]?[dataSource objectForKey:@"shipping_num"]:@"暂无信息"];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            return 83;
        }
        return 67;
    }
    if (1 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            return 34;
        }
        if ([[dataSource objectForKey:@"childItems"]count]+1 == indexPath.row)
        {
            return 40;
        }
        return 95;
    }
    if (3 == indexPath.section)
    {
        return 28+17.5+11.5;
    }
    return 75;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath
{
    if (1 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            StoreDetailVC * detail = [[[StoreDetailVC alloc] init] autorelease];
            detail.keyid = [dataSource objectForKey:@"shop_id"];
            detail.isShiWu = YES;
            [self.navigationController pushViewController:detail animated:YES];
        }
        else
        {
            NSMutableArray * temArr = [dataSource objectForKey:@"childItems"];
            if (temArr.count + 1 != indexPath.row)
            {
                RealityDetailVC * detail = [[[RealityDetailVC alloc] init] autorelease];
                
                detail.keyid = [[temArr objectAtIndex:indexPath.row-1] objectForKey:@"blog_id"];
                
                detail.keytype = @"1";
                
                [self.navigationController pushViewController:detail animated:YES];
            }
        }
    }
    if (2 == indexPath.section && 1 == indexPath.row)
    {
        if ([XtomFunction xfunc_check_strEmpty:[dataSource objectForKey:@"shipping_num"]])
        {
            [XtomFunction openIntervalHUD:@"暂无快递信息" view:self.view];
            return;
        }
        WebVC *web = [[[WebVC alloc]init]autorelease];
        web.urlPath = [NSString stringWithFormat:@"http://m.kuaidi100.com/result.jsp?nu=%@",[dataSource objectForKey:@"shipping_num"]];
        web.objectTitle = @"订单详情";
        web.isAdgust = NO;
        [self.navigationController pushViewController:web animated:YES];

    }
}

- (void)requestGetBill
{
    NSString *token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token forKey:@"token"];
    [dic setObject:self.blogId forKey:@"id"];
    
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_BILL_GET] target:self selector:@selector(responseGetBill:) parameter:dic];
}
- (void)responseGetBill:(NSDictionary*)info
{
    NSLog(@"%@", info);
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        if(![XtomFunction xfunc_check_strEmpty:[info objectForKey:@"infor"]])
        {
            if (!dataSource)
                self.dataSource = [[[NSMutableDictionary alloc]init]autorelease];
            NSDictionary *temDict = [[info objectForKey:@"infor"] objectAtIndex:0];
            for(NSString *key in temDict.allKeys)
            {
                NSString *value = [temDict objectForKey:key];
                if(![XtomFunction xfunc_check_strEmpty:value])
                {
                    [dataSource setObject:value forKey:key];
                }
            }
        }
        [myTableView reloadData];
    }
    else
    {
        if ([[info objectForKey:@"error_code"]integerValue] == 404)
        {
            [XtomFunction openIntervalHUD:@"很抱歉，此订单已失效" view:self.view];
            [self performSelector:@selector(gotoBack) withObject:nil afterDelay:1.2];
        }else
        {
            if([info objectForKey:@"msg"])
            {
                [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:self.view];
            }
        }
    }
}

- (void)requestSaveOperateGet
{
    NSString *token = [[XtomManager sharedManager] userToken];
    
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token?token:@"0" forKey:@"token"];
    [dic setObject:@"2" forKey:@"keytype"];
    [dic setObject:[dataSource objectForKey:@"id"] forKey:@"keyid"];
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
        [XtomFunction openIntervalHUD:@"确认收货成功" view:self.view];
        [self.navigationController popViewControllerAnimated:YES];
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
    [dic setObject:[dataSource objectForKey:@"id"] forKey:@"keyid"];
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
    if (waitMB)
    {
        [XtomFunction closeHUD:waitMB];waitMB = nil;
    }
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        [XtomFunction openIntervalHUD:@"删除订单成功" view:self.view];
        [self .navigationController popViewControllerAnimated:YES];
    }
    else
    {
        if([info objectForKey:@"msg"])
        {
            [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:self.view];
        }
    }
}
@end
