//
//  StoreDetailVC.m
//  PingChuan
//
//  Created by pengli on 15/9/25.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "StoreDetailVC.h"
#import "ImagePlayerView.h"
#import "CategoryGoodsCell.h"
//#import "StoreEvaluateVC.h"
//#import "CategoryVC.h"
//#import "MJPhoto.h"
//#import "MJPhotoBrowser.h"
//#import "VirtualDetailVC.h"
#import "RealityDetailVC.h"
//#import "InforVC.h"
//#import "WeiChatVC.h"

//#import <AGCommon/UINavigationBar+Common.h>
//#import <AGCommon/UIImage+Common.h>
//#import <AGCommon/UIColor+Common.h>
//#import <AGCommon/UIDevice+Common.h>
//#import <ShareSDK/ShareSDK.h>

@interface StoreDetailVC ()<ImagePlayerViewDelegate>
{
    BOOL isLove;
    MBProgressHUD * waitMB;
    BOOL isEnd;
    NSInteger currentPage;
    NSInteger operType;
}
@property (nonatomic, retain) NSMutableDictionary * dataSource;
@property (nonatomic, retain) NSMutableArray * dataArray;
@property (nonatomic, retain) ImagePlayerView * player;
@property (nonatomic, retain) NSMutableArray * dataTopAd;
@end

@implementation StoreDetailVC
@synthesize dataSource;
@synthesize dataArray;
@synthesize player;
@synthesize dataTopAd;

@synthesize keyid;
@synthesize isPresent;
@synthesize delegate;

- (void)dealloc
{
    [dataSource release]; dataSource = nil;
    [dataArray release]; dataArray = nil;
    [player release]; player = nil;
    [dataTopAd release]; dataTopAd = nil;
    [keyid release]; keyid = nil;
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UISegmentedControl *segmentedControl = (UISegmentedControl *)[mytable viewWithTag:10000];
    segmentedControl.selectedSegmentIndex = 0;
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
    [self.navigationItem setNewTitle:@"商家详情"];
    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftBtnPressed) image:@"common_return.png" imageH:@"common_return.png"];
    [self.navigationItem setRightItemWithTarget:self action:@selector(rightBtnPressed) image:@"common_share.png" imageH:@"common_share.png"];
    [self.view setBackgroundColor:BB_Back_Color_Here];
    
    
    UIView *myView = [[[UIView alloc]init]autorelease];
    [myView setFrame:CGRectMake(0, 0, WIDTH, 215)];
    myView.backgroundColor = BB_Back_Color_Here;
    self.mytable.tableHeaderView = myView;
    
    self.player = [[[ImagePlayerView alloc]init]autorelease];
    [player setFrame:CGRectMake(0, 0, WIDTH, 215)];
    player.scrollInterval = 3;
    player.imagePlayerViewDelegate = self;
    player.pageControlPosition = ICPageControlPosition_BottomCenter;
    player.hidePageControl = NO;
    [myView addSubview:player];
}

- (void)loadData
{
    [self requestStoreDetail];
}


