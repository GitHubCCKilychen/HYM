
//
//  UserAddressListVC.m
//  PingChuan
//
//  Created by pengli on 15/10/12.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "UserAddressVC.h"
#import "BBButton.h"
#import "SwipeGR.h"
#import "AddressDetailVC.h"

@interface UserAddressVC ()< UIGestureRecognizerDelegate>
{
    BOOL isSwipe;
    MBProgressHUD * waitMB;
    NSInteger rowDelete;
    NSInteger rowSwipe;
    NSInteger selectIndex;
}
@property (nonatomic, retain) NSMutableArray * dataArray;
@property (nonatomic, retain) NSMutableDictionary * dataSource;
@end

@implementation UserAddressVC
@synthesize dataArray;
@synthesize dataSource;

- (void)dealloc
{
    [dataArray release]; dataArray = nil;
    [dataSource release]; dataSource = nil;
    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadSet];
}
- (void)loadSet
{
    [self.navigationItem setNewTitle:@"添加收货地址"];
    self.view.backgroundColor = BB_Back_Color_Here;
    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftBtnPressed) image:@"common_return.png" imageH:@"common_return.png"];
    rowSwipe = -1;
    rowDelete = -1;
    [self forbidAddMore];
}
- (void)loadData
{
    self.dataSource  = [[[NSMutableDictionary alloc] init] autorelease];
    [self requestAddressList];
}
- (void)leftBtnPressed
{
    [self.delegate saveAddressInfo:dataSource];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)touchButtonAtIndex:(BBButton *)button
{
    rowDelete = button.btnRow;
    NSMutableDictionary * temDict = [dataArray objectAtIndex:button.btnRow];
    if ([[temDict objectForKey:@"defaultflag"] integerValue] == 1)
    {
        [XtomFunction openIntervalHUD:@"不可以删除默认收货地址！" view:self.view];
        return;
    }
    [self requestRemoveAddressWithKeyid:[temDict objectForKey:@"id"]];
}
-(void)swipeGestureHandler:(SwipeGR *)sender
{
    if (isSwipe)
    {
        isSwipe = NO;
        [mytable reloadData];
        return;
    }
    else
    {
        isSwipe = YES;
        if (sender.direction == UISwipeGestureRecognizerDirectionLeft)
        {
            if (rowSwipe == [sender.touchRow integerValue])
            {
                return;
            }
            rowSwipe = [sender.touchRow integerValue];
            UITableViewCell * temCell = (UITableViewCell *)[mytable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:rowSwipe inSection:0]];
            for (int i = 0; i < self.dataArray.count; i++)
            {
                UITableViewCell * allCell= (UITableViewCell *)[mytable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                [self actionActive];
                UIView * leftView = (UIView *)[allCell viewWithTag:10];
                float height = leftView.frame.size.height;
                [leftView setFrame:CGRectMake(0, 0, 320, height)];
                [UIView commitAnimations];
            }
            UIView * leftView = (UIView *)[temCell viewWithTag:10];
            if (leftView.frame.origin.x >= 0)
            {
                [self actionActive];
                float height = leftView.frame.size.height;
                [leftView setFrame:CGRectMake(-84, 0, 320, height)];
                [UIView commitAnimations];
            }
        }
        if (sender.direction == UISwipeGestureRecognizerDirectionRight)
        {
            UITableViewCell * temCell = (UITableViewCell *)[mytable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:rowSwipe inSection:0]];
            UIView * leftView = (UIView *)[temCell viewWithTag:10];
            if (leftView.frame.origin.x < 0)
            {
                isSwipe = NO;
                [self actionActive];
                float height = leftView.frame.size.height;
                [leftView setFrame:CGRectMake(0, 0, 320, height)];
                [UIView commitAnimations];
                rowSwipe = -1;
            }
        }
    }
}
-(void)actionActive
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25f];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:nil cache:NO];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:nil];
}
-(void)timerSetNotice:(NSTimer*)sender
{
    [self reShowView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dataArray.count==indexPath.row)
    {
        static NSString * cellID = @"AddressCell01";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = BB_White_Color;
            UIImageView * addView = [[[UIImageView alloc]init]autorelease];
            [addView setFrame:CGRectMake(13, 16.5, 22, 22)];
            addView.image = [UIImage imageNamed:@"address_add.png"];
            [cell.contentView addSubview:addView];
            UILabel * addLabel = [[[UILabel alloc]init]autorelease];
            addLabel.backgroundColor = [UIColor clearColor];
            addLabel.textAlignment = NSTextAlignmentLeft;
            addLabel.font = [UIFont systemFontOfSize:15];
            addLabel.textColor = [UIColor grayColor];
            [addLabel setFrame:CGRectMake(45, 0, 250, 56)];
            addLabel.text = @"添加收货地址";
            [cell.contentView addSubview:addLabel];
        }
        return cell;
    }
    static NSString * cellID = @"AddressCell02";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = BB_White_Color;
        BBButton * btnRight = [BBButton buttonWithType:UIButtonTypeCustom];
        btnRight.frame = CGRectMake(WIDTH - 72, 0, 72, 75);
        btnRight.backgroundColor = [UIColor colorWithRed:255/255.f green:59/255.f blue:110/255.f alpha:1];
        [btnRight setTitle:@"删除" forState:UIControlStateNormal];
        [btnRight setTitleColor:BB_White_Color forState:UIControlStateNormal];
        btnRight.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        btnRight.tag = 9;
        [cell.contentView addSubview:btnRight];
        UIView * leftView = [[[UIView alloc]init]autorelease];
        leftView.tag = 10;
        leftView.frame = CGRectMake(0, 0, WIDTH, 75);
        leftView.backgroundColor = BB_White_Color;
        [cell.contentView addSubview:leftView];
        UIImageView * headImage = [[[UIImageView alloc] init] autorelease];
        headImage.frame = CGRectMake(11.5, 18.5, 16.5, 16.5);
        headImage.image = [UIImage imageNamed:@"地址_名称图标新.png"];
        headImage.userInteractionEnabled = YES;
        [leftView addSubview:headImage];
        UILabel * name = [[[UILabel alloc] init] autorelease];
        name.tag = 11;
        name.frame = CGRectMake(35, 14, 220, 23);
        name.textColor = [UIColor blackColor];
        name.textAlignment = NSTextAlignmentLeft;
        name.font = [UIFont systemFontOfSize:16];
        [leftView addSubview:name];
        UIImageView * telImage = [[[UIImageView alloc] init] autorelease];
        telImage.frame = CGRectMake(100, 18.5, 16.5, 16.5);
        telImage.image = [UIImage imageNamed:@"地址_电话图标新.png"];
        telImage.userInteractionEnabled = YES;
        [leftView addSubview:telImage];
        UILabel * tel = [[[UILabel alloc] init] autorelease];
        tel.tag = 12;
        tel.frame = CGRectMake(120, 14, 150, 23);
        tel.textColor = [UIColor blackColor];
        tel.textAlignment = NSTextAlignmentLeft;
        tel.font = [UIFont systemFontOfSize:16];
        [leftView addSubview:tel];
        UILabel * address = [[[UILabel alloc] init] autorelease];
        address.tag = 13;
        address.frame = CGRectMake(15, 42, WIDTH-71, 23);
        address.textColor = [UIColor grayColor];
        address.textAlignment = NSTextAlignmentLeft;
        address.font = [UIFont systemFontOfSize:16];
        address.numberOfLines = 0;
        [leftView addSubview:address];
        UIImageView * selectImage = [[[UIImageView alloc] init] autorelease];
        selectImage.tag = 14;
        selectImage.frame = CGRectMake(WIDTH-39, 27, 22, 22);
        selectImage.image = [UIImage imageNamed:@"支付方式_选中.png"];
        selectImage.userInteractionEnabled = YES;
        [leftView addSubview:selectImage];
    }
    UIView * leftView = (UIView *)[cell viewWithTag:10];
    SwipeGR *myswipeGesture = [[[SwipeGR alloc]init]autorelease];
    myswipeGesture.touchRow = [NSString stringWithFormat:@"%ld",indexPath.row];
    [myswipeGesture setDirection:UISwipeGestureRecognizerDirectionRight];
    [myswipeGesture addTarget:self action:@selector(swipeGestureHandler:)];
    [leftView addGestureRecognizer:myswipeGesture];
    myswipeGesture = [[[SwipeGR alloc]init]autorelease];
    myswipeGesture.touchRow = [NSString stringWithFormat:@"%ld",indexPath.row];
    [myswipeGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
    [myswipeGesture addTarget:self action:@selector(swipeGestureHandler:)];
    [leftView addGestureRecognizer:myswipeGesture];
    BBButton * btnRight = (BBButton *)[cell viewWithTag:9];
    btnRight.btnRow = indexPath.row;
    [btnRight addTarget:self action:@selector(touchButtonAtIndex:) forControlEvents:UIControlEventTouchUpInside];
    isSwipe = NO;
    rowSwipe = -1;
    rowDelete = -1;
    NSMutableDictionary * temDict = [dataArray objectAtIndex:indexPath.row];
    UILabel * name = (UILabel *)[cell viewWithTag:11];
    name.text = [temDict objectForKey:@"name"];
    UILabel * tel = (UILabel *)[cell viewWithTag:12];
    tel.text = [temDict objectForKey:@"tel"];
    UILabel * address = (UILabel *)[cell viewWithTag:13];
    [address setText:[NSString stringWithFormat:@"%@%@", [temDict objectForKey:@"position"], [temDict objectForKey:@"address"]]];
    CGSize addressSize = [XtomFunction getSizeWithStrNo:address.text width:WIDTH-71 font:16];
    address.frame = CGRectMake(15, 42, WIDTH-71, addressSize.height);
    leftView.frame = CGRectMake(0, 0, WIDTH, addressSize.height+52);
    btnRight.frame = CGRectMake(WIDTH - 72, 0, 72, addressSize.height+52);
    UIImageView * imgSelect = (UIImageView *)[cell viewWithTag:14];
    if ([[temDict objectForKey:@"defaultflag"] integerValue] == 1)
    {
        [imgSelect setImage:[UIImage imageNamed:@"支付方式_选中.png"]];
        [XtomFunction addbordertoView:imgSelect radius:0.0f width:0.0f color:[UIColor clearColor]];
    }
    else
    {
        [imgSelect setImage:nil];
        [XtomFunction addbordertoView:imgSelect radius:11.0f width:1.0f color:BB_Graylight];
    }
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headView = [[[UIView alloc] init] autorelease];
    return headView;
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
    if (dataArray.count == indexPath.row)
    {
        return 55;
    }
    NSMutableDictionary * temDict = [dataArray objectAtIndex:indexPath.row];
    CGSize addressSize = [XtomFunction getSizeWithStrNo:[NSString stringWithFormat:@"%@%@", [temDict objectForKey:@"position"], [temDict objectForKey:@"address"]] width:WIDTH-71 font:16];
    return 42+addressSize.height+10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isSwipe)
    {
        isSwipe = NO;
        [mytable reloadData];
        return;
    }
    if (dataArray.count == indexPath.row)
    {
        AddressDetailVC * detail = [[[AddressDetailVC alloc] init] autorelease];
        [self.navigationController pushViewController:detail animated:YES];
    }
    else
    {
        NSMutableDictionary * temDict = [[[NSMutableDictionary alloc] init] autorelease];
        for (int i = 0; i < dataArray.count; i++)
        {
            temDict = [dataArray objectAtIndex:i];
            [temDict setObject:@"0" forKey:@"defaultflag"];
        }
        temDict = [dataArray objectAtIndex:indexPath.row];
        [temDict setObject:@"1" forKey:@"defaultflag"];
        [self requestSettingUserInfo:temDict];
        [mytable reloadData];
        self.dataSource = temDict;
    }
}
- (void)requestSettingUserInfo:(NSDictionary *)dic
{
    NSString * token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary * paraDic = [[[NSMutableDictionary alloc] init]autorelease];
    [paraDic setObject:token?token:@"" forKey:@"token"];
    [paraDic setObject:[dic objectForKey:@"id"] forKey:@"id"];
    [paraDic setObject:[dic objectForKey:@"name"] forKey:@"name"];
    [paraDic setObject:[dic objectForKey:@"tel"] forKey:@"tel"];
    [paraDic setObject:[dic objectForKey:@"province_id"] forKey:@"province_id"];
    [paraDic setObject:[dic objectForKey:@"city_id"] forKey:@"city_id"];
    [paraDic setObject:[dic objectForKey:@"district_id"] forKey:@"district_id"];
    [paraDic setObject:[dic objectForKey:@"address"] forKey:@"address"];
    [paraDic setObject:dataSource[@"zipcode"]?dataSource[@"zipcode"]:@"" forKey:@"zipcode"];
    [paraDic setObject:@"1" forKey:@"defaultflag"];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_ADDRESS_SAVE] target:self selector:@selector(responseSettingUserInfo:) parameter:paraDic];
}
- (void)responseSettingUserInfo:(NSDictionary *)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        
    }
    else
    {
        if([info objectForKey:@"msg"])
        {
            [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:nil];
        }
    }
}
- (void)requestRemoveAddressWithKeyid:(NSString*)keyid
{
    NSString *token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token forKey:@"token"];
    [dic setObject:keyid forKey:@"id"];
    waitMB = [XtomFunction openHUD:@"正在删除" view:self.view];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_ADDRESS_REMOVE] target:self selector:@selector(responseRemoveAddress:) parameter:dic];
}
- (void)responseRemoveAddress:(NSDictionary*)info
{
    [XtomFunction closeHUD:waitMB];
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        [XtomFunction openIntervalHUDOK:@"已成功删除" view:self.view];
        [self.dataArray removeObjectAtIndex:rowDelete];
        [mytable deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:rowDelete inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(timerSetNotice:) userInfo:nil repeats:NO];
    }
    else
    {
        if([info objectForKey:@"msg"])
        {
            [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:nil];
        }
    }
}
- (void)requestAddressList
{
    NSString * token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary * paraDic = [[[NSMutableDictionary alloc] init]autorelease];
    [paraDic setObject:token?token:@"" forKey:@"token"];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_ADDRESS_LIST] target:self selector:@selector(responseAddressList:) parameter:paraDic];
}
- (void)responseAddressList:(NSDictionary *)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        if (!dataArray)
        {
            self.dataArray = [[[NSMutableArray alloc] init] autorelease];
        }
        [dataArray removeAllObjects];
        NSString * val = [[info objectForKey:@"infor"] objectForKey:@"listItems"];
        if (![XtomFunction xfunc_check_strEmpty:val])
        {
            [self forbidAddMore];
            NSArray * temArr = [[info objectForKey:@"infor"] objectForKey:@"listItems"];
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
        for (int i = 0; i < dataArray.count; i++)
        {
            NSMutableDictionary * temDict = [dataArray objectAtIndex:i];
            if ([[temDict objectForKey:@"defaultflag"] integerValue] == 1)
            {
                self.dataSource = temDict;
            }
        }
        [self reShowView];
    }
    else
    {
        if([info objectForKey:@"msg"])
        {
            [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:self.view];
        }
    }
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
        [self showNoDataView:@"暂无数据"];
    }
    else
    {
        [self hideNoDataView];
    }
    [mytable reloadData];
}

- (void)refresh
{
    [self requestAddressList];
}
@end
