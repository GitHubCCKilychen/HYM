//
//  SearchHistoryVC.m
//  PingChuan
//
//  Created by pengli on 15/9/22.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "SearchHistoryVC.h"
#import "BBButton.h"
#import "CategoryVC.h"
//#import "EvaluateVC.h"
//#import "HotNewsCell.h"
//#import "OrderGoodCell.h"

@interface SearchHistoryVC ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
{
    BOOL isDelete;
    MBProgressHUD * waitMB;
    BOOL isEnd;
    NSInteger currentPage;
    
}
@property (nonatomic, retain) UIView * searchBackView;
@property (nonatomic, retain) UITextField * searchTextField;
@property (nonatomic, retain) UIButton * cancelBtn;
@property (nonatomic, retain) UITableView * myTableView;
@property (nonatomic, retain) NSMutableArray * dataSource;
@property (nonatomic, retain) NSMutableArray * dataArray;

@end

@implementation SearchHistoryVC

@synthesize searchBackView;
@synthesize searchTextField;
@synthesize cancelBtn;
@synthesize myTableView;
@synthesize dataSource;
@synthesize dataArray;

@synthesize keyType;
@synthesize isPresent;

- (void)dealloc
{
    [searchBackView release]; searchBackView = nil;
    [searchTextField release]; searchTextField = nil;
    [cancelBtn release]; cancelBtn = nil;
    [myTableView release]; myTableView = nil;
    [dataSource release]; dataSource = nil;
    [dataArray release]; dataArray = nil;
    
    [keyType release]; keyType = nil;
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [searchBackView setHidden:NO];
    [cancelBtn setHidden:NO];
    if ([keyType integerValue] == 2)
    {
        [searchTextField becomeFirstResponder];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [searchBackView setHidden:YES];
    [cancelBtn setHidden:YES];
    [searchTextField resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadSet];
    [self loadData];
}

- (void)loadSet
{
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//    [self.navigationController.navigationBar setBarTintColor:NavigationColor];
//    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftBtnPressed) title:@""];
//    [self.view setBackgroundColor:BB_Back_Color_Here];
    
    
    self.searchBackView = [[[UIView alloc] init] autorelease];
    searchBackView.frame = CGRectMake(10, 6.5, WIDTH-65, 29);
    searchBackView.backgroundColor = [UIColor whiteColor];
    [XtomFunction addbordertoView:searchBackView radius:0 width:0.5 color:BB_Gray];
    [self.navigationController.navigationBar addSubview:searchBackView];
    
    UIImageView * searchImg = [[[UIImageView alloc] init] autorelease];
    searchImg.frame = CGRectMake(9, 7, 15, 14.5);
    searchImg.image = [UIImage imageNamed:@"common_search.png"];
    [searchBackView addSubview:searchImg];
    
    
    self.searchTextField = [[[UITextField alloc] init] autorelease];
    searchTextField.backgroundColor = [UIColor clearColor];
    searchTextField.textAlignment = NSTextAlignmentLeft;
    searchTextField.textColor = [UIColor blackColor];
    searchTextField.font = [UIFont systemFontOfSize:15];
    searchTextField.frame = CGRectMake(30, 0, WIDTH-150, 29);
    
    searchTextField.delegate = self;
    searchTextField.returnKeyType = UIReturnKeySearch;
    searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchTextField.keyboardType = UIKeyboardTypeDefault;
    searchTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [searchBackView addSubview:searchTextField];
    
    if ([keyType integerValue] == 1)
    {
        searchTextField.placeholder = @"请输入商品名称";
    }
    else if ([keyType integerValue] == 2)
    {
        searchTextField.placeholder = @"请输入查询的关键字";
        [searchTextField becomeFirstResponder];
    }
    else if ([keyType integerValue] == 3)
    {
        searchTextField.placeholder = @"请输入好友昵称";
    }
    else if ([keyType integerValue] == 2)
    {
        searchTextField.placeholder = @"请输入查询的关键字";
    }
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(WIDTH-55, 0, 55, 44);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:BB_Button_Color forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:cancelBtn];
    
    self.myTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UI_View_Hieght) style:UITableViewStyleGrouped] autorelease];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    [myTableView setBackgroundView:nil];
    [myTableView setSeparatorInset:UIEdgeInsetsMake(0, 17, 0, 0)];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    [self.view addSubview:myTableView];
}

