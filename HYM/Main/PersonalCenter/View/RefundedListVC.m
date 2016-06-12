//
//  RefundedListVC.m
//  PingChuan
//
//  Created by pengli on 15/11/11.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "RefundedListVC.h"
#import "BBButton.h"
#import "OrderGoodCell.h"
#import "RefundProgressVC.h"
#import "RefundedDetailVC.h"

@interface RefundedListVC ()
{
    MBProgressHUD *waitMB;
    BOOL isEnd;
    NSInteger currentPage;
}
@property (nonatomic, retain) NSMutableArray * dataArray;

@end

@implementation RefundedListVC
@synthesize dataArray;

- (void)dealloc
{
    [dataArray release]; dataArray = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadSet];
    [self loadData];
}

- (void)loadSet
{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:NavigationColor];
    [self.navigationItem setNewTitle:@"退款列表"];
    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftBtnPressed) image:@"common_return.png" imageH:@"common_return.png"];
    [self.view setBackgroundColor:BB_Back_Color_Here];
}

- (void)loadData
{
    [self requestBillList];
}

- (void)leftBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
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
    tembtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [tembtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    tembtn.backgroundColor = backcolor;
}

- (void)payBtnPressed:(BBButton *)button
{
    NSMutableDictionary * temDict = [dataArray objectAtIndex:button.btnSection];
    RefundProgressVC * progress = [[[RefundProgressVC alloc] init] autorelease];
    switch ([[[[temDict objectForKey:@"childItems"] objectAtIndex:0] objectForKey:@"itemtype"] intValue])
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
    progress.keyid = [[[temDict objectForKey:@"childItems"] objectAtIndex:0] objectForKey:@"id"];
    [self.navigationController pushViewController:progress animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1+[[[dataArray objectAtIndex:section]objectForKey:@"childItems"]count]+1;
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
            [labRight setFrame:CGRectMake(WIDTH-70, 0, 60, 35)];
            labRight.tag = 14;
            [cell.contentView addSubview:labRight];
        }
        NSMutableDictionary * temDic = [dataArray objectAtIndex:indexPath.section];
        
        UILabel * labLeft = (UILabel*)[cell viewWithTag:10];
        [labLeft setText:[temDic objectForKey:@"shop_name"]];
        
        UILabel * labRight = (UILabel*)[cell viewWithTag:14];
        switch ([[[[temDic objectForKey:@"childItems"] objectAtIndex:0] objectForKey:@"itemtype"] intValue])
        {
            case 1:
            {
                [labRight setText:@"退款中"];
            }
                break;
            case 2:
            {
                [labRight setText:@"退款成功"];
            }
                break;
            case 3:
            {
                [labRight setText:@"退款失败"];
            }
                break;
            default:
                break;
        }
        
        return cell;
    }
    if ([[[dataArray objectAtIndex:indexPath.section]objectForKey:@"childItems"]count]+1 == indexPath.row)
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
            labLeft.tag = 11;
            [cell.contentView addSubview:labLeft];
            
            BBButton *twoBtn = [BBButton buttonWithType:UIButtonTypeCustom];
            twoBtn.tag = 12;
            [cell.contentView addSubview:twoBtn];
        }
        NSMutableDictionary *temDic = [dataArray objectAtIndex:indexPath.section];
        

        UILabel * labLeft = (UILabel *)[cell viewWithTag:11];
        BBButton * twoBtn = (BBButton*)[cell viewWithTag:12];
        twoBtn.btnSection = indexPath.section;
        

        NSString *temStr = [NSString stringWithFormat:@"合计：%.2f元",[[temDic objectForKey:@"total_fee"] floatValue]];
        
        NSMutableAttributedString *str = [[[NSMutableAttributedString alloc] initWithString:temStr]autorelease];
        
        [str addAttribute:NSForegroundColorAttributeName value:BB_Gray range:NSMakeRange(0,3)];
        [str addAttribute:NSForegroundColorAttributeName value:BB_Blake range:NSMakeRange(3,[str length]-3)];
        
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0,3)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(3,[str length]-3)];
        
        [labLeft setAttributedText:str];
        

        
        
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
    NSMutableDictionary *temDic = [[[dataArray objectAtIndex:indexPath.section]objectForKey:@"childItems"] objectAtIndex:indexPath.row-1];
 
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


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row)
    {
        return 35;
    }
    if ([[[dataArray objectAtIndex:indexPath.section]objectForKey:@"childItems"]count]+1 == indexPath.row)
    {
        return 40;
    }
    return 95;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (1 == indexPath.row)
    {
        NSMutableDictionary * temDict = [dataArray objectAtIndex:indexPath.section];
        RefundedDetailVC * detail = [[[RefundedDetailVC alloc] init] autorelease];
        switch ([[[[temDict objectForKey:@"childItems"] objectAtIndex:0] objectForKey:@"itemtype"] intValue])
        {
            case 1:
            {
                detail.keytype = @"1";
            }
                break;
            case 2:
            {
                detail.keytype = @"2";
            }
                break;
            case 3:
            {
                detail.keytype = @"3";
            }
                break;
            default:
                break;
        }
        detail.keyid = [temDict objectForKey:@"id"];
        detail.progressid = [[[temDict objectForKey:@"childItems"] objectAtIndex:0] objectForKey:@"id"];
        [self.navigationController pushViewController:detail animated:YES];
    }
}


- (void)requestBillList
{
    NSString *token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token forKey:@"token"];
    [dic setObject:@"7" forKey:@"keytype"];
    [dic setObject:[NSString stringWithFormat:@"%d",(int)currentPage] forKey:@"page"];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_BILL_LIST] target:self selector:@selector(responseBillList:) parameter:dic];
}
- (void)responseBillList:(NSDictionary*)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        if (!dataArray)
        {
            self.dataArray = [[[NSMutableArray alloc]init]autorelease];
        }
        if(0 == currentPage)
        {
            if (dataArray.count != 0)
            {
                [mytable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            }
            [dataArray removeAllObjects];
        }
        NSString *val=[[info objectForKey:@"infor"]objectForKey:@"listItems"];
        if ([XtomFunction xfunc_check_strEmpty:val])
        {
            [self forbidAddMore];
            isEnd = YES;
            if(isMore)
            {
                [self getNoMoreData];
            }
        }
        else
        {
            NSArray *temArr = [[info objectForKey:@"infor"]objectForKey:@"listItems"];
            if ([temArr count] == 0)
            {
                [self forbidAddMore];
                isEnd = YES;
                if(isMore)
                    [self getNoMoreData];
            }
            else
            {
                
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
                    [self.dataArray addObject:dict];
                }
            }
        }
    }
    else
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
    if(0 == dataArray.count)
    {
        [self showNoDataView:@"您还没有相关的订单"];
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
