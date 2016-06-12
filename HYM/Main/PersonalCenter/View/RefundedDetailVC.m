//
//  RefundedDetailVC.m
//  PingChuan
//
//  Created by pengli on 15/11/11.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "RefundedDetailVC.h"
#import "OrderGoodCell.h"
#import "RefundProgressVC.h"
#import "StoreDetailVC.h"
#import "RealityDetailVC.h"

@interface RefundedDetailVC ()<UITableViewDataSource,UITableViewDelegate>
{
    MBProgressHUD *waitMB;
}
@property(nonatomic,retain)UITableView *myTableView;
@property(nonatomic,retain)NSMutableDictionary *dataSource;
@property(nonatomic,retain)NSMutableArray * dataArray;

@end

@implementation RefundedDetailVC
@synthesize keytype;
@synthesize myTableView;
@synthesize keyid;
@synthesize progressid;
@synthesize dataSource;
@synthesize dataArray;

-(void)dealloc
{
    [myTableView release];myTableView = nil;
    [keytype release];keytype = nil;
    [progressid release]; progressid = nil;
    [keyid release];keyid = nil;
    [dataSource release];dataSource = nil;
    [dataArray release]; dataArray = nil;
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
    
//    [self.navigationItem setNewTitle:@"订单详情"];
    self.view.backgroundColor = BB_Back_Color_Here;
//    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftBtnPressed:) image:@"common_return.png" imageH:@"common_return.png"];
    
    
    self.myTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, UI_View_Hieght) style:UITableViewStyleGrouped]autorelease];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    [myTableView setBackgroundView:nil];
    [myTableView setSeparatorInset:UIEdgeInsetsMake(0, 14, 0, 0)];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myTableView];
}

-(void)loadData
{
    [self requestGetBill];
}


-(void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
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
    return 2;
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
                leftImgView.image = [UIImage imageNamed:@"退款图标.png"];
                leftImgView.frame = CGRectMake(13.5, 18, 34.5, 29.5);
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
           
            UILabel * orderState = (UILabel*)[cell viewWithTag:10];
            switch ([keytype integerValue])
            {
                case 1:
                {
                    
                    [orderState setText:@"退款中!"];
                }
                    break;
                case 2:
                {
                    [orderState setText:@"退款成功!"];
                }
                    break;
                case 3:
                {
                    [orderState setText:@"退款失败!"];
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
            case 1:
            {
                orderState.text = @"订单状态：退款中";
            }
                break;
            case 2:
            {
                orderState.text = @"订单状态：退款成功";
            }
                break;
            case 3:
            {
                orderState.text = @"订单状态：退款失败";
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
        
        
        UILabel * ordrNumber = [[[UILabel alloc] init] autorelease];
        ordrNumber.frame = CGRectMake(15, 10, WIDTH-30, 15);
        ordrNumber.textColor = [UIColor grayColor];
        ordrNumber.textAlignment = NSTextAlignmentLeft;
        ordrNumber.font = [UIFont systemFontOfSize:15];
        ordrNumber.text = @"查看退款流程";
        [cell.contentView addSubview:ordrNumber];
        
        UIImageView * downImgView = [[[UIImageView alloc]init]autorelease];
        [downImgView setImage:[UIImage imageNamed:@"物流默认图标.png"]];
        [downImgView setFrame:CGRectMake(15, 33, 15.5, 32)];
        [cell.contentView addSubview:downImgView];
        
        UILabel * orderTime = [[[UILabel alloc] init] autorelease];
        orderTime.frame = CGRectMake(34, 30.5, WIDTH, 20);
        orderTime.textColor = [UIColor colorWithRed:45/255.f green:137/255.f blue:240/255.f alpha:1];
        orderTime.textAlignment = NSTextAlignmentLeft;
        orderTime.font = [UIFont systemFontOfSize:13];
        orderTime.tag = 11;
        [cell.contentView addSubview:orderTime];
        
        UILabel * orderState = [[[UILabel alloc] init] autorelease];
        orderState.frame = CGRectMake(34, 51.5, WIDTH, 17);
        orderState.textColor = [UIColor grayColor];
        orderState.textAlignment = NSTextAlignmentLeft;
        orderState.font = [UIFont systemFontOfSize:12];
        [cell.contentView addSubview:orderState];
        orderState.tag = 12;
    }
    NSMutableDictionary * temDict = [dataArray objectAtIndex:0];
    
    UILabel * orderTime = (UILabel *)[cell viewWithTag:11];
    orderTime.text = [temDict objectForKey:@"name"];
    
    UILabel * orderState = (UILabel *)[cell viewWithTag:12];
    orderState.text = [temDict objectForKey:@"regdate"];
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
    return 75;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath
{
    if (1 == indexPath.section && 0 == indexPath.row)
    {
        StoreDetailVC * store = [[[StoreDetailVC alloc] init] autorelease];
        store.keyid = [dataSource objectForKey:@"shop_id"];
        [self.navigationController pushViewController:store animated:YES];
    }
    if (2 == indexPath.section && 1 == indexPath.row)
    {
        RefundProgressVC * progress = [[[RefundProgressVC alloc] init] autorelease];
        switch ([keytype intValue])
        {
            case 1:
            {
                progress.keytype = @"1";
            }
                break;
            case 2:
            {
                progress.keytype = @"2";
            }
                break;
            case 3:
            {
                progress.keytype = @"3";
            }
                break;
            default:
                break;
        }
        progress.keyid = [[[dataSource objectForKey:@"childItems"] objectAtIndex:0] objectForKey:@"id"];
        [self.navigationController pushViewController:progress animated:YES];
    }
    if (1 == indexPath.section && 0 != indexPath.row && [[dataSource objectForKey:@"childItems"]count]+1 != indexPath.row)
    {
        RealityDetailVC * reality = [[[RealityDetailVC alloc] init] autorelease];
        reality.keytype = @"1";
        
        reality.keyid = [[[dataSource objectForKey:@"childItems"] objectAtIndex:0] objectForKey:@"blog_id"];
        [self.navigationController pushViewController:reality animated:YES];
    }
}

- (void)requestGetBill
{
    NSString *token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token forKey:@"token"];
    [dic setObject:self.keyid forKey:@"id"];
    
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_BILL_GET] target:self selector:@selector(responseGetBill:) parameter:dic];
}
- (void)responseGetBill:(NSDictionary*)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        if(![XtomFunction xfunc_check_strEmpty:[info objectForKey:@"infor"]])
        {
            if (!dataSource)
            {
                self.dataSource = [[[NSMutableDictionary alloc]init]autorelease];
            }
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
        [self requestRefundProgress];
    }
    else
    {
        if([info objectForKey:@"msg"])
        {
            [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:self.view];
        }
    }
}


- (void)requestRefundProgress
{
    NSString *token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token forKey:@"token"];
    [dic setObject:@"2" forKey:@"keytype"];
    [dic setObject:progressid forKey:@"keyid"];
    [dic setObject:@"0" forKey:@"page"];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_AUTH_PROGESS_LIST] target:self selector:@selector(responseRefundProgress:) parameter:dic];
}

- (void)responseRefundProgress:(NSDictionary *)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        if (!dataArray)
        {
            self.dataArray = [[[NSMutableArray alloc]init]autorelease];
        }
        [dataArray removeAllObjects];
        NSString *val=[[info objectForKey:@"infor"]objectForKey:@"listItems"];
        if (![XtomFunction xfunc_check_strEmpty:val])
        {
            NSArray *temArr = [[info objectForKey:@"infor"]objectForKey:@"listItems"];
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
                [self.dataArray addObject:dict];
                
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
@end