- (void)loadData
{
    if ([keyType integerValue] == 1)
    {
        [self requestHotSearch];
    }
    self.dataSource = [[[NSMutableArray alloc]init]autorelease];
    
    if ([XtomFunction xfunc_check_strEmpty:[[NSUserDefaults standardUserDefaults]objectForKey:SaveSearchWord]])
    {
        return;
    }
    NSMutableArray * temArr = [[NSUserDefaults standardUserDefaults]objectForKey:SaveSearchWord];
    
    for (int i = 0; i<temArr.count; i++)
    {
        NSString * temStr = [temArr objectAtIndex:i];
        [dataSource addObject:temStr];
    }
}

- (void)leftBtnPressed
{
    
}

- (void)buttonClick:(BBButton *)button
{
    CategoryVC * category = [[[CategoryVC alloc] init] autorelease];
    category.searchKey = [[dataArray objectAtIndex:button.btnRow] objectForKey:@"name"];
    category.keytype = @"2";
    category.keyid = @"无";
    category.sellerid = @"无";
    category.typeName = @"全部";
    [self.navigationController pushViewController:category animated:YES];
}

- (void)cancelClick:(UIButton *)button
{
    if (isPresent)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if ([keyType integerValue] == 1)
    {
        UITextField *mytxt=(UITextField*)textField;
        
        NSString *temSTr = mytxt.text;
        temSTr = [temSTr stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        
        if (![XtomFunction xfunc_check_strEmpty:temSTr])
        {
            
            for (int i = 0; i<dataSource.count; i++)
            {
                NSString *temStr = [dataSource objectAtIndex:i];
                if ([temStr isEqualToString:temSTr])
                {
                    [dataSource removeObjectAtIndex:i];
                    break;
                }
            }
            
            if (dataSource.count == 10)
            {
                [dataSource removeObjectAtIndex:0];
            }
            
            [dataSource addObject:temSTr];
            
            
            NSMutableArray *saveArr = [[[NSMutableArray alloc]init]autorelease];
            for (int i = 0; i<dataSource.count; i++)
            {
                NSString *temStr = [dataSource objectAtIndex:i];
                [saveArr addObject:temStr];
            }
            [[NSUserDefaults standardUserDefaults] setObject:saveArr forKey:SaveSearchWord];
            
            [myTableView reloadData];
            
            CategoryVC * category = [[[CategoryVC alloc] init] autorelease];
            category.keytype = @"2";
            category.searchKey = textField.text;
            category.keyid = @"无";
            category.sellerid = @"无";
            category.typeName = @"全部";
            [self.navigationController pushViewController:category animated:YES];
        }
        else
        {
            [XtomFunction openIntervalHUD:@"请输入你要查询的关键字!" view:self.view];
        }
    }
    
    return YES;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([keyType integerValue] == 1)
    {
        return 2;
    }
    else if ([keyType integerValue] == 2)
    {
        return 3;
    }
    else if ([keyType integerValue] == 3)
    {
        return 1;
    }
    else if ([keyType integerValue] == 4)
    {
        return 3;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([keyType integerValue] == 1)
    {
        if (1 == section)
        {
            if (dataSource.count == 0)
            {
                return 0;
            }
            return [dataSource count]+1+1;
        }
        return 1;
    }
    else if ([keyType integerValue] == 2)
    {
        return 1;
    }
    else if ([keyType integerValue] == 3)
    {
        return 3;
    }
    else if ([keyType integerValue] == 4)
    {
        return 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([keyType integerValue] == 1)
    {
        if (0 == indexPath.section)
        {
            static NSString * cellID = @"SearchCell00";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = BB_White_Color;
            }
            else
            {
                for(UIView *view in cell.contentView.subviews)
                {
                    [view removeFromSuperview];
                }
            }
            
            UILabel * cityLabel = [[[UILabel alloc] init] autorelease];
            cityLabel.backgroundColor = [UIColor clearColor];
            cityLabel.textAlignment = NSTextAlignmentLeft;
            cityLabel.font = [UIFont systemFontOfSize:14];
            cityLabel.textColor = BB_Graydark;
            [cityLabel setFrame:CGRectMake(15, 0, 100, 46)];
            cityLabel.text = @"热门搜索";
            [cell.contentView addSubview:cityLabel];
            
            
            for (int i = 0; i < dataArray.count; i++)
            {
                BBButton *myBtn = [BBButton buttonWithType:UIButtonTypeCustom];
                [myBtn setFrame:CGRectMake((WIDTH-16)/4*(i%4)+8, 40*(i/4)+42, (WIDTH-16)/4, 40)];
                myBtn.backgroundColor = [UIColor whiteColor];
                myBtn.btnRow = i;
                [myBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:myBtn];
                
                UILabel * myLabel = [[[UILabel alloc] init] autorelease];
                myLabel.backgroundColor = [UIColor clearColor];
                myLabel.textAlignment = NSTextAlignmentCenter;
                myLabel.font = [UIFont systemFontOfSize:14];
                myLabel.textColor = BB_Graydark;
                [myLabel setFrame:CGRectMake(4, 4.5, (WIDTH-16)/4-8, 31)];
                myLabel.text = [[dataArray objectAtIndex:i] objectForKey:@"name"];
                [myBtn addSubview:myLabel];
                [XtomFunction addbordertoView:myLabel radius:31/2 width:0.5 color:[UIColor blackColor]];
            }
            return cell;
        }
        if (0 == indexPath.row)
        {
            static NSString * cellID = @"SearchCell01";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = BB_White_Color;
            }
            cell.textLabel.text = @"最近搜索";
            return cell;
        }
        if (dataSource.count+1 == indexPath.row)
        {
            static NSString * cellID = @"SearchCell03";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = BB_White_Color;
                
                UILabel * historyLabel = [[[UILabel alloc] init] autorelease];
                historyLabel.backgroundColor = [UIColor clearColor];
                historyLabel.textAlignment = NSTextAlignmentCenter
                ;
                historyLabel.font = [UIFont systemFontOfSize:18];
                historyLabel.textColor = BB_Button_Color;
                [historyLabel setFrame:CGRectMake(0, 0, WIDTH, 46)];
                historyLabel.text = @"清空搜索历史";
                [cell.contentView addSubview:historyLabel];
            }
            return cell;
        }
        static NSString * cellID = @"SearchCell02";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = BB_White_Color;
        }
        cell.textLabel.text = [dataSource objectAtIndex:indexPath.row-1];
        return cell;
    }
    else if ([keyType integerValue] == 2)
    {
//        static NSString * cellID = @"SearchCell03";
//        HotNewsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//        if(cell == nil)
//        {
//            cell = [[[HotNewsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.backgroundColor = BB_White_Color;
//        }
//        [cell.numView setHidden:NO];
// 
//        
//        return cell;
    }
    else if ([keyType integerValue] == 3)
    {
        static NSString * cellID = @"SearchCell04";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = BB_White_Color;
            
            
            UIImageView * headImage = [[[UIImageView alloc] init] autorelease];
            headImage.frame = CGRectMake(13, 13, 87/2, 87/2);
            [XtomFunction addbordertoView:headImage radius:87/4 width:0 color:[UIColor clearColor]];
            headImage.tag = 10000;
            [cell.contentView addSubview:headImage];
            
            
            UILabel * nickname = [[[UILabel alloc]init]autorelease];
            nickname.frame = CGRectMake(65, 0, 200, 66);
            nickname.backgroundColor = [UIColor clearColor];
            nickname.textAlignment = NSTextAlignmentLeft;
            nickname.font = [UIFont systemFontOfSize:18];
            nickname.tag = 20000;
            [nickname setTextColor:BB_Blake];
            [cell.contentView addSubview:nickname];
        }
        UIImageView * headImage = (UIImageView *)[cell viewWithTag:10000];
        headImage.image = [UIImage imageNamed:@"商城_默认广告页1.png"];
        
        UILabel * nickname = (UILabel *)[cell viewWithTag:20000];
        nickname.text = @"车美丽";
        
        NSMutableAttributedString * attrString =
        [[NSMutableAttributedString alloc] initWithString:nickname.text];
        UIColor * newColor = BB_Button_Color;
        [attrString addAttribute:NSForegroundColorAttributeName value:newColor range:[nickname.text rangeOfString:@"车"]];
        nickname.attributedText = attrString;
        
        return cell;
    }
    if ([keyType integerValue] == 4)
    {
        if (0 == indexPath.row)
        {
            static NSString * cellID = @"OrderManagerCell00";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = BB_White_Color;
                
                UILabel * orderNum = [[[UILabel alloc] init] autorelease];
                orderNum.backgroundColor = [UIColor clearColor];
                orderNum.textAlignment = NSTextAlignmentLeft;
                orderNum.font = [UIFont systemFontOfSize:15];
                orderNum.textColor = BB_Graydark;
                [orderNum setFrame:CGRectMake(15, 0, 150, 34)];
                
                [cell.contentView addSubview:orderNum];
                orderNum.tag = 1;
                
                UILabel * orderTime = [[[UILabel alloc] init] autorelease];
                orderTime.backgroundColor = [UIColor clearColor];
                orderTime.textAlignment = NSTextAlignmentRight;
                orderTime.font = [UIFont systemFontOfSize:15];
                orderTime.textColor = BB_Graydark;
                [orderTime setFrame:CGRectMake(WIDTH-165, 0, 150, 34)];
                
                [cell.contentView addSubview:orderTime];
                orderTime.tag = 2;
            }
            UILabel * orderNum = (UILabel *)[cell viewWithTag:1];
            orderNum.text = @"订单号：8562332333";
            
            UILabel * orderTime = (UILabel *)[cell viewWithTag:2];
            orderTime.text = @"2015-5-13 10：30";
            
            return cell;
        }
        static NSString * cellID = @"OrderManagerCell01";