- (void)leftBtnPressed
{
    [delegate operateSuccess];
    if (isPresent)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//- (void)rightBtnPressed
//{
//    
//    id<ISSContent> publishContent = nil;
//    
//    SSPublishContentMediaType myType = SSPublishContentMediaTypeNews;
//    
//    
//    NSString *myname = [dataSource objectForKey:@"shop_name"]?[dataSource objectForKey:@"shop_name"]:@"薅羊毛";
//   
//    NSString *myCon = [dataSource objectForKey:@"shop_content"]?[dataSource objectForKey:@"shop_content"]:@"薅羊毛是一款不错的软件哦~~";
//    
//    NSString *myUrl = [NSString stringWithFormat:@"%@share/sdk.php?shop_id=%@&client_id=%@",[[XtomManager sharedManager] myinitInfor][@"sys_plugins"], self.keyid, [[XtomManager sharedManager] motherInfor][@"id"]];
//    
//    NSLog(@"%@", myUrl);
//    
//    NSString * myImage = self.dataTopAd[0][@"shop_avatarbig"]?self.dataTopAd[0][@"shop_avatarbig"]:[NSString stringWithFormat:@"%@images/logo.png",REQUEST_MAINLINK_INIT];
//    
//    
//    
//    publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@", myCon]
//                        defaultContent:nil
//                                 image:[ShareSDK imageWithUrl:myImage]
//                                 title:myname
//                                   url:myUrl
//                           description:myCon
//                             mediaType:myType];
//    
//    
//    [publishContent addWeixinSessionUnitWithType:INHERIT_VALUE
//                                         content:INHERIT_VALUE
//                                           title:INHERIT_VALUE
//                                             url:INHERIT_VALUE
//                                      thumbImage:INHERIT_VALUE
//                                           image:INHERIT_VALUE
//                                    musicFileUrl:nil
//                                         extInfo:nil
//                                        fileData:nil
//                                    emoticonData:nil];
//    
//    
//    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInteger:myType]
//                                          content:INHERIT_VALUE
//                                            title:[NSString stringWithFormat:@"我在使用薅羊毛-%@",myCon]
//                                              url:INHERIT_VALUE
//                                       thumbImage:INHERIT_VALUE
//                                            image:INHERIT_VALUE
//                                     musicFileUrl:nil
//                                          extInfo:nil
//                                         fileData:nil
//                                     emoticonData:nil];
//    
//   
//    [publishContent addQQSpaceUnitWithTitle:INHERIT_VALUE
//                                        url:INHERIT_VALUE
//                                       site:nil
//                                    fromUrl:nil
//                                    comment:INHERIT_VALUE
//                                    summary:INHERIT_VALUE
//                                      image:INHERIT_VALUE
//                                       type:INHERIT_VALUE
//                                    playUrl:nil
//                                       nswb:nil];
//    
//    
//    [publishContent addQQUnitWithType:INHERIT_VALUE
//                              content:INHERIT_VALUE
//                                title:INHERIT_VALUE
//                                  url:INHERIT_VALUE
//                                image:INHERIT_VALUE];
//    
//    
//    [publishContent addSinaWeiboUnitWithContent:[NSString stringWithFormat:@"薅羊毛-%@\n%@",myname, myUrl] image:[ShareSDK imageWithUrl:myImage]];
//    
//    
//    id<ISSContainer> container = [ShareSDK container];
//    
//    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
//                                                         allowCallback:YES
//                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
//                                                          viewDelegate:nil
//                                               authManagerViewDelegate:[XtomFunction xfuncGetAppdelegate].viewDelegate];
//    
//    id<ISSShareOptions> shareOptions = [ShareSDK simpleShareOptionsWithTitle:@"薅羊毛"
//                                                           shareViewDelegate:nil];
//    
//    id<ISSShareActionSheetItem> sinaItem = [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeSinaWeibo]
//                                                                              icon:[ShareSDK getClientIconWithType:ShareTypeSinaWeibo]
//                                                                      clickHandler:^{
//                                                                          [ShareSDK clientShareContent:publishContent type:ShareTypeSinaWeibo authOptions:nil shareOptions:shareOptions statusBarTips:NO result:
//                                                                           
//                                                                           ^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                                                               
//                                                                               if (state == SSPublishContentStateSuccess)
//                                                                               {
//                                                                                   NSLog(@"分享成功");
//                                                                                   [XtomFunction openIntervalHUDOK:@"分享成功" view:self.view];
//                                                                               }
//                                                                               else if (state == SSPublishContentStateFail)
//                                                                               {
//                                                                                   NSLog(@"分享失败：%d,%@",(int)[error errorCode], [error errorDescription]);
//                                                                                   [XtomFunction openIntervalHUD:@"分享失败" view:self.view];
//                                                                               }
//                                                                           }];
//                                                                      }];
//    
//    
//    NSArray *shareList = [ShareSDK customShareListWithType:
//                          
//                          
//                          SHARE_TYPE_NUMBER(ShareTypeWeixiTimeline),
//                          SHARE_TYPE_NUMBER(ShareTypeWeixiSession),
//                          SHARE_TYPE_NUMBER(ShareTypeQQ),
//                          
//                          SHARE_TYPE_NUMBER(ShareTypeQQSpace),
//                          
//                          sinaItem,
//                          nil];
//    
//    [ShareSDK showShareActionSheet:container
//                         shareList:shareList
//                           content:publishContent
//                     statusBarTips:NO
//                       authOptions:authOptions
//                      shareOptions:[ShareSDK defaultShareOptionsWithTitle:nil
//                                                          oneKeyShareList:[NSArray defaultOneKeyShareList]
//                                                           qqButtonHidden:NO
//                                                    wxSessionButtonHidden:NO
//                                                   wxTimelineButtonHidden:NO
//                                                     showKeyboardOnAppear:NO
//                                                        shareViewDelegate:[XtomFunction xfuncGetAppdelegate].viewDelegate
//                                                      friendsViewDelegate:[XtomFunction xfuncGetAppdelegate].viewDelegate
//                                                    picViewerViewDelegate:nil]
//                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                NSLog(@"这是啥：%d",state);
//                                return;
//                                
//                                if (state == SSPublishContentStateSuccess)
//                                {
//                                    NSLog(@"分享成功");
//                                    [XtomFunction openIntervalHUDOK:@"分享成功" view:self.view];
//                                }
//                                else if (state == SSPublishContentStateFail)
//                                {
//                                    NSLog(@"分享失败：%d,%@",(int)[error errorCode], [error errorDescription]);
//                                    [XtomFunction openIntervalHUDOK:[error errorDescription] view:self.view];
//                                }
//                            }];
//}


- (void)collectClick
{
    if ([[dataSource objectForKey:@"collectflag"] integerValue] == 0)
    {
        operType = 1;
        [dataSource setObject:@"1" forKey:@"collectflag"];
        [dataSource setObject:[NSString stringWithFormat:@"%zd", [[dataSource objectForKey:@"collectcount"] integerValue]+1] forKey:@"collectcount"];
    }
    else
    {
        operType = 2;
        [dataSource setObject:@"0" forKey:@"collectflag"];
        [dataSource setObject:[NSString stringWithFormat:@"%zd", [[dataSource objectForKey:@"collectcount"] integerValue]-1] forKey:@"collectcount"];
    }
    [mytable reloadData];
    [self requestOperator:keyid];
}

- (void)buttonClick:(UIButton *)button
{
    if (button.tag == 8)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", [dataSource objectForKey:@"tel"]]]];
    }
    if (button.tag == 9)
    {
        if ([[dataSource objectForKey:@"client_id"] isEqualToString:[[[XtomManager sharedManager] motherInfor] objectForKey:@"id"]])
        {
            [XtomFunction openIntervalHUD:@"这是自己的店铺" view:self.view];
            return;
//            InforVC * info = [[[InforVC alloc] init] autorelease];
//            [self.navigationController pushViewController:info animated:YES];
        }
        else
        {
            [dataSource setObject:[dataSource objectForKey:@"client_id"] forKeyedSubscript:@"id"];
//            NSString * userId = [dataSource objectForKey:@"client_id"];
//            WeiChatVC *chatVC = [[WeiChatVC alloc]initWithChatter:userId];
//            chatVC.isChatGroup=NO;
//            chatVC.dataSource = [[[NSMutableDictionary alloc]init]autorelease];
//            chatVC.dataSource = self.dataSource;
//            [self.navigationController pushViewController:chatVC animated:YES];
        }
    }
}

