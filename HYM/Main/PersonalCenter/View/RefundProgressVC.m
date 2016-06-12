//
//  RefundProgressVC.m
//  PingChuan
//
//  Created by pengli on 15/11/11.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "RefundProgressVC.h"

@interface RefundProgressVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView * myTableView;
@property (nonatomic, retain) NSMutableArray * dataArray;

@end

@implementation RefundProgressVC
@synthesize myTableView;
@synthesize dataArray;

@synthesize keytype;
@synthesize keyid;

- (void)dealloc
{
    [myTableView release]; myTableView = nil;
    [dataArray release]; dataArray = nil;
    [keytype release]; keytype = nil;
    [keyid release]; keyid = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadSet];
    [self loadData];
}

-(void)loadSet
{
    
    [self.navigationItem setNewTitle:@"售后进度"];
    self.view.backgroundColor = BB_Back_Color_Here;
    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftBtnPressed) image:@"common_return.png" imageH:@"common_return.png"];
    
    
    self.myTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UI_View_Hieght) style:UITableViewStyleGrouped]autorelease];
    [myTableView setBackgroundColor:[UIColor whiteColor]];
    [myTableView setBackgroundView:nil];
    [myTableView setSeparatorInset:UIEdgeInsetsMake(0, 50, 0, 0)];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myTableView];
    
    
}

- (void)loadData
{
    [self requestRefundProgress];
}

