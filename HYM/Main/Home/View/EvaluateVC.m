////
////  EvaluateVC.m
////  PingChuan
////
////  Created by pengli on 15/9/21.
////  Copyright (c) 2015年 平川嘉恒. All rights reserved.
////
//
//#import "EvaluateVC.h"
//#import "GoodsReplyCell.h"
////#import "TapGR.h"
//#import "MJPhoto.h"
//#import "MJPhotoBrowser.h"
////#import "InforVC.h"
//#import "FriendHomeVC.h"
//
//@interface EvaluateVC ()<UIGestureRecognizerDelegate>
//{
//    MBProgressHUD * waitMB;
//    BOOL isEnd;
//    NSInteger currentPage;
//}
//@property (nonatomic, retain) NSMutableArray * dataArray;
//
//@end
//
//@implementation EvaluateVC
//@synthesize dataArray;
//
//@synthesize keyid;
//@synthesize starNum;
//
//- (void)dealloc
//{
//    [dataArray release]; dataArray = nil;
//    [keyid release]; keyid = nil;
//    [starNum release]; starNum = nil;
//    [super dealloc];
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    [self loadSet];
//    [self loadData];
//}
//
//- (void)loadSet
//{
//    [self.navigationItem setNewTitle:@"评价"];
//    [self.navigationController.navigationBar setBarTintColor:NavigationColor];
//    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftBtnPressed) image:@"common_return.png" imageH:@"common_return.png"];
//    self.view.backgroundColor = BB_Back_Color_Here;
//    
//    [self reSetTableViewFrame:CGRectMake(0, 0, WIDTH, UI_View_Hieght)];
//}
//
//- (void)loadData
//{
//    [self requestReplyList];
//}
//
//- (void)leftBtnPressed
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//- (void)handlemySingleTap:(TapGR *)tap
//{
//
//    NSMutableArray * imgArr = [[dataArray objectAtIndex:tap.touchRow-1] objectForKey:@"imgItems"];
//    
//    NSInteger count = imgArr.count;
//    GoodsReplyCell *temCell = (GoodsReplyCell *)[mytable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:tap.touchRow inSection:0]];
//   
//    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
//    for (int i = 0; i < count; i++)
//    {
//        
//        NSString *url = [imgArr[i] objectForKey:@"imgurlbig"];
//        MJPhoto *photo = [[[MJPhoto alloc] init]autorelease];
//        photo.url = [NSURL URLWithString:url];
//        photo.srcImageView = (UIImageView *)[temCell viewWithTag:i+1000];
//        [photos addObject:photo];
//    }
//    
//   
//    MJPhotoBrowser *browser = [[[MJPhotoBrowser alloc] init]autorelease];
//    browser.currentPhotoIndex = tap.touchI;
//    browser.photos = photos;
//    [browser show];
//}
//
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 1 + dataArray.count;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (0 == indexPath.row)
//    {
//        static NSString * cellID = @"VirtualCell08";
//        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//        if(cell == nil)
//        {
//            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.backgroundColor = BB_White_Color;
//        }
//        else
//        {
//            for(UIView *view in cell.contentView.subviews)
//            {
//                [view removeFromSuperview];
//            }
//        }
//        
//        UILabel * evaluateLabel = [[[UILabel alloc] init] autorelease];
//        evaluateLabel.backgroundColor = [UIColor clearColor];
//        evaluateLabel.textAlignment = NSTextAlignmentLeft;
//        evaluateLabel.font = [UIFont systemFontOfSize:14];
//        evaluateLabel.textColor = BB_Graydark;
//        [evaluateLabel setFrame:CGRectMake(15, 6, 100, 30)];
//        evaluateLabel.text = @"评价";
//        [cell.contentView addSubview:evaluateLabel];
//        
//        for (int i = 0; i < 5; i++)
//        {
//            UIImageView * star = [[[UIImageView alloc] init] autorelease];
//            star.image = [UIImage imageNamed:@"store_reply_star_nor.png"];
//            star.frame = CGRectMake(10 + i * 15, 36, 14, 12.5);
//            [cell.contentView addSubview:star];
//            if (i < [starNum integerValue])
//            {
//                star.image = [UIImage imageNamed:@"store_reply_star_sel.png"];
//            }
//            else
//            {
//                star.image = [UIImage imageNamed:@"store_reply_star_nor.png"];
//            }
//        }
//        
//        UILabel * starNumLabel = [[[UILabel alloc] init] autorelease];
//        starNumLabel.backgroundColor = [UIColor clearColor];
//        starNumLabel.textAlignment = NSTextAlignmentLeft;
//        starNumLabel.font = [UIFont systemFontOfSize:14];
//        starNumLabel.textColor = BB_Graydark;
//        [starNumLabel setFrame:CGRectMake(90, 36, 100, 12.5)];
//        starNumLabel.text = [NSString stringWithFormat:@"%@.0", starNum];;
//        [cell.contentView addSubview:starNumLabel];
//        
//        return cell;
//    }
//    static NSString * cellID = @"VirtualCell09";
//    GoodsReplyCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if(cell == nil)
//    {
//        cell = [[[GoodsReplyCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.backgroundColor = BB_White_Color;
//    }
//    NSMutableDictionary *temDic = [dataArray objectAtIndex:indexPath.row-1];
//    
//    NSString *downavatar = [temDic objectForKey:@"avatar"];
//    cell.userHeaderImage.image = [UIImage imageNamed:@"商城_默认广告页1.png"];
//    if(![XtomFunction xfunc_check_strEmpty:downavatar])
//    {
//        NSString *document = [NSString stringWithFormat:@"%@/%@",BB_CASH_DOCUMENT,BB_CASH_AVATAR];
//        [[XtomCashManager sharedManager] addImgToImgViewFromDocumentORURL:cell.userHeaderImage document:document url:downavatar];
//    }
//   
//
//    [cell.userNameLabel setText:[temDic objectForKey:@"nickname"]];
//    
//    cell.publishTimeLabel.text = [XtomFunction getTimeFromDate:[temDic objectForKey:@"regdate"]];
//   
//    NSString * blogName = [temDic objectForKey:@"content"];
//    
//    CGSize myblogSize = [XtomFunction getSizeWithStrNo:blogName width:WIDTH-63 font:16];
//    [cell.commentDetailLabel setFrame:CGRectMake(53, 53, WIDTH-63, myblogSize.height)];
//    cell.commentDetailLabel.text = blogName;
//    
//    for (int i = 0; i< cell.starArray.count; i++)
//    {
//        UIImageView * image = [cell.starArray objectAtIndex:i];
//        image.frame = CGRectMake(WIDTH-67.5 + i * 12, 16.5, 11, 10);
//        if (i < [[temDic objectForKey:@"stars"] intValue])
//        {
//            image.image = [UIImage imageNamed:@"store_replylist_star_sel.png"];
//        }
//        else
//        {
//            image.image = [UIImage imageNamed:@"store_replylist_star_nor.png"];
//        }
//    }
//    
//    
//    NSMutableArray * imgArr = [temDic objectForKey:@"imgItems"];
//    for (int i = 0; i < cell.imageArr.count; i++)
//    {
//        if (i < imgArr.count)
//        {
//            UIImageView * image = [cell.imageArr objectAtIndex:i];
//            image.hidden = NO;
//            image.frame = CGRectMake(53+(WIDTH-60)/4*i, cell.commentDetailLabel.frame.origin.y + cell.commentDetailLabel.frame.size.height + 10, 62, 62);
//            image.userInteractionEnabled = YES;
//            image.tag = 1000+i;
//            
//            TapGR *temTap = [[[TapGR alloc] initWithTarget:self action:@selector(handlemySingleTap:)]autorelease];
//            [image addGestureRecognizer:temTap];
//            temTap.numberOfTapsRequired = 1;
//            temTap.numberOfTouchesRequired = 1;
//            temTap.touchRow = indexPath.row;
//            temTap.touchI = i;
//            temTap.delegate = self;
//            
//            NSString *downavatar = [imgArr[i] objectForKey:@"imgurl"];
//            if(![XtomFunction xfunc_check_strEmpty:downavatar])
//            {
//                NSString *document = [NSString stringWithFormat:@"%@/%@",BB_CASH_DOCUMENT,BB_CASH_AVATAR];
//                [[XtomCashManager sharedManager] addImgToImgViewFromDocumentORURL:image document:document url:downavatar];
//            }
//        }
//        else
//        {
//            UIImageView * image = [cell.imageArr objectAtIndex:i];
//            image.hidden = YES;
//        }
//    }
//    return cell;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView * headView = [[[UIView alloc] init] autorelease];
//    return headView;
//}
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 0.01;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0.01;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (0 == indexPath.row)
//    {
//        return 60;
//    }
//    NSMutableDictionary * temDict = [dataArray objectAtIndex:indexPath.row-1];
//    CGSize myblogSize = [XtomFunction getSizeWithStrNo:[temDict objectForKey:@"content"] width:WIDTH-63 font:16];
//    NSMutableArray * imgArr = [temDict objectForKey:@"imgItems"];
//    if (imgArr.count == 0)
//    {
//        return 53+myblogSize.height+10;
//    }
//    return 53+myblogSize.height+10 + 62 + 10;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
//
//
//- (void)requestReplyList
//{
//    NSString *token = [[XtomManager sharedManager] userToken];
//    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
//    [dic setObject:token forKey:@"token"];
//    [dic setObject:@"2" forKey:@"keytype"];
//    [dic setObject:keyid forKey:@"keyid"];
//    [dic setObject:[NSString stringWithFormat:@"%d",(int)currentPage] forKey:@"page"];
//    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_REPLY_LIST] target:self selector:@selector(responseReplyList:) parameter:dic];
//}
//
//- (void)responseReplyList:(NSDictionary *)info
//{
//    if(1 == [[info objectForKey:@"success"] intValue])
//    {
//        if (!dataArray)
//        {
//            self.dataArray = [[[NSMutableArray alloc]init]autorelease];
//        }
//        if(0 == currentPage)
//        {
//            [dataArray removeAllObjects];
//        }
//        
//        NSString * val = [[info objectForKey:@"infor"] objectForKey:@"listItems"];
//        if ([XtomFunction xfunc_check_strEmpty:val]) {
//            [self forbidAddMore];
//            isEnd = YES;
//            if(isMore)
//            {
//                [self getNoMoreData];
//            }
//        }
//        else
//        {
//            NSArray *temArr = [[info objectForKey:@"infor"] objectForKey:@"listItems"];
//            if ([temArr count] == 0)
//            {
//                [self forbidAddMore];
//                isEnd = YES;
//                if(isMore)
//                {
//                    [self getNoMoreData];
//                }
//            }
//            else
//            {
//                
//                if (temArr.count < 20)
//                {
//                    
//                    [self forbidAddMore];
//                }else
//                {
//                    [self canAddMore];
//                }
//                for (int i = 0; i<temArr.count; i++)
//                {
//                    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] init] autorelease];
//                    NSDictionary *temDict = [temArr objectAtIndex:i];
//                    for(NSString *key in temDict.allKeys)
//                    {
//                        NSString *value = [temDict objectForKey:key];
//                        if(![XtomFunction xfunc_check_strEmpty:value])
//                        {
//                            [dict setObject:value forKey:key];
//                        }
//                    }
//                    [self.dataArray addObject:dict];
//                }
//            }
//        }
//        [self reShowView];
//    }
//    else
//    {
//        if([info objectForKey:@"msg"])
//        {
//            [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:self.view];
//        }
//    }
//    
//    if(isMore)
//    {
//        [self stopAddMore];
//    }
//    if(isLoading)
//    {
//        [self stopLoading];
//    }
//}
//
//
//-(void)reShowView
//{
//    if(0 == dataArray.count)
//    {
//        [self showNoDataView:@"暂无数据"];
//    }
//    else
//    {
//        [self hideNoDataView];
//    }
//    [mytable reloadData];
//}
//
//
//- (void)refresh
//{
//    currentPage = 0;
//    isEnd = NO;
//    [self requestReplyList];
//}
//
//
//-(void)addMore
//{
//    if (!isEnd)
//    {
//        currentPage ++;
//    }
//    [self requestReplyList];
//}
//
//@end
