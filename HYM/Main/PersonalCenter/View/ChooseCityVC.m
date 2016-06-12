//
//  ChooseCityVC.m
//  PingChuan
//
//  Created by LarryRodic on 14-10-23.
//  Copyright (c) 2014年 平川嘉恒. All rights reserved.
//

#import "ChooseCityVC.h"

@interface ChooseCityVC ()
{
    MBProgressHUD * waitMB;
}

@property (nonatomic, retain) UITableView * myTableView;
@property (nonatomic, retain) NSMutableArray * headerList;
@property (nonatomic, retain) NSMutableArray * suoyinCityList;
@property (nonatomic, retain) NSMutableDictionary * dataSource;
@property (nonatomic, retain) NSMutableArray * dataArrAll;

@property (nonatomic, retain) UISearchBar * searchBar;
@property (nonatomic, retain) UISearchDisplayController * searchdispalyCtrl;
@property (nonatomic, retain) NSMutableArray * dataSearch;
@end

@implementation ChooseCityVC
@synthesize myTableView;
@synthesize headerList;
@synthesize suoyinCityList;
@synthesize dataSource;
@synthesize dataArrAll;

@synthesize searchBar;
@synthesize searchdispalyCtrl;
@synthesize dataSearch;

@synthesize currentCity;
@synthesize delegate;

- (void)dealloc
{
    [currentCity release]; currentCity=nil;
    [myTableView release]; myTableView = nil;
    [headerList release]; headerList=nil;
    [dataSource release]; dataSource = nil;
    [dataArrAll release]; dataArrAll = nil;
    
    [searchBar release]; searchBar=nil;
    [searchdispalyCtrl release]; searchdispalyCtrl=nil;
    [dataSearch release]; dataSearch = nil;
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
    
    if ([XtomFunction xfunc_check_strEmpty:currentCity])
    {
        [self.navigationItem setNewTitle:@"选择城市"];
    }
    else
    {
        [self.navigationItem setNewTitle:@"切换城市"];
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:NavigationColor];
    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftBtnPressed:) image:@"common_return.png" imageH:@"common_return.png"];
    self.view.backgroundColor = BB_Back_Color_Here;
    
    self.myTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, UI_View_Hieght) style:UITableViewStylePlain]autorelease];
    [myTableView setBackgroundColor:BB_Back_Color_Here];
    [myTableView setBackgroundView:nil];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.allowsSelection=YES;
    
    myTableView.showsHorizontalScrollIndicator = NO;
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.sectionIndexColor = BB_Button_Color;
    
    [self.view addSubview:myTableView];
    
    self.searchBar = [[[UISearchBar alloc] initWithFrame:CGRectMake(10, 15, self.view.bounds.size.width, 45)]autorelease];
    searchBar.placeholder=@"搜索";
    searchBar.delegate = self;
    searchBar.backgroundColor=[UIColor clearColor];
    
    [XtomFunction addbordertoView:searchBar radius:0 width:0.5 color:BB_lineColor];
    searchBar.keyboardType=UIKeyboardTypeDefault;
    myTableView.tableHeaderView = searchBar;
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    self.searchdispalyCtrl = [[[UISearchDisplayController  alloc] initWithSearchBar:searchBar contentsController:self]autorelease];
    
    searchdispalyCtrl.searchBar.tintColor=BB_Back_Color_Here;
    searchdispalyCtrl.delegate = self;
    searchdispalyCtrl.searchResultsDelegate=self;
    searchdispalyCtrl.searchResultsDataSource = self;
}

-(void)loadData
{
    self.headerList=[[[NSMutableArray alloc]initWithObjects:@"定位城市",@"最近访问城市",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"P",@"Q",@"R",@"S",@"T",@"W",@"X",@"Y",@"Z", nil]autorelease];
    
	self.suoyinCityList = [[[NSMutableArray alloc]init]autorelease];
    
	for(char c ='A';c<='Z';c++)
    {
        
        NSString *zimu=[NSString stringWithFormat:@"%c",c];
        if (![zimu isEqualToString:@"I"]&&![zimu isEqualToString:@"O"]&&![zimu isEqualToString:@"U"]&&![zimu isEqualToString:@"V"])
        {
            [suoyinCityList addObject:[NSString stringWithFormat:@"%c",c]];
        }
	}
    [self requestGetCityList];
}