- (void)segmentAction:(UISegmentedControl *)Seg
{
    NSInteger Index = Seg.selectedSegmentIndex;
    if (Index == 1)
    {
//        CategoryVC * category = [[[CategoryVC alloc] init] autorelease];
//        category.keytype = @"3";
//        category.keyid = @"无";
//        category.sellerid = [dataSource objectForKey:@"client_id"];
//        category.isShiWu = self.isShiWu;
//        category.typeName = @"全部";
//        [self.navigationController pushViewController:category animated:YES];
    }
}


- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    NSString *temStr = [[self.dataTopAd objectAtIndex:index] objectForKey:@"shop_avatarbig"];
    imageView.tag = 1000+index;
    [imageView setImage:[UIImage imageNamed:@"商城_默认广告页4.png"]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setClipsToBounds:YES];
    if(![XtomFunction xfunc_check_strEmpty:temStr])
    {
        NSString *document = [NSString stringWithFormat:@"%@/%@",BB_CASH_DOCUMENT,BB_CASH_AVATAR];
        [[XtomCashManager sharedManager] addImgToImgViewFromDocumentORURL:imageView document:document url:temStr];
    }
    
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
   
    int count = (int)[self.dataTopAd count];
   
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        
        NSString *url = [self.dataTopAd[i] objectForKey:@"shop_avatarbig"];
        MJPhoto *photo = [[[MJPhoto alloc] init]autorelease];
        photo.url = [NSURL URLWithString:url];
        photo.srcImageView = (UIImageView*)[mytable viewWithTag:1000+index];
        [photos addObject:photo];
    }
    
    
    MJPhotoBrowser *browser = [[[MJPhotoBrowser alloc] init]autorelease];
    browser.currentPhotoIndex = index;
    browser.photos = photos;
    [browser show];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (2 == section)
    {
        return 3;
    }
    if (4 == section)
    {
        return 1 + dataArray.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        static NSString * cellID = @"StoreCell00";
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
        
        UIView * goodsDetailView = [[[UIView alloc] init] autorelease];
        goodsDetailView.frame = CGRectMake(0, 0, WIDTH, 70);
        [cell.contentView addSubview:goodsDetailView];
        
        
        UILabel * goodsName = [[[UILabel alloc] init] autorelease];
        goodsName.backgroundColor = [UIColor clearColor];
        goodsName.textAlignment = NSTextAlignmentLeft;
        goodsName.font = [UIFont systemFontOfSize:18];
        goodsName.textColor = BB_Graydark;
        [goodsName setFrame:CGRectMake(15, 10, WIDTH-60-15, 31)];
        goodsName.text = [dataSource objectForKey:@"shop_name"];
        [goodsDetailView addSubview:goodsName];
        
        
        UILabel * goodsOldPrice = [[[UILabel alloc] init] autorelease];
        goodsOldPrice.backgroundColor = [UIColor clearColor];
        goodsOldPrice.textAlignment = NSTextAlignmentLeft;
        goodsOldPrice.font = [UIFont systemFontOfSize:14];
        goodsOldPrice.textColor = BB_Button_Color;
        [goodsOldPrice setFrame:CGRectMake(15, 41, WIDTH-60-15, 21)];
        goodsOldPrice.text = [NSString stringWithFormat:@"%@人收藏", [dataSource objectForKey:@"collectcount"]];
        [goodsDetailView addSubview:goodsOldPrice];
        
        NSMutableAttributedString * attrString =
        [[NSMutableAttributedString alloc] initWithString:goodsOldPrice.text];
        UIColor *rcolor = [UIColor grayColor];
        [attrString addAttribute:NSForegroundColorAttributeName value:rcolor range:[goodsOldPrice.text rangeOfString:@"人收藏"]];
        goodsOldPrice.attributedText = attrString;
        
        
        UIView * lineView = [[[UIView alloc] init] autorelease];
        lineView.frame = CGRectMake(WIDTH-49, 18, 0.5, 34);
        lineView.backgroundColor = BB_Graydark;
        [goodsDetailView addSubview:lineView];
        
        
        UIImageView * collectImage = [[[UIImageView alloc] init] autorelease];
        collectImage.frame = CGRectMake(WIDTH-35, 26, 19, 18);
        [goodsDetailView addSubview:collectImage];
        if ([[dataSource objectForKey:@"collectflag"] integerValue] == 0)
        {
            collectImage.image = [UIImage imageNamed:@"common_collect.png"];
        }
        else
        {
            collectImage.image = [UIImage imageNamed:@"common_collect_sel.png"];
        }
        
        UIButton * collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        collectBtn.frame = CGRectMake(WIDTH-50, 0, 50, 70);
        [collectBtn addTarget:self action:@selector(collectClick) forControlEvents:UIControlEventTouchUpInside];
        [goodsDetailView addSubview:collectBtn];
        
        return cell;
    }
    if (1 == indexPath.section)
    {
        static NSString * cellID = @"StoreCell01";
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
        
        UILabel * describeLabel = [[[UILabel alloc] init] autorelease];
        describeLabel.backgroundColor = [UIColor clearColor];
        describeLabel.textAlignment = NSTextAlignmentLeft;
        describeLabel.font = [UIFont systemFontOfSize:16];
        describeLabel.textColor = BB_Graydark;
        [describeLabel setFrame:CGRectMake(15, 7, 100, 33)];
        describeLabel.text = @"商家描述";
        [cell.contentView addSubview:describeLabel];
        
        UILabel * describeDetail = [[[UILabel alloc] init] autorelease];
        describeDetail.backgroundColor = [UIColor clearColor];
        describeDetail.textAlignment = NSTextAlignmentLeft;
        describeDetail.font = [UIFont systemFontOfSize:12];
        describeDetail.textColor = BB_Graydark;
        [describeDetail setFrame:CGRectMake(15, 40, 100, 0)];
        describeDetail.text = [dataSource objectForKey:@"shop_content"];
        describeDetail.numberOfLines = 0;
        CGSize size = [XtomFunction getSizeWithStrNo:describeDetail.text width:WIDTH-30 font:12];
        describeDetail.frame = CGRectMake(15, 40, WIDTH-30, size.height);
        describeDetail.tag = 1;
        [cell.contentView addSubview:describeDetail];
        return cell;
    }
    if (2 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            static NSString * cellID = @"StoreCell02";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = BB_White_Color;
                
                
                UILabel * sourceLabel = [[[UILabel alloc] init] autorelease];
                sourceLabel.backgroundColor = [UIColor clearColor];
                sourceLabel.textAlignment = NSTextAlignmentLeft;
                sourceLabel.font = [UIFont systemFontOfSize:16];
                sourceLabel.textColor = BB_Graydark;
                [sourceLabel setFrame:CGRectMake(15, 7, 100, 33)];
                sourceLabel.text = @"联系方式";
                [cell.contentView addSubview:sourceLabel];
                
               
                UILabel * detailLabel = [[[UILabel alloc] init] autorelease];
                detailLabel.backgroundColor = [UIColor clearColor];
                detailLabel.textAlignment = NSTextAlignmentLeft;
                detailLabel.font = [UIFont systemFontOfSize:11];
                detailLabel.textColor = BB_Graydark;
                [detailLabel setFrame:CGRectMake(15, 40, WIDTH-30, 12.5)];
                [cell.contentView addSubview:detailLabel];
                detailLabel.tag = 2;
            }
            UILabel * detailLabel = (UILabel *)[cell viewWithTag:2];
            detailLabel.text = [dataSource objectForKey:@"address"];
            
            return cell;
        }
        if (1 == indexPath.row)
        {
            static NSString * cellID = @"StoreCell03";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = BB_White_Color;
            }
            cell.textLabel.text = [NSString stringWithFormat:@"咨询电话：%@", [dataSource objectForKey:@"tel"]];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            return cell;
        }
        
        static NSString * cellID = @"StoreCell04";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = BB_White_Color;
            
            UIView * buttonView1 = [[[UIView alloc] init] autorelease];
            [buttonView1 setFrame:CGRectMake(0, 0, (WIDTH-0.5)/2, 49)];
            buttonView1.backgroundColor = BB_White_Color;
            [cell.contentView addSubview:buttonView1];
            
            UIView * view1 = [[[UIView alloc] init] autorelease];
            view1.frame = CGRectMake(((WIDTH-0.5)/2-90)/2, 0, 90, 49);
            [buttonView1 addSubview:view1];
            
            UIImageView * allGoodsImg = [[[UIImageView alloc]init]autorelease];
            [allGoodsImg setFrame:CGRectMake(0, 12, 20.5, 26)];
            allGoodsImg.contentMode = UIViewContentModeScaleAspectFill;
            [allGoodsImg setClipsToBounds:YES];
            allGoodsImg.image = [UIImage imageNamed:@"商家_电话图标"];
            [view1 addSubview:allGoodsImg];
            
            UILabel * allGoodsLabel = [[[UILabel alloc]init]autorelease];
            allGoodsLabel.backgroundColor = [UIColor clearColor];
            allGoodsLabel.textAlignment = NSTextAlignmentCenter;
            allGoodsLabel.font = [UIFont systemFontOfSize:12];
            allGoodsLabel.textColor = BB_Blake;
            [allGoodsLabel setFrame:CGRectMake(20.5, 0, 66, 49)];
            allGoodsLabel.text = @"一键拨打";
            [view1 addSubview:allGoodsLabel];
            
            
            UIButton * allGoodsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [allGoodsBtn setFrame:CGRectMake(0, 0, (WIDTH-0.5)/2, 49)];
            allGoodsBtn.backgroundColor = [UIColor clearColor];
            allGoodsBtn.tag = 8;
            [allGoodsBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [buttonView1 addSubview:allGoodsBtn];
            
            
            UIView * lineView = [[[UIView alloc] init] autorelease];
            lineView.frame = CGRectMake((WIDTH-0.5)/2, 16, 0.5, 17);
            lineView.backgroundColor = BB_Gray;
            [cell.contentView addSubview:lineView];
            
            UIView * buttonView2 = [[[UIView alloc] init] autorelease];
            [buttonView2 setFrame:CGRectMake((WIDTH-0.5)/2+0.5, 0, (WIDTH-0.5)/2, 49)];
            buttonView2.backgroundColor = BB_White_Color;
            [cell.contentView addSubview:buttonView2];
            
            UIView * view2 = [[[UIView alloc] init] autorelease];
            view2.frame = CGRectMake(((WIDTH-0.5)/2-90)/2, 0, 90, 49);
            [buttonView2 addSubview:view2];
            
            UIImageView * storeInImg = [[[UIImageView alloc]init]autorelease];
            [storeInImg setFrame:CGRectMake(0, 16, 22.5, 20.5)];
            storeInImg.contentMode = UIViewContentModeScaleAspectFill;
            [storeInImg setClipsToBounds:YES];
            storeInImg.image = [UIImage imageNamed:@"快速咨询"];
            [view2 addSubview:storeInImg];
            
            UILabel * storeInLabel = [[[UILabel alloc]init]autorelease];
            storeInLabel.backgroundColor = [UIColor clearColor];
            storeInLabel.textAlignment = NSTextAlignmentCenter;
            storeInLabel.font = [UIFont systemFontOfSize:12];
            storeInLabel.textColor = BB_Blake;
            [storeInLabel setFrame:CGRectMake(22.5, 0, 66, 49)];
            storeInLabel.text = @"快速咨询";
            [view2 addSubview:storeInLabel];
            
            
            UIButton * storeInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [storeInBtn setFrame:CGRectMake(0, 0, (WIDTH-0.5)/2, 49)];
            storeInBtn.backgroundColor = [UIColor clearColor];
            storeInBtn.tag = 9;
            [storeInBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [buttonView2 addSubview:storeInBtn];
        }
        return cell;
    }
    if (3 == indexPath.section)
    {
        static NSString * cellID = @"StoreCell05";
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
        
       
        NSInteger starNum = [[dataSource objectForKey:@"stars"] integerValue];
        for (int i = 0; i < 5; i++)
        {
            UIImageView * star = [[[UIImageView alloc] init] autorelease];
            star.image = [UIImage imageNamed:@"store_reply_star_nor.png"];
            star.frame = CGRectMake(10 + i * 15, 21.25, 14, 12.5);
            [cell.contentView addSubview:star];
            if (i < starNum)
            {
                star.image = [UIImage imageNamed:@"store_reply_star_sel.png"];
            }
            else
            {
                star.image = [UIImage imageNamed:@"store_reply_star_nor.png"];
            }
        }
        
        UILabel * starNumLabel = [[[UILabel alloc] init] autorelease];
        starNumLabel.backgroundColor = [UIColor clearColor];
        starNumLabel.textAlignment = NSTextAlignmentLeft;
        starNumLabel.font = [UIFont systemFontOfSize:14];
        starNumLabel.textColor = BB_Graydark;
        [starNumLabel setFrame:CGRectMake(90, 21.25, 100, 12.5)];
        starNumLabel.text = [NSString stringWithFormat:@"%ld.0", starNum];
        [cell.contentView addSubview:starNumLabel];
        
        UILabel * evaluateLabel = [[[UILabel alloc] init] autorelease];
        evaluateLabel.backgroundColor = [UIColor clearColor];
        evaluateLabel.textAlignment = NSTextAlignmentRight;
        evaluateLabel.font = [UIFont systemFontOfSize:14];
        evaluateLabel.textColor = BB_Graydark;
        [evaluateLabel setFrame:CGRectMake(WIDTH - 129, 0, 100, 55)];
        evaluateLabel.text = [NSString stringWithFormat:@"%@人评价", [dataSource objectForKey:@"starscount"]];
        [cell.contentView addSubview:evaluateLabel];
        
        UIImageView * arrowImg = [[[UIImageView alloc] init] autorelease];
        arrowImg.frame = CGRectMake(WIDTH-19, 21.5, 7, 12);
        arrowImg.image = [UIImage imageNamed:@"商城_列表箭头.png"];
        [cell.contentView addSubview:arrowImg];
        
        return cell;
    }
    if (4 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            static NSString * cellID = @"StoreCell06";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = BB_White_Color;
                
                NSArray * segmentedArray = @[@"商家推荐", @"全部商品"];
                UISegmentedControl *segmentedControl = [[[UISegmentedControl alloc]initWithItems:segmentedArray] autorelease];
                segmentedControl.frame = CGRectMake(14, 10.5, WIDTH-28, 41.5);
                segmentedControl.selectedSegmentIndex = 0;
                segmentedControl.tintColor = [UIColor colorWithRed:51/255.f green:53/255.f blue:56/255.f alpha:1];
                [cell.contentView addSubview:segmentedControl];
                segmentedControl.tag = 10000;
                [segmentedControl addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];
            }
            
            return cell;
        }
        static NSString * cellID = @"StoreCell07";
        CategoryGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil)
        {
            cell = [[[CategoryGoodsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = BB_White_Color;
            [cell setSeparatorInset:UIEdgeInsetsMake(0, 94, 0, 0)];
        }
        NSMutableDictionary * temDict = [dataArray objectAtIndex:indexPath.row-1];
        NSString *downavatar = [temDict objectForKey:@"imgurl0"];
        cell.logoImage.image = [UIImage imageNamed:@"商城_默认广告页3.png"];
        if(![XtomFunction xfunc_check_strEmpty:downavatar])
        {
            NSString *document = [NSString stringWithFormat:@"%@/%@",BB_CASH_DOCUMENT,BB_CASH_AVATAR];
            [[XtomCashManager sharedManager] addImgToImgViewFromDocumentORURL:cell.logoImage document:document url:downavatar];
        }
        
        
        [cell.hotFlag setHidden:NO];
        
        
        cell.goodsName.text = [temDict objectForKey:@"name"];
        cell.goodsNowPrice.text = [NSString stringWithFormat:@"%@元", [temDict objectForKey:@"price"]];
        NSMutableAttributedString * attrString =
        [[NSMutableAttributedString alloc] initWithString:cell.goodsNowPrice.text];
        UIFont *smallFont = [UIFont systemFontOfSize:10];
        [attrString addAttribute:NSFontAttributeName value:smallFont range:[cell.goodsNowPrice.text rangeOfString:@"元"]];
        cell.goodsNowPrice.attributedText = attrString;
        cell.goodsOldPrice.text = [NSString stringWithFormat:@"%@元",[temDict objectForKey:@"oldprice"]];
        NSUInteger length = [cell.goodsOldPrice.text length];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:cell.goodsOldPrice.text];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
        [cell.goodsOldPrice setAttributedText:attri];
        cell.goodsSellNum.text = [NSString stringWithFormat:@"已售%@", [temDict objectForKey:@"paycount"]];
        return cell;
        
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
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        return 70;
    }
    if (1 == indexPath.section)
    {
        UILabel * describeDetail = (UILabel *)[mytable viewWithTag:1];
        CGSize size = [XtomFunction getSizeWithStrNo:describeDetail.text width:WIDTH-30 font:12];
        return 40+size.height+10;
    }
    if (2 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            return 60;
        }
        return 49;
    }
    if (3 == indexPath.section)
    {
        return 55;
    }
    if (4 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            return 62.5;
        }
        return 80;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (3 == indexPath.section)
    {
//        StoreEvaluateVC * evaluate = [[[StoreEvaluateVC alloc] init] autorelease];
//        evaluate.keyid = self.keyid;
//        NSLog(@"%@", evaluate.keyid);
//        evaluate.starNum = [dataSource objectForKey:@"stars"];
//        evaluate.replyNum = [dataSource objectForKey:@"starscount"];
//        evaluate.firstNum = [dataSource objectForKey:@"stars_attitude"];
//        evaluate.secondNum = [dataSource objectForKey:@"stars_speed"];
//        evaluate.thirdNum = [dataSource objectForKey:@"stars_quality"];
//        [self.navigationController pushViewController:evaluate animated:YES];
    }
    if (4 == indexPath.section && 0 != indexPath.row)
    {
        NSMutableDictionary * temDict = [dataArray objectAtIndex:indexPath.row-1];
        if ([[temDict objectForKey:@"blogtype"] integerValue] == 1)// 虚拟
        {
//            VirtualDetailVC * detail = [[[VirtualDetailVC alloc] init] autorelease];
//            detail.keyid = [temDict objectForKey:@"id"];
//            detail.keytype = @"1";
//            [self.navigationController pushViewController:detail animated:YES];
        }
        else
        {
            RealityDetailVC * detail = [[[RealityDetailVC alloc] init] autorelease];
            detail.keyid = [temDict objectForKey:@"id"];
            detail.keytype = @"1";
            [self.navigationController pushViewController:detail animated:YES];
        }
    }
}