//        OrderGoodCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//        if(cell == nil)
//        {
//            cell = [[[OrderGoodCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.backgroundColor = BB_White_Color;
//        }
//        cell.topImgView.image = [UIImage imageNamed:@"商城_默认广告页3.png"];
//        cell.nameLable.text = @"100元哈根达斯交通银行兑换券";
//        cell.goodsPrice.text = @"85元";
//        cell.priceLable.text = @"X1";
//        return cell;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headView = [[[UIView alloc] init] autorelease];
    return headView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([keyType integerValue] == 4)
    {
        return 8;
    }
    if ([keyType integerValue] == 3)
    {
        return 10;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([keyType integerValue] == 1)
    {
        if (0 == indexPath.section)
        {
            NSInteger num = 0;
            if ([dataArray count]%4 == 0)
            {
                num = [dataArray count]/4;
            }
            else
            {
                num = [dataArray count]/4+1;
            }
            return 42+40*num+10;
        }
        return 46;
    }
    else if ([keyType integerValue] == 2)
    {
        return 160;
    }
    else if ([keyType integerValue] == 3)
    {
        return 66;
    }
    else if ([keyType integerValue] == 4)
    {
        if (0 == indexPath.row)
        {
            return 34;
        }
        return 95;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([keyType integerValue] == 1)
    {
        if (1 == indexPath.section)
        {
            
            if (indexPath.row-1 == [dataSource count])
            {
                [dataSource removeAllObjects];
                NSMutableArray *saveArr = [[[NSMutableArray alloc]init]autorelease];
                [[NSUserDefaults standardUserDefaults] setObject:saveArr forKey:SaveSearchWord];
                [myTableView reloadData];
                return;
            }
            if (indexPath.row != 0)
            {
                CategoryVC * category = [[[CategoryVC alloc] init] autorelease];
                category.keytype = @"2";
                category.searchKey = [dataSource objectAtIndex:indexPath.row-1];
                category.keyid = @"无";
                category.sellerid = @"无";
                category.typeName = @"全部";
                [self.navigationController pushViewController:category animated:YES];
            }
        }

    }
    else if ([keyType integerValue] == 2)
    {
        NSLog(@"跳转到商品详情");
    }
}


- (void)requestHotSearch
{
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_HOT_LIST] target:self selector:@selector(responseHotSearch:) parameter:dic];
}

- (void)responseHotSearch:(NSDictionary *)info
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
            NSArray *temArr = [[info objectForKey:@"infor"] objectForKey:@"listItems"];
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
        }
        [myTableView reloadData];
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