- (void)leftBtnPressed:(id)sender
{
    
    if ([XtomFunction xfunc_check_strEmpty:[[NSUserDefaults standardUserDefaults]objectForKey:CityName]])
    {
        [XtomFunction openIntervalHUD:@"请选择你所在的城市！" view:self.view];
    }
    else
    {
        [delegate backWithChooseCity];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)btnCityPressed:(BBButton*)sender
{
    
    if (sender.btnRow == -1)
    {
        [[NSUserDefaults standardUserDefaults] setObject:[[NSUserDefaults standardUserDefaults] objectForKey:LocalCityName] forKey:CityName];
        [[NSUserDefaults standardUserDefaults] setObject:[[NSUserDefaults standardUserDefaults] objectForKey:LocalCityId] forKey:CityId];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:DownName];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:DownId];
    }else
    {
        NSMutableArray *saveArr = [[NSUserDefaults standardUserDefaults] objectForKey:SaveLastCityArr];
        NSMutableDictionary *temDic = [saveArr objectAtIndex:saveArr.count-sender.btnRow-1];
        
        [[NSUserDefaults standardUserDefaults] setObject:[temDic objectForKey:@"name"] forKey:CityName];
        [[NSUserDefaults standardUserDefaults] setObject:[temDic objectForKey:@"id"] forKey:CityId];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:DownName];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:DownId];
    }
    
    [delegate backWithChooseCity];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return 1;
    }
    else
    {
        return 24;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [dataSearch count];
    }
    else
    {
        if (section==0||section==1)
        {
            return 1;
        }
        return [[dataSource objectForKey:[suoyinCityList objectAtIndex:section-2]]count];
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        static NSString *simpleTableIdentifier = @"RecipeCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier]autorelease];
            
            
            UILabel *labLeft = [[[UILabel alloc]init]autorelease];
            labLeft.backgroundColor = [UIColor clearColor];
            labLeft.textAlignment = NSTextAlignmentLeft;
            labLeft.font = [UIFont systemFontOfSize:15];
            labLeft.textColor = [UIColor blackColor];
            labLeft.frame = CGRectMake(15, 15, 200, 15);
            labLeft.tag = 9;
            [cell.contentView addSubview:labLeft];
        }
        NSMutableDictionary *temDic = [dataSearch objectAtIndex:indexPath.row];
        
        UILabel *labLeft = (UILabel*)[cell viewWithTag:9];
        labLeft.text = [temDic objectForKey:@"name"];
        return cell;
    }
   
    if (indexPath.section == 0)
    {
        
        static NSString *CellIdentifier = @"MyChooseCityRowSecondCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
        }
        else
        {
            for(UIView *view in cell.contentView.subviews)
            {
                [view removeFromSuperview];
            }
        }
        
        BBButton *btnCity = [[[BBButton alloc]init]autorelease];
        [btnCity setFrame:CGRectMake(15, 21, 90, 36)];
        btnCity.backgroundColor=BB_White_Color;
        btnCity.btnRow = -1;
        [XtomFunction addbordertoView:btnCity radius:0.0 width:0.5 color:BB_Gray_Color];
        [btnCity addTarget:self action:@selector(btnCityPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel *lblTitle = [[[UILabel alloc]init]autorelease];
        lblTitle.backgroundColor = [UIColor clearColor];
        lblTitle.textAlignment = NSTextAlignmentCenter;
        lblTitle.font = [UIFont systemFontOfSize:15];
        lblTitle.textColor = BB_Blake;
        lblTitle.text = [XtomFunction xfuncGetAppdelegate].mycity?[HYMTool xfuncGetAppdelegate].mycity:@"济南市";
        lblTitle.frame = CGRectMake(0, 0, 90, 36);
        [btnCity addSubview:lblTitle];
        [cell.contentView addSubview:btnCity];
        
        return  cell;
    }
    
    if (indexPath.section == 1)
    {
        static NSString *CellIdentifier = @"MyChooseCityRowThirdCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
        }
        else
        {
            for(UIView *view in cell.contentView.subviews)
            {
                [view removeFromSuperview];
            }
        }
        
        NSMutableArray *saveArr = [[NSUserDefaults standardUserDefaults] objectForKey:SaveLastCityArr];
        if ([XtomFunction xfunc_check_strEmpty:[[NSUserDefaults standardUserDefaults] objectForKey:SaveLastCityArr]])
        {
            return cell;
        }
        for (int i = 0; i<saveArr.count; i++)
        {
            
            BBButton *btnCity = [[[BBButton alloc]init]autorelease];
            [btnCity setFrame:CGRectMake(10+i*(90+10), 21, 90, 36)];
            btnCity.backgroundColor=BB_White_Color;
            [XtomFunction addbordertoView:btnCity radius:0.0 width:0.5 color:BB_Gray_Color];
            [btnCity addTarget:self action:@selector(btnCityPressed:) forControlEvents:UIControlEventTouchUpInside];
            btnCity.btnRow = i;
            
            
            UILabel *lblTitle = [[[UILabel alloc]init]autorelease];
            lblTitle.backgroundColor = [UIColor clearColor];
            lblTitle.textAlignment = NSTextAlignmentCenter;
            lblTitle.font = [UIFont systemFontOfSize:15];
            lblTitle.textColor = BB_Blake;
            lblTitle.text = [[saveArr objectAtIndex:saveArr.count-i-1]objectForKey:@"name"];
            lblTitle.frame = CGRectMake(0, 0, 90, 36);
            [btnCity addSubview:lblTitle];
            [cell.contentView addSubview:btnCity];
        }
        return  cell;
    }
    
    static NSString *CellIdentifier = @"nicai";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = BB_White_Color;
        
        UILabel *labLeft = [[[UILabel alloc]init]autorelease];
        labLeft.backgroundColor = [UIColor clearColor];
        labLeft.textAlignment = NSTextAlignmentLeft;
        labLeft.font = [UIFont systemFontOfSize:15];
        labLeft.textColor = BB_Gray;
        labLeft.frame = CGRectMake(15, 15, 200, 15);
        labLeft.tag = 9;
        [cell.contentView addSubview:labLeft];
    }
    NSMutableDictionary *temDic = [[dataSource objectForKey:[suoyinCityList objectAtIndex:indexPath.section-2]]objectAtIndex:indexPath.row];
    
    UILabel *labLeft = (UILabel*)[cell viewWithTag:9];
    labLeft.text = [temDic objectForKey:@"name"];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return nil;
    }
    UIView *headView = [[[UIView alloc]init]autorelease];
    headView.backgroundColor = [UIColor clearColor];
    
    UIView *biaotiView = [[[UIView alloc]init]autorelease];
    biaotiView.backgroundColor = BB_Back_Color_Here;
    [XtomFunction addbordertoView:biaotiView radius:0 width:0.5 color:BB_lineColor];
    biaotiView.frame=CGRectMake(0, 0, 320, 34);
    [headView addSubview:biaotiView];
    
    
    UILabel *lblBiaoti = [[[UILabel alloc]init]autorelease];
    lblBiaoti.backgroundColor = [UIColor clearColor];
    lblBiaoti.textAlignment = NSTextAlignmentLeft;
    lblBiaoti.font = [UIFont systemFontOfSize:15];
    lblBiaoti.textColor = [UIColor blackColor];
    lblBiaoti.frame = CGRectMake(15, 7.5, 200, 15);
    lblBiaoti.text = [headerList objectAtIndex:section];
    [biaotiView addSubview:lblBiaoti];
    
    return headView;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return nil;
    }
    return suoyinCityList;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
	
	[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index+2] atScrollPosition:UITableViewScrollPositionTop animated:YES];
	return index+2;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[self.searchBar scopeButtonTitles][self.searchBar.selectedScopeButtonIndex]];
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:self.searchBar.text scope:self.searchBar.scopeButtonTitles[searchOption]];
    return YES;
}