- (void)requestStoreDetail
{
    NSString *token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token forKey:@"token"];
    [dic setObject:keyid forKey:@"id"];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_SHOP_GET] target:self selector:@selector(responseStoreDetail:) parameter:dic];
}

- (void)responseStoreDetail:(NSDictionary *)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        if(![XtomFunction xfunc_check_strEmpty:[info objectForKey:@"infor"]])
        {
            if (!dataSource)
            {
                self.dataSource = [[[NSMutableDictionary alloc]init]autorelease];
                self.dataTopAd = [[[NSMutableArray alloc] init] autorelease];
            }
            [dataSource removeAllObjects];
            [dataTopAd removeAllObjects];
            NSDictionary *temDict = [[info objectForKey:@"infor"] objectAtIndex:0];
            for(NSString *key in temDict.allKeys)
            {
                NSString *value = [temDict objectForKey:key];
                if(![XtomFunction xfunc_check_strEmpty:value])
                {
                    [dataSource setObject:value forKey:key];
                }
                else
                {
                    [dataSource setObject:@"" forKey:key];
                }
            }
            
            NSString * val = [[[info objectForKey:@"infor"] objectAtIndex:0] objectForKey:@"shop_avatar"];
            if (![XtomFunction xfunc_check_strEmpty:val])
            {
                NSMutableDictionary *dict = [[[NSMutableDictionary alloc] init] autorelease];
                [dict setObject:val forKey:@"shop_avatar"];
                [dict setObject:info[@"infor"][0][@"shop_avatarbig"] forKey:@"shop_avatarbig"];
                [dataTopAd addObject:dict];
                [player initWithCount:dataTopAd.count delegate:self];
                player.hidePageControl = YES;
            }
            else
            {
                UIImageView *leftImgView = [[[UIImageView alloc]init]autorelease];
                leftImgView.clipsToBounds = YES;
                [leftImgView setFrame:CGRectMake(0, 0, WIDTH, 215)];
                [leftImgView setImage:[UIImage imageNamed:@"商城_默认广告页4.png"]];
                leftImgView.contentMode = UIViewContentModeScaleAspectFill;
                self.mytable.tableHeaderView = leftImgView;
            }
        }
        [self requestReplyList];
    }
    else
    {
        if ([[info objectForKey:@"error_code"]integerValue] == 404)
        {
            [mytable setHidden:YES];
            [XtomFunction openIntervalHUD:@"很抱歉，此商家不存在" view:self.view];
            [self performSelector:@selector(gotoBack) withObject:nil afterDelay:1.2];
            
        }
        else
        {
            if([info objectForKey:@"msg"])
            {
                [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:self.view];
            }
        }
    }
}


