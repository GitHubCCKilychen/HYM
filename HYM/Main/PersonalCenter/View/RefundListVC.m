//
//  RefundListVC.m
//  PingChuan
//
//  Created by pengli on 15/11/10.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "RefundListVC.h"
#import "OrderGoodCell.h"
#import "RefundVC.h"
#import "ReplyVC.h"

@interface RefundListVC ()

@property (nonatomic, retain) NSMutableArray * dataArray;
@property (nonatomic, copy) NSString * shipping_name;
@property (nonatomic, copy) NSString * shipping_num;
@property (nonatomic, assign) BOOL isSend;

@end

@implementation RefundListVC
@synthesize dataArray;
@synthesize shipping_name;
@synthesize shipping_num;
@synthesize isSend;

@synthesize keyid;
@synthesize keytype;

- (void)dealloc
{
    [dataArray release]; dataArray = nil;
    [shipping_name release]; shipping_name = nil;
    [shipping_num release]; shipping_num = nil;
    
    [keyid release]; keyid = nil;
    [keytype release]; keytype = nil;
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
    if ([keytype integerValue] == 1)
    {
        [self.navigationItem setNewTitle:@"申请退款"];
    }
    else
    {
        [self.navigationItem setNewTitle:@"商品评价"];
    }
    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftBtnPressed) image:@"common_return.png" imageH:@"common_return.png"];
    [self.view setBackgroundColor:BB_Back_Color_Here];
}

- (void)loadData
{
    [self requestOrderGoodsList];
}

- (void)leftBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refundOrReply:(BBButton *)button
{
    if ([keytype integerValue] == 1)
    {
        RefundVC * refund = [[[RefundVC alloc] init] autorelease];
        refund.dataSource = [dataArray objectAtIndex:button.btnSection];
        refund.shipping_name = self.shipping_name;
        refund.shipping_num = self.shipping_num;
        refund.isSend = self.isSend;
        
        [self.navigationController pushViewController:refund animated:YES];
    }
    else
    {
        ReplyVC * reply = [[[ReplyVC alloc] init] autorelease];
        reply.keyid = [[dataArray objectAtIndex:button.btnSection] objectForKey:@"id"];
        [self.navigationController pushViewController:reply animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row)
    {
        static NSString * cellID = @"RefundCell01";
        OrderGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil)
        {
            cell = [[[OrderGoodCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = BB_White_Color;
        }
        NSMutableDictionary *temDic = [dataArray objectAtIndex:indexPath.section];
        
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
    
    static NSString * cellID = @"RefundCell00";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = BB_White_Color;
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        
        BBButton *refundBtn = [BBButton buttonWithType:UIButtonTypeCustom];
        refundBtn.tag = 11;
        refundBtn.frame = CGRectMake(WIDTH-68, 5, 56, 30);
        
        [refundBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [XtomFunction addbordertoView:refundBtn radius:4 width:0.5 color:[UIColor blackColor]];
        [refundBtn setBackgroundColor:[UIColor whiteColor]];
        refundBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [cell.contentView addSubview:refundBtn];
    }
    BBButton *refundBtn = (BBButton *)[cell viewWithTag:11];
    refundBtn.btnSection = indexPath.section;
    if ([keytype integerValue] == 1)
    {
        [refundBtn setTitle:@"退款" forState:UIControlStateNormal];
    }
    else
    {
        [refundBtn setTitle:@"评价" forState:UIControlStateNormal];
    }
    [refundBtn addTarget:self action:@selector(refundOrReply:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row)
    {
        return 95;
    }
    return 40;
}


- (void)requestOrderGoodsList
{
    NSString *token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token?token:@"0" forKey:@"token"];
    [dic setObject:keyid forKey:@"id"];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_BILL_GET] target:self selector:@selector(responseOrderGoodsList:) parameter:dic];
}

- (void)responseOrderGoodsList:(NSDictionary *)info
{
    
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        if (!dataArray)
        {
            self.dataArray = [[[NSMutableArray alloc] init] autorelease];
        }
        [dataArray removeAllObjects];
        
        NSString * val = [[[info objectForKey:@"infor"] objectAtIndex:0] objectForKey:@"childItems"];
        if (![XtomFunction xfunc_check_strEmpty:val])
        {
            NSArray *temArr = [[[info objectForKey:@"infor"] objectAtIndex:0] objectForKey:@"childItems"];
            for (int i = 0; i<temArr.count; i++)
            {
                NSMutableDictionary * dict = [[[NSMutableDictionary alloc] init] autorelease];
                NSDictionary * temDict = [temArr objectAtIndex:i];
                for(NSString * key in temDict.allKeys)
                {
                    NSString * value = [temDict objectForKey:key];
                    
                    if(![XtomFunction xfunc_check_strEmpty:value])
                    {
                        [dict setObject:value forKey:key];
                    }
                }
                [self.dataArray addObject:dict];
            }
            self.shipping_name = [[[info objectForKey:@"infor"] objectAtIndex:0] objectForKey:@"shipping_name"];
            self.shipping_num = [[[info objectForKey:@"infor"] objectAtIndex:0] objectForKey:@"shipping_num"];
            self.isSend = [[[[info objectForKey:@"infor"] objectAtIndex:0] objectForKey:@"sendflag"] boolValue];
            [mytable reloadData];
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

-(void)reShowView
{
    if(0 == dataArray.count)
    {
        [self showNoDataView:@"暂无数据"];
    }
    else
    {
        [self hideNoDataView];
    }
    [mytable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