-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    
    if (!dataSearch)
    {
        self.dataSearch = [[[NSMutableArray alloc]init]autorelease];
    }
    [self.dataSearch removeAllObjects];
    
    NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
    for (int i = 0; i < dataArrAll.count; i++)
    {
        
        NSString *storeString = [[dataArrAll objectAtIndex:i]objectForKey:@"name"];
        NSRange storeRange = NSMakeRange(0, storeString.length);
        NSRange foundRange = [storeString rangeOfString:searchText options:searchOptions range:storeRange];
        
        if (foundRange.length)
        {
            [dataSearch addObject:[dataArrAll objectAtIndex:i]];
        }
        
        
        NSString *zimuString = [[dataArrAll objectAtIndex:i]objectForKey:@"charindex"];
        NSRange zimuRange = NSMakeRange(0, zimuString.length);
        NSRange pinyinRange = [zimuString rangeOfString:searchText options:searchOptions range:zimuRange];
        if (pinyinRange.length)
        {
            [dataSearch addObject:[dataArrAll objectAtIndex:i]];
        }
    }
    NSLog(@"搜索后的数据：%@",dataSearch);
    [searchdispalyCtrl.searchResultsTableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return 45;
    }
    if (indexPath.section==0)
    {
        return 73;
    }
    if (indexPath.section==1)
    {
        if ([XtomFunction xfunc_check_strEmpty:[[NSUserDefaults standardUserDefaults] objectForKey:SaveLastCityArr]])
        {
            return 0;
        }
        return 73;
    }
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return 0;
    }
    if (section==1)
    {
        if ([XtomFunction xfunc_check_strEmpty:[[NSUserDefaults standardUserDefaults] objectForKey:SaveLastCityArr]])
        {
            return 0;
        }
        return 34;
    }
    return 34;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        NSMutableDictionary *temDic = [dataSearch objectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] setObject:[temDic objectForKey:@"name"] forKey:CityName];
        [[NSUserDefaults standardUserDefaults] setObject:[temDic objectForKey:@"id"] forKey:CityId];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:DownName];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:DownId];
        
        [self saveHistoryCity:temDic];
        
        [delegate backWithChooseCity];
        [self dismissViewControllerAnimated:YES completion:nil];
        
        return;
    }
    
    if (indexPath.section >= 2)
    {
        NSMutableDictionary *temDic = [[dataSource objectForKey:[suoyinCityList objectAtIndex:indexPath.section-2]]objectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] setObject:[temDic objectForKey:@"name"] forKey:CityName];
        [[NSUserDefaults standardUserDefaults] setObject:[temDic objectForKey:@"id"] forKey:CityId];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:DownName];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:DownId];
        
        [self saveHistoryCity:temDic];
        
        [delegate backWithChooseCity];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