-(void)gotoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)requestReplyList
{
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:@"无" forKey:@"client_id"];
    [dic setObject:@"8" forKey:@"keytype"];
    [dic setObject:keyid forKey:@"keyid"];
    [dic setObject:@"无" forKey:@"sellerid"];
    [dic setObject:@"1" forKey:@"orderby"];
    [dic setObject:@"desc" forKey:@"ordertype"];
    [dic setObject:@"" forKey:@"keyword"];
    [dic setObject:@"0" forKey:@"page"];
    NSString *url = [NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_BLOG_LIST];
    [XTomRequest requestWithURL:url target:self selector:@selector(responseReplyList:) parameter:dic];
}

- (void)responseReplyList:(NSDictionary *)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        if (!dataArray)
        {
            self.dataArray = [[[NSMutableArray alloc]init]autorelease];
        }
        if(0 == currentPage)
        {
            [dataArray removeAllObjects];
        }
        
        NSString * val = [[info objectForKey:@"infor"] objectForKey:@"listItems"];
        if ([XtomFunction xfunc_check_strEmpty:val]) {
            [self forbidAddMore];
            isEnd = YES;
            if(isMore)
            {
                [self getNoMoreData];
            }
        }
        else
        {
            NSArray *temArr = [[info objectForKey:@"infor"] objectForKey:@"listItems"];
            if ([temArr count] == 0)
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
                        else
                        {
                            [dict setObject:@"" forKey:key];
                        }
                    }
                    [self.dataArray addObject:dict];
                }
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


