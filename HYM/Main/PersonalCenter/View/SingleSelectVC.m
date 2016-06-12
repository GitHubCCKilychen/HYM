//
//  SingleSelectVC.m
//  PingChuan
//
//  Created by LarryRodic on 15/3/19.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "SingleSelectVC.h"

@interface SingleSelectVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger selectRow;
}
@end

@implementation SingleSelectVC
@synthesize myTableView;
@synthesize dataSource;

@synthesize delegate;
@synthesize parentid;
@synthesize firstId;
@synthesize firstName;
@synthesize keyType;
@synthesize keyName;

-(void)dealloc
{
    [myTableView release];myTableView = nil;
    [dataSource release];dataSource = nil;
    [parentid release];parentid = nil;
    [firstId release];firstId = nil;
    [firstName release];firstName = nil;
    [keyName release];keyName = nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self loadSet];
}
-(void)loadSet
{
    //导航
    self.view.backgroundColor = BB_Back_Color_Here;
    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftbtnPressed:) image:@"common_return.png" imageH:@"common_return.png"];
    if (keyType == 0)
    {
        [self.navigationItem setRightItemWithTarget:self action:@selector(rightbtnPressed:) title:@"完成"];
    }
    if (keyType == 1)
    {
        if ([keyName isEqualToString:@"district"])
        {
            [self.navigationItem setRightItemWithTarget:self action:@selector(rightbtnPressed:) title:@"完成"];
        }
    }
    
    //table
    self.myTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, UI_View_Hieght) style:UITableViewStyleGrouped]autorelease];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    [myTableView setBackgroundView:nil];
    [myTableView setSeparatorInset:UIEdgeInsetsMake(0, 17, 0, 0)];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myTableView];
    
    if (keyType == 2)
    {
        self.view.backgroundColor = BB_White_Color;
    }
}
-(void)loadData
{
    selectRow = -1;
    [self requestCityList];
}
#pragma mark- 自定义
#pragma mark- 事件
-(void)leftbtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightbtnPressed:(id)sender
{
    if (keyType == 0)
    {
        if (selectRow == -1)
        {
            [XtomFunction openIntervalHUD:@"还未选择" view:nil];
            return;
        }else
        {
            [delegate SingleSelectOK:[dataSource objectAtIndex:selectRow] parentid:self.parentid keyName:self.keyName];
        }
        [self leftbtnPressed:nil];
    }
    if (keyType == 1)
    {
        if (selectRow == -1)
        {
            [XtomFunction openIntervalHUD:@"还未选择" view:nil];
            return;
        }else
        {
            [delegate SingleSelectOK:[dataSource objectAtIndex:selectRow] parentid:self.parentid keyName:self.keyName];
        }
        UIViewController *myVC = (UIViewController*)self.delegate;
        [self.navigationController popToViewController:myVC animated:YES];
    }
}
#pragma mark - UITableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BWMyInforTop11Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = BB_White_Color;
        
        //左侧
        UILabel *labLeft = [[[UILabel alloc]init]autorelease];
        labLeft.backgroundColor = [UIColor clearColor];
        labLeft.textAlignment = NSTextAlignmentLeft;
        labLeft.font = [UIFont systemFontOfSize:15];
        labLeft.tag = 10;
        [labLeft setTextColor:BB_Blake];
        [cell.contentView addSubview:labLeft];
        
        //右侧按钮
        UIImageView *rightImgView = [[[UIImageView alloc]init]autorelease];
        [rightImgView setFrame:CGRectMake(277, 14, 20, 20)];
        rightImgView.tag = 12;
        [cell.contentView addSubview:rightImgView];
    }
    NSMutableDictionary *temDic = [dataSource objectAtIndex:indexPath.row];
    
    UILabel *labLeft = (UILabel*)[cell viewWithTag:10];
    labLeft.frame = CGRectMake(17, 0, 250, 48);
    [labLeft setText:[temDic objectForKey:@"name"]];
    
    //右侧按钮
    UIImageView *rightImgView = (UIImageView*)[cell viewWithTag:12];
    if (selectRow == indexPath.row)
    {
        [rightImgView setImage:[UIImage imageNamed:@"支付方式_选中.png"]];
        [XtomFunction addbordertoView:rightImgView radius:0.0f width:0.0f color:[UIColor clearColor]];
    }else
    {
        [rightImgView setImage:nil];
        [XtomFunction addbordertoView:rightImgView radius:10.0f width:1.0f color:BB_Graylight];
    }
    
    if (keyType == 1)
    {
        if (![keyName isEqualToString:@"district"])
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [rightImgView setHidden:YES];
        }
    }
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[[UIView alloc]init]autorelease];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath
{
    if (keyType == 0)
    {
        //单选
        if (indexPath.row == selectRow)
        {
            selectRow = -1;
            [myTableView reloadData];
            return;
        }
        selectRow = indexPath.row;
        [myTableView reloadData];
        return;
    }
    
    if (keyType == 1)
    {
        if ([keyName isEqualToString:@"province"])
        {
            //市
            SingleSelectVC *select = [[[SingleSelectVC alloc]init]autorelease];
            select.delegate = self.delegate;
            select.keyType = self.keyType;
            select.keyName = @"city";
            select.parentid = [[dataSource objectAtIndex:indexPath.row] objectForKey:@"id"];
            [select.navigationItem setNewTitle:@"城市"];
            [self.navigationController pushViewController:select animated:YES];
            return;
        }
        if ([keyName isEqualToString:@"city"])
        {
            //区
            SingleSelectVC *select = [[[SingleSelectVC alloc]init]autorelease];
            select.delegate = self.delegate;
            select.keyType = self.keyType;
            select.keyName = @"district";
            select.parentid = [[dataSource objectAtIndex:indexPath.row] objectForKey:@"id"];
            [select.navigationItem setNewTitle:@"区县"];
            [self.navigationController pushViewController:select animated:YES];
            return;
        }
        if ([keyName isEqualToString:@"district"])
        {
            //单选
            if (indexPath.row == selectRow)
            {
                selectRow = -1;
                [myTableView reloadData];
                return;
            }
            selectRow = indexPath.row;
            [myTableView reloadData];
        }
    }
}
#pragma mark - 连接服务器
#pragma mark 城市地区列表(keytype == 0)
- (void)requestCityList
{
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:self.parentid?self.parentid:@"0" forKey:@"parentid"];
    
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_DISTRICT_LIST] target:self selector:@selector(responseCityList:) parameter:dic];
}
- (void)responseCityList:(NSDictionary*)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        if(![XtomFunction xfunc_check_strEmpty:[[info objectForKey:@"infor"]objectForKey:@"listItems"]])
        {
            if (!dataSource)
                self.dataSource = [[[NSMutableArray alloc]init]autorelease];
            [dataSource removeAllObjects];
            
            NSMutableArray *temArr = [[info objectForKey:@"infor"]objectForKey:@"listItems"];
            
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
                if (![XtomFunction xfunc_check_strEmpty:self.firstId])
                {
                    if ([[dict objectForKey:@"id"]isEqualToString:firstId])
                    {
                        selectRow = i;
                    }
                }
                [self.dataSource addObject:dict];
            }
            
            [myTableView reloadData];
        }
    }else
    {
        if([info objectForKey:@"msg"])
        {
            [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:self.view];
        }
    }
}
@end