-(void)saveHistoryCity:(NSMutableDictionary*)temDic
{
    
    NSMutableArray *saveArr1 = [[NSUserDefaults standardUserDefaults]objectForKey:SaveLastCityArr];
    
    if ([XtomFunction xfunc_check_strEmpty:[[NSUserDefaults standardUserDefaults]objectForKey:SaveLastCityArr]])
    {
        NSMutableArray *myTemArr = [[[NSMutableArray alloc]init]autorelease];
        NSMutableDictionary *temp = [[[NSMutableDictionary alloc] initWithObjectsAndKeys:[temDic objectForKey:@"id"],@"id",[temDic objectForKey:@"name"],@"name", nil] autorelease];
        [myTemArr addObject:temp];
        [[NSUserDefaults standardUserDefaults] setObject:myTemArr forKey:SaveLastCityArr];
    }else
    {
        
        NSMutableArray *saveArr = [[[NSMutableArray alloc]init]autorelease];
        for (int i = 0; i<saveArr1.count; i++)
        {
            NSMutableDictionary *dict = [[[NSMutableDictionary alloc] init] autorelease];
            NSDictionary *temDict = [saveArr1 objectAtIndex:i];
            for(NSString *key in temDict.allKeys)
            {
                NSString *value = [temDict objectForKey:key];
                if(![XtomFunction xfunc_check_strEmpty:value])
                {
                    [dict setObject:value forKey:key];
                }
            }
            [saveArr addObject:dict];
        }
        
        for (int i = 0; i<saveArr.count; i++)
        {
            NSMutableDictionary *myDic = [saveArr objectAtIndex:i];
            if ([[myDic objectForKey:@"id"]isEqualToString:[temDic objectForKey:@"id"]])
            {
                [saveArr removeObjectAtIndex:i];
                break;
            }
        }
        
        if (saveArr.count == 3)
        {
            [saveArr removeObjectAtIndex:0];
        }
        
        NSMutableDictionary *temp = [[[NSMutableDictionary alloc] initWithObjectsAndKeys:[temDic objectForKey:@"id"],@"id",[temDic objectForKey:@"name"],@"name", nil] autorelease];
        [saveArr addObject:temp];
        [[NSUserDefaults standardUserDefaults] setObject:saveArr forKey:SaveLastCityArr];
    }
}

