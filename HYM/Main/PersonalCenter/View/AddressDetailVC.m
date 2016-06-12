//
//  AddressDetailVC.m
//  PingChuan
//
//  Created by LarryRodic on 15/3/19.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "AddressDetailVC.h"
#import "BWEditorVC.h"
#import "SendReplyVC.h"
#import "SingleSelectVC.h"
#import "BWTextView.h"

@interface AddressDetailVC ()<UITableViewDataSource,UITableViewDelegate,EditerDelegate,SendReplyDelegate,SingleSelectDelegate>
{
    MBProgressHUD *waitMB;
    NSInteger selectIndex;// 选中的行数
}
@property(nonatomic,retain)UITableView *myTableView;
@property (nonatomic, retain) UITextField * nameField;
@property (nonatomic, retain) UITextField * telField;
@property (nonatomic, retain) UITextField * detailField;
@property (nonatomic, retain) UITextField * emailField;
@end

@implementation AddressDetailVC
@synthesize myTableView;
@synthesize nameField;
@synthesize telField;
@synthesize detailField;
@synthesize emailField;

@synthesize dataSource;

-(void)dealloc
{
    [myTableView release];myTableView = nil;
    [nameField release]; nameField = nil;
    [telField release]; telField = nil;
    [dataSource release]; dataSource = nil;
    [emailField release]; emailField = nil;
    
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
    [self.navigationItem setNewTitle:@"新增收货地址"];
    self.view.backgroundColor = BB_Back_Color_Here;
    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftbtnPressed:) image:@"common_return.png" imageH:@"common_return.png"];
    
    [self.navigationItem setRightItemWithTarget:self action:@selector(rightbtnPressed:) title:@"保存"];
    
    //table
    self.myTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, UI_View_Hieght) style:UITableViewStyleGrouped]autorelease];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    [myTableView setBackgroundView:nil];
    [myTableView setSeparatorInset:UIEdgeInsetsMake(0, 12, 0, 0)];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myTableView];
}
-(void)loadData
{
    if (!self.dataSource)
    {
        self.dataSource = [[[NSMutableDictionary alloc] init] autorelease];
    }
    selectIndex = -1;
}
#pragma mark- 自定义
#pragma mark 事件
-(void)leftbtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightbtnPressed:(id)sender
{
    [self requestSaveAddress];
}
#pragma mark- InforEditer Delegate
- (void)inforEditer:(BWEditorVC *)inforEditer backValue:(NSString *)value
{
    if(inforEditer.key)
    {
        if(!value)
            value = @"";
        [dataSource setObject:value forKey:inforEditer.key];
        [myTableView reloadData];
    }
}
-(void)sendReplyOK:(ContentType)sendType content:(NSString*)content
{
    [dataSource setObject:content forKey:@"address"];
    [myTableView reloadData];
}
#pragma mark- SingleSelect Delegate
//选取城市
-(void)SingleSelectOK:(NSMutableDictionary*)backDic parentid:(NSString*)parentid keyName:(NSString*)keyName
{
    //省
    if ([keyName isEqualToString:@"province"])
    {
        if ([[backDic objectForKey:@"id"]isEqualToString:[dataSource objectForKey:@"province_id"]])
        {
            return;
        }else
        {
            [dataSource setObject:[backDic objectForKey:@"id"] forKey:@"province_id"];
            [dataSource setObject:[backDic objectForKey:@"name"] forKey:@"province"];
            [dataSource setObject:@"" forKey:@"city_id"];
            [dataSource setObject:@"" forKey:@"city"];
            [dataSource setObject:@"" forKey:@"district_id"];
            [dataSource setObject:@"" forKey:@"district"];
        }
    }
    //市
    if ([keyName isEqualToString:@"city"])
    {
        if ([[backDic objectForKey:@"id"]isEqualToString:[dataSource objectForKey:@"city_id"]])
        {
            return;
        }else
        {
            [dataSource setObject:[backDic objectForKey:@"id"] forKey:@"city_id"];
            [dataSource setObject:[backDic objectForKey:@"name"] forKey:@"city"];
            [dataSource setObject:@"" forKey:@"district_id"];
            [dataSource setObject:@"" forKey:@"district"];
        }
    }
    //区
    if ([keyName isEqualToString:@"district"])
    {
        if ([[backDic objectForKey:@"id"]isEqualToString:[dataSource objectForKey:@"district_id"]])
        {
            return;
        }else
        {
            [dataSource setObject:[backDic objectForKey:@"id"] forKey:@"district_id"];
            [dataSource setObject:[backDic objectForKey:@"name"] forKey:@"district"];
        }
    }
    [myTableView reloadData];
}