- (void)leftBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row)
    {
        static NSString *CellIdentifier = @"OrderDetailCell00";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = BB_White_Color;
            
            
            UIView * lineView = [[[UIView alloc] init] autorelease];
            lineView.backgroundColor = BB_Gray;
            lineView.tag = 9;
            [cell.contentView addSubview:lineView];
            
            UIImageView * downImgView = [[[UIImageView alloc]init]autorelease];
            [downImgView setImage:[UIImage imageNamed:@"我的店铺_蓝圈.png"]];
            [downImgView setFrame:CGRectMake(12.5, 22.5, 31/2, 15.5)];
            [cell.contentView addSubview:downImgView];
            
            UILabel * upLabel = [[[UILabel alloc] init] autorelease];
            upLabel.textColor = [UIColor colorWithRed:45/255.f green:137/255.f blue:240/255.f alpha:1];
            upLabel.textAlignment = NSTextAlignmentLeft;
            upLabel.font = [UIFont systemFontOfSize:14];
            upLabel.tag = 10;
            [cell.contentView addSubview:upLabel];
            
            UILabel * downLabel = [[[UILabel alloc] init] autorelease];
            downLabel.textColor = [UIColor colorWithRed:45/255.f green:137/255.f blue:240/255.f alpha:1];
            downLabel.textAlignment = NSTextAlignmentLeft;
            downLabel.font = [UIFont systemFontOfSize:12];
            downLabel.tag = 11;
            [cell.contentView addSubview:downLabel];
            
            UILabel * reasonLabel = [[[UILabel alloc] init] autorelease];
            reasonLabel.textColor = [UIColor grayColor];
            reasonLabel.textAlignment = NSTextAlignmentLeft;
            reasonLabel.font = [UIFont systemFontOfSize:13];
            reasonLabel.tag = 100;
            [cell.contentView addSubview:reasonLabel];
            reasonLabel.numberOfLines = 0;
            [reasonLabel setHidden:YES];
        }
        UIView * lineView = (UIView *)[cell viewWithTag:9];
        UILabel * upLabel = (UILabel *)[cell viewWithTag:10];
        UILabel * downLabel = (UILabel *)[cell viewWithTag:11];
        UILabel * reasonLabel = (UILabel *)[cell viewWithTag:100];
        
        NSMutableDictionary * temDict = [dataArray objectAtIndex:indexPath.row];
        switch ([keytype integerValue])
        {
            case 1:
            {
                [reasonLabel setHidden:YES];
                lineView.frame = CGRectMake(20, 38, 0.5, 72-38);
                upLabel.text = @"您的申请正在审核，预计两个工作日";
                upLabel.frame = CGRectMake(50, 20, WIDTH-60, 20);
                downLabel.text = [temDict objectForKey:@"regdate"];
                downLabel.frame = CGRectMake(50, 40, WIDTH-60, 18.5);
            }
                break;
            case 2:
            {
                [reasonLabel setHidden:YES];
                lineView.frame = CGRectMake(20, 38, 0.5, 72-38);
                upLabel.text = @"申请成功";
                upLabel.frame = CGRectMake(50, 20, WIDTH-60, 20);
                downLabel.text = [temDict objectForKey:@"regdate"];
                downLabel.frame = CGRectMake(50, 40, WIDTH-60, 18.5);
            }
                break;
            case 3:
            {
                [reasonLabel setHidden:NO];
                reasonLabel.text = [NSString stringWithFormat:@"原因：%@", [temDict objectForKey:@"content"]];
                CGSize reasonSize = [XtomFunction getSizeWithStrNo:reasonLabel.text width:WIDTH-50-30 font:13];
                reasonLabel.frame = CGRectMake(50, 65, reasonSize.width, reasonSize.height);
                lineView.frame = CGRectMake(20, 38, 0.5, 65+reasonSize.height+15-38);
                upLabel.text = @"申请失败";
                upLabel.frame = CGRectMake(50, 20, WIDTH-60, 20.5);
                downLabel.text = [temDict objectForKey:@"regdate"];
                downLabel.frame = CGRectMake(50, 40.5, WIDTH-60, 18.5);
            }
                break;
            default:
                break;
        }
        return cell;
    }
    if (1 == indexPath.row)
    {
        static NSString *CellIdentifier = @"OrderDetailCell01";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = BB_White_Color;
            
            
            UIView * lineView = [[[UIView alloc] init] autorelease];
            lineView.frame = CGRectMake(20, 0, 0.5, 67.5);
            lineView.backgroundColor = BB_Gray;
            [cell.contentView addSubview:lineView];
            
            UIImageView * downImgView = [[[UIImageView alloc]init]autorelease];
            [downImgView setImage:[UIImage imageNamed:@"我的店铺_灰圈.png"]];
            [downImgView setFrame:CGRectMake(16, 17, 16/2, 16/2)];
            [cell.contentView addSubview:downImgView];
            
            UILabel * upLabel = [[[UILabel alloc] init] autorelease];
            upLabel.frame = CGRectMake(50, 13, WIDTH-60, 20);
            upLabel.textColor = [UIColor grayColor];
            upLabel.textAlignment = NSTextAlignmentLeft;
            upLabel.font = [UIFont systemFontOfSize:14];
            upLabel.text = @"您的申请已提交";
            [cell.contentView addSubview:upLabel];
            
            UILabel * downLabel = [[[UILabel alloc] init] autorelease];
            downLabel.frame = CGRectMake(50, 33, WIDTH-60, 18.5);
            downLabel.textColor = [UIColor grayColor];
            downLabel.textAlignment = NSTextAlignmentLeft;
            downLabel.font = [UIFont systemFontOfSize:12];
            downLabel.tag = 11;
            [cell.contentView addSubview:downLabel];
        }
        NSMutableDictionary * temDict = [dataArray objectAtIndex:indexPath.row];
        UILabel * upLabel = (UILabel *)[cell viewWithTag:10];
        upLabel.text = [temDict objectForKey:@"name"];
        UILabel * downLabel = (UILabel *)[cell viewWithTag:11];
        downLabel.text = [temDict objectForKey:@"regdate"];
        return cell;
    }
    static NSString *CellIdentifier = @"OrderDetailCell02";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = BB_White_Color;
        
        
        UIView * lineView = [[[UIView alloc] init] autorelease];
        lineView.frame = CGRectMake(20, 0, 0.5, UI_View_Hieght-67-72);
        lineView.backgroundColor = BB_Gray;
        [cell.contentView addSubview:lineView];
    }
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
        if (![keytype isEqualToString:@"3"])
        {
            return 72;
        }
        NSString * str = [NSString stringWithFormat:@"原因：%@", [[dataArray objectAtIndex:0] objectForKey:@"content"]];
        CGSize reasonSize = [XtomFunction getSizeWithStrNo:str width:WIDTH-50-30 font:13];
        return 65+reasonSize.height+15;
    }
    if (1 == indexPath.row)
    {
        return 67.5;
    }
    return UI_View_Hieght-67-72;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)requestRefundProgress
{
    NSString *token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token forKey:@"token"];
    [dic setObject:@"2" forKey:@"keytype"];
    [dic setObject:keyid forKey:@"keyid"];
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