- (void)requestGetCityList
{
    waitMB = [XtomFunction openHUD:@"正在获取..." view:self.view];
    NSMutableDictionary *paraDic = [[[NSMutableDictionary alloc] init]autorelease];
    [paraDic setObject:@"-1" forKey:@"parentid"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_DISTRICT_LIST];
    [XTomRequest requestWithURL:url target:self selector:@selector(responseGetCityList:) parameter:paraDic];
}

- (void)responseGetCityList:(NSDictionary*)info
{
    [XtomFunction closeHUD:waitMB];
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        NSString *myCity = [[info objectForKey:@"infor"]objectForKey:@"listItems"];
        NSArray *temCity = [[info objectForKey:@"infor"]objectForKey:@"listItems"];
        if (!dataSource)
        {
            self.dataSource = [[[NSMutableDictionary alloc]init]autorelease];
            self.dataArrAll = [[[NSMutableArray alloc]init]autorelease];
        }
       
        if (![XtomFunction xfunc_check_strEmpty:myCity])
        {
            for (int i = 0; i<temCity.count; i++)
            {
                NSMutableDictionary *dict = [[[NSMutableDictionary alloc] init] autorelease];
                NSDictionary *temDict = [temCity objectAtIndex:i];
                for(NSString *key in temDict.allKeys)
                {
                    NSString *value = [temDict objectForKey:key];
                    if(![XtomFunction xfunc_check_strEmpty:value])
                    {
                        [dict setObject:value forKey:key];
                    }
                }
               
                [self.dataArrAll addObject:dict];
                
                
                if ([[temDict objectForKey:@"name"]isEqualToString:[HYMTool  xfuncGetAppdelegate].mycity])
                {
                    if ([XtomFunction xfunc_check_strEmpty:[[NSUserDefaults standardUserDefaults]objectForKey:CityName]])
                    {
                        [[NSUserDefaults standardUserDefaults] setObject:[temDict objectForKey:@"name"] forKey:CityName];
                        [[NSUserDefaults standardUserDefaults] setObject:[temDict objectForKey:@"id"] forKey:CityId];
                    }
                    [[NSUserDefaults standardUserDefaults] setObject:[temDict objectForKey:@"name"] forKey:LocalCityName];
                    [[NSUserDefaults standardUserDefaults] setObject:[temDict objectForKey:@"id"] forKey:LocalCityId];
                }
                
                NSString *first = [temDict objectForKey:@"charindex"];
                
                if ([XtomFunction xfunc_check_strEmpty:[dataSource objectForKey:first]])
                {
                    NSMutableArray *contentArray=[[[NSMutableArray alloc]init]autorelease];
                    [contentArray addObject:temDict];
                    [dataSource setValue:contentArray forKey:first];
                }
                else
                {
                    NSMutableArray *contentArray=[[[NSMutableArray alloc]initWithArray:[dataSource objectForKey:first]]autorelease];
                    [contentArray addObject:temDict];
                    [dataSource setValue:contentArray forKey:first];
                }
            }
            NSLog(@"所有分类后的数据：%@",dataSource);
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