#pragma mark - UITableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (5 == indexPath.row)
    {
        static NSString *CellIdentifier = @"BWMyInforTopCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = BB_White_Color;
        }else
        {
            for(UIView *view in cell.contentView.subviews)
            {
                [view removeFromSuperview];
            }
        }
        
        //说明
        UILabel *labInfor = [[[UILabel alloc]init]autorelease];
        labInfor.backgroundColor = [UIColor clearColor];
        [labInfor setFrame:CGRectMake(12, 11, 150, 24)];
        labInfor.textAlignment = NSTextAlignmentLeft;
        labInfor.font = [UIFont systemFontOfSize:16];
        labInfor.text = @"详细地址";
        [labInfor setTextColor:BB_Graydark];
        [cell.contentView addSubview:labInfor];
        
        //详细地址
        UILabel *labLeft = [[[UILabel alloc]init]autorelease];
        labLeft.backgroundColor = [UIColor clearColor];
        labLeft.textAlignment = NSTextAlignmentLeft;
        labLeft.font = [UIFont systemFontOfSize:16];
        labLeft.numberOfLines = 0;
        if ([XtomFunction xfunc_check_strEmpty:[dataSource objectForKey:@"address"]])
        {
            [labLeft setText:@"请输入详细地址（除去省市区）"];
            [labLeft setTextColor:BB_Gray];
        }
        else
        {
            [labLeft setText:[dataSource objectForKey:@"address"]];
            [labLeft setTextColor:BB_Blake];
        }
        
        [cell.contentView addSubview:labLeft];
        
        CGSize temSize = [XtomFunction getSizeWithStrNo:labLeft.text width:278 font:16];
        [labLeft setFrame:CGRectMake(12, 45, 278, temSize.height)];
        return cell;
    }
    static NSString * CellIdentifier = @"AddressDetailCell00";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = BB_White_Color;
        
        //左侧
        UILabel * labLeft = [[[UILabel alloc]init]autorelease];
        labLeft.backgroundColor = [UIColor clearColor];
        labLeft.textAlignment = NSTextAlignmentLeft;
        labLeft.font = [UIFont systemFontOfSize:16];
        labLeft.textColor = BB_Graydark;
        labLeft.tag = 10;
        [cell.contentView addSubview:labLeft];
        
        //右侧
        UILabel * labRight = [[[UILabel alloc]init]autorelease];
        labRight.backgroundColor = [UIColor clearColor];
        labRight.textAlignment = NSTextAlignmentLeft;
        labRight.textColor = BB_Blake;
        labRight.font = [UIFont systemFontOfSize:16];
        labRight.tag = 11;
        [cell.contentView addSubview:labRight];
    }
    UITextField * labRight1 = (UITextField *)[cell viewWithTag:11];
    labRight1.frame = CGRectMake(110, 0, WIDTH-130, 50);
    
    if (2 == indexPath.row || 3 == indexPath.row || 4 == indexPath.row)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    NSMutableArray *temArr = [[[NSMutableArray alloc] initWithObjects:@"收件人", @"联系电话", @"省份", @"城市", @"区县", @"详细地址", @"邮编", nil] autorelease];
    
    UILabel *labLeft = (UILabel*)[cell viewWithTag:10];
    labLeft.frame = CGRectMake(12, 0, 90, 50);
    labLeft.text = [temArr objectAtIndex:indexPath.row];
    
    UILabel *labRight = (UILabel*)[cell viewWithTag:11];
    switch (indexPath.row)
    {
        case 0:
            [labRight setText:[dataSource objectForKey:@"name"]];
            break;
        case 1:
            [labRight setText:[dataSource objectForKey:@"tel"]];
            break;
        case 2:
            [labRight setText:[dataSource objectForKey:@"province"]];
            break;
        case 3:
            [labRight setText:[dataSource objectForKey:@"city"]];
            break;
        case 4:
            [labRight setText:[dataSource objectForKey:@"district"]];
            break;
        case 6:
            [labRight setText:[dataSource objectForKey:@"zipcode"]];
            break;
        default:
            break;
    }
    
    return cell;
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
    if (5 == indexPath.row)
    {
        if (![XtomFunction xfunc_check_strEmpty:[dataSource objectForKey:@"address"]])
        {
            CGSize temSize = [XtomFunction getSizeWithStrNo:[dataSource objectForKey:@"address"] width:278 font:16];
            return temSize.height + 45 + 10;
        }
        return 100;
    }
    return 55;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath
{
    if (0 == indexPath.row)
    {
        BWEditorVC *editor = [[[BWEditorVC alloc]init]autorelease];
        editor.editorType = BWEditorTypeSinleInput;
        editor.key = @"name";
        editor.title = @"收件人姓名";
        editor.content = [dataSource objectForKey:@"name"];
        editor.explanation = @"收件人姓名不能超过八个字";
        editor.mymaxlength = 8;
        editor.keyBoardType = UIKeyboardTypeDefault;
        editor.delegate = self;
        [self.navigationController pushViewController:editor animated:YES];
    }
    if (1 == indexPath.row)
    {
        BWEditorVC *editor = [[[BWEditorVC alloc]init]autorelease];
        editor.editorType = BWEditorTypeSinleInput;
        editor.key = @"tel";
        editor.title = @"电话";
        editor.mymaxlength = 20;
        editor.content = [dataSource objectForKey:@"tel"];
        editor.keyBoardType = UIKeyboardTypePhonePad;
        editor.delegate = self;
        [self.navigationController pushViewController:editor animated:YES];
    }
    if (2 == indexPath.row)
    {
        //省
        SingleSelectVC *select = [[[SingleSelectVC alloc]init]autorelease];
        select.delegate = self;
        select.keyType = 0;
        select.keyName = @"province";
        select.parentid = @"0";
        if (![XtomFunction xfunc_check_strEmpty:[dataSource objectForKey:@"province_id"]])
        {
            select.firstId = [dataSource objectForKey:@"province_id"];
        }
        [select.navigationItem setNewTitle:@"省份"];
        [self.navigationController pushViewController:select animated:YES];
    }
    if (3 == indexPath.row)
    {
        if ([XtomFunction xfunc_check_strEmpty:[dataSource objectForKey:@"province_id"]])
        {
            [XtomFunction openIntervalHUD:@"请先选择省份" view:nil];
            return;
        }
        //市
        SingleSelectVC *select = [[[SingleSelectVC alloc]init]autorelease];
        select.delegate = self;
        select.keyType = 0;
        select.keyName = @"city";
        select.parentid = [dataSource objectForKey:@"province_id"];
        if (![XtomFunction xfunc_check_strEmpty:[dataSource objectForKey:@"city_id"]])
        {
            select.firstId = [dataSource objectForKey:@"city_id"];
        }
        [select.navigationItem setNewTitle:@"城市"];
        [self.navigationController pushViewController:select animated:YES];
    }
    if (4 == indexPath.row)
    {
        if ([XtomFunction xfunc_check_strEmpty:[dataSource objectForKey:@"city_id"]])
        {
            [XtomFunction openIntervalHUD:@"请先选择城市" view:nil];
            return;
        }
        //区
        SingleSelectVC *select = [[[SingleSelectVC alloc]init]autorelease];
        select.delegate = self;
        select.keyType = 0;
        select.keyName = @"district";
        select.parentid = [dataSource objectForKey:@"city_id"];
        if (![XtomFunction xfunc_check_strEmpty:[dataSource objectForKey:@"district_id"]])
        {
            select.firstId = [dataSource objectForKey:@"district_id"];
        }
        [select.navigationItem setNewTitle:@"区县"];
        [self.navigationController pushViewController:select animated:YES];
    }
    if (5 == indexPath.row)
    {
        SendReplyVC *reply = [[[SendReplyVC alloc]init]autorelease];
        reply.publishContent = [dataSource objectForKey:@"address"];
        reply.delegate = self;
        reply.sendType = ContentTypeInfor;
        reply.isPush = YES;
        [self.navigationController pushViewController:reply animated:YES];
    }
    if (6 == indexPath.row)
    {
        BWEditorVC *editor = [[[BWEditorVC alloc]init]autorelease];
        editor.editorType = BWEditorTypeSinleInput;
        editor.key = @"zipcode";
        editor.title = @"邮编";
        editor.mymaxlength = 10;
        editor.content = [dataSource objectForKey:@"zipcode"];
        editor.keyBoardType = UIKeyboardTypePhonePad;
        editor.delegate = self;
        [self.navigationController pushViewController:editor animated:YES];
    }
}
#pragma mark- 连接服务器
#pragma mark 保存收货地址
- (void)requestSaveAddress
{
    if ([XtomFunction xfunc_check_strEmpty:[dataSource objectForKey:@"name"]])
    {
        [XtomFunction openIntervalHUD:@"收件人姓名不能为空" view:self.view];
        return;
    }
    if ([XtomFunction xfunc_check_strEmpty:[dataSource objectForKey:@"tel"]])
    {
        [XtomFunction openIntervalHUD:@"电话号码不能为空" view:self.view];
        return;
    }
    if ([XtomFunction xfunc_check_strEmpty:[dataSource objectForKey:@"province"]])
    {
        [XtomFunction openIntervalHUD:@"省份不能为空" view:self.view];
        return;
    }
    if ([XtomFunction xfunc_check_strEmpty:[dataSource objectForKey:@"city"]])
    {
        [XtomFunction openIntervalHUD:@"城市不能为空" view:self.view];
        return;
    }
    if ([XtomFunction xfunc_check_strEmpty:[dataSource objectForKey:@"district"]])
    {
        [XtomFunction openIntervalHUD:@"区县不能为空" view:self.view];
        return;
    }
//    if ([XtomFunction xfunc_check_strEmpty:[dataSource objectForKey:@"zipcode"]])
//    {
//        [XtomFunction openIntervalHUD:@"邮编不能为空" view:self.view];
//        return;
//    }
    if ([XtomFunction xfunc_check_strEmpty:[dataSource objectForKey:@"address"]])
    {
        [XtomFunction openIntervalHUD:@"详细地址不能为空" view:self.view];
        return;
    }
    
//    if (![XtomFunction xfunc_isMobileNumber:[dataSource objectForKey:@"tel"]])
//    {
//        [XtomFunction openIntervalHUD:@"请填写正确的电话号码" view:self.view];
//        return;
//    }
    
    waitMB = [XtomFunction openHUD:@"正在保存" view:self.view];
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] init];
    [paraDic setObject:[[XtomManager sharedManager] userToken] forKey:@"token"];
    [paraDic setObject:@"0" forKey:@"id"];
    [paraDic setObject:[dataSource objectForKey:@"name"] forKey:@"name"];
    [paraDic setObject:[dataSource objectForKey:@"tel"] forKey:@"tel"];
    [paraDic setObject:[dataSource objectForKey:@"province_id"] forKey:@"province_id"];
    [paraDic setObject:[dataSource objectForKey:@"city_id"] forKey:@"city_id"];
    [paraDic setObject:[dataSource objectForKey:@"district_id"] forKey:@"district_id"];
    [paraDic setObject:[dataSource objectForKey:@"address"] forKey:@"address"];
    [paraDic setObject:[dataSource objectForKey:@"zipcode"]?[dataSource objectForKey:@"zipcode"]:@"" forKey:@"zipcode"];
    [paraDic setObject:@"0" forKey:@"defaultflag"];
    NSString *url = [NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_ADDRESS_SAVE];
    [XTomRequest requestWithURL:url target:self selector:@selector(responseSaveAddress:) parameter:paraDic];
}
- (void)responseSaveAddress:(NSDictionary*)info
{
    [XtomFunction closeHUD:waitMB];
    NSString *status = [info objectForKey:@"success"];
    if(![XtomFunction xfunc_check_strEmpty:status])
    {
        if(1 == [status intValue])
        {
            [XtomFunction openIntervalHUDOK:@"收货地址保存成功" view:self.view];
            [self.navigationController popViewControllerAnimated:YES];
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