- (void)requestOperator:(NSString *)operId
{
    NSString *token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token forKey:@"token"];
    switch (operType)
    {
        case 1:
        {
            [dic setObject:@"3" forKey:@"keytype"];
            [dic setObject:@"1" forKey:@"oper"];
        }
            break;
        case 2:
        {
            [dic setObject:@"3" forKey:@"keytype"];
            [dic setObject:@"2" forKey:@"oper"];
        }
            break;
        default:
            break;
    }
    [dic setObject:operId forKey:@"keyid"];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_FOLLOW_COLLECT_OPERATOR] target:self selector:@selector(responseOperator:) parameter:dic];
}

- (void)responseOperator:(NSDictionary *)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        switch (operType)
        {
            case 1:
            {
                [XtomFunction openIntervalHUD:@"收藏成功" view:nil];
            }
                break;
            case 2:
            {
                [XtomFunction openIntervalHUD:@"取消收藏成功" view:nil];
            }
                break;
            default:
                break;
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


-(void)reShowView
{
    [mytable reloadData];
}


- (void)refresh
{
    currentPage = 0;
    isEnd = NO;
    [self requestStoreDetail];
}


-(void)addMore
{
    if (!isEnd)
    {
        currentPage ++;
    }
    [self requestStoreDetail];
}

@end
