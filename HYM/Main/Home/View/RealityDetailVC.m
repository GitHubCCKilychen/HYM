//
//  RealityDetailVC.m
//  PingChuan
//
//  Created by pengli on 15/9/23.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "RealityDetailVC.h"
//#import "ImagePlayerView.h"
#import "GoodsReplyCell.h"
//#import "BBButton.h"
//#import "CategoryVC.h"
//#import "StoreDetailVC.h"
//#import "OrderCreateVC.h"
//#import "MJPhoto.h"
//#import "MJPhotoBrowser.h"
//#import "TapGR.h"
//#import "InforVC.h"
//#import "FriendHomeVC.h"
//#import "EvaluateVC.h"
//
//#import "FriendHomeVC.h"
//#import "WeiChatVC.h"
//#import "MyBuyCarListVC.h"
//#import "ShiWuNewPublishVC.h"
//
//#import <AGCommon/UINavigationBar+Common.h>
//#import <AGCommon/UIImage+Common.h>
//#import <AGCommon/UIColor+Common.h>
//#import <AGCommon/UIDevice+Common.h>
//#import <ShareSDK/ShareSDK.h>

@interface RealityDetailVC ()
//<ImagePlayerViewDelegate, UIAlertViewDelegate, UIGestureRecognizerDelegate, operateCollectDelegate>
{
    BOOL isParameterOpen;
    NSInteger operType;
}
@property (nonatomic, retain) UIView * tabbarView;


@property (nonatomic, retain) UIView * displayView;
@property (nonatomic, retain) UIView * whiteBack;
@property (nonatomic, retain) UIImageView * cancelImage;
@property (nonatomic, retain) UIImageView * logoImage1;
@property (nonatomic, retain) UILabel * goodsTitle1;
@property (nonatomic, retain) UILabel * goodsPrice1;
@property (nonatomic, retain) UILabel * numTextFeild;
@property (nonatomic, retain) UIButton * buttonCancel;
@property (nonatomic, retain) NSMutableDictionary * dataSource;
@property (nonatomic, retain) NSMutableArray * dataArray;
@property (nonatomic, retain) NSMutableArray * paraArray;
//@property (nonatomic, retain) ImagePlayerView * player;
@property (nonatomic, retain) NSMutableArray * dataTopAd;
@property (nonatomic, retain) UIImageView * outdateImg;
@property (nonatomic, retain) NSMutableArray * picArr;

@end

@implementation RealityDetailVC
@synthesize tabbarView;

@synthesize displayView;
@synthesize whiteBack;
@synthesize cancelImage;
@synthesize logoImage1;
@synthesize goodsTitle1;
@synthesize goodsPrice1;
@synthesize numTextFeild;
@synthesize buttonCancel;
@synthesize dataSource;
@synthesize dataArray;
@synthesize paraArray;
//@synthesize player;
@synthesize dataTopAd;
@synthesize outdateImg;
@synthesize picArr;

@synthesize isPresent;
@synthesize keytype;
@synthesize isOutdate;
@synthesize keyid;
@synthesize isSetting;

- (void)dealloc
{
    [tabbarView release]; tabbarView = nil;
    
    [displayView release]; displayView = nil;
    [whiteBack release]; whiteBack = nil;
    [cancelImage release]; cancelImage = nil;
    [logoImage1 release]; logoImage1 = nil;
    [goodsTitle1 release]; goodsTitle1 = nil;
    [goodsPrice1 release]; goodsPrice1 = nil;
    [numTextFeild release]; numTextFeild = nil;
    [buttonCancel release]; buttonCancel = nil;
    [dataSource release]; dataSource = nil;
    [dataArray release]; dataArray = nil;
    [paraArray release]; paraArray = nil;
//    [player release]; player = nil;
    [dataTopAd release]; dataTopAd = nil;
    [outdateImg release]; outdateImg = nil;
    [picArr release]; picArr = nil;
    
    [keytype release]; keytype = nil;
    [keyid release]; keyid = nil;
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:BUY_SUCCESS_SHIQU object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:CHANGE_SWGOODS_SUCCESS object:nil];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(changeGoodsState)
//                                                 name:BUY_SUCCESS_SHIQU
//                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:CHANGE_SWGOODS_SUCCESS object:nil];
}

- (void)changeGoodsState
{
    [self refresh];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    [self loadSet];
}

- (void)loadSet
{
//    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//    [self.navigationController.navigationBar setBarTintColor:NavigationColor];
//    [self.navigationItem setNewTitle:@"实物商品详情"];
//    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftBtnPressed) image:@"common_return.png" imageH:@"common_return.png"];
    
    
    UIView *rightBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 44)];
    rightBarView.backgroundColor = [UIColor clearColor];
   
    UIImageView * cartImage = [[[UIImageView alloc] init] autorelease];
    cartImage.frame = CGRectMake(12.5, 13.5, 17.5, 17);
    [cartImage setImage:[UIImage imageNamed:@"购物车图标"]];
    [rightBarView addSubview:cartImage];
    
    UIButton * cartClickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cartClickBtn.frame = CGRectMake(0, 0, 30, 44);
    [cartClickBtn addTarget:self action:@selector(gotoCart) forControlEvents:UIControlEventTouchDown];
    [rightBarView addSubview:cartClickBtn];
    
    
    UIImageView * shareImage = [[[UIImageView alloc] init] autorelease];
    shareImage.frame = CGRectMake(50, 11, 20, 22);
    [shareImage setImage:[UIImage imageNamed:@"common_share.png"]];
    [rightBarView addSubview:shareImage];
    
    UIButton * shareClickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareClickBtn.frame = CGRectMake(40, 0, 30, 44);
    [shareClickBtn addTarget:self action:@selector(rightBtnPressed)forControlEvents:UIControlEventTouchDown];
    [rightBarView addSubview:shareClickBtn];
    
    if ([keytype isEqualToString:@"1"])
    {
        cartImage.frame = CGRectMake(12.5, 13.5, 17.5, 17);
        cartClickBtn.frame = CGRectMake(0, 0, 30, 44);
        shareImage.frame = CGRectMake(50, 11, 20, 22);
        shareClickBtn.frame = CGRectMake(40, 0, 30, 44);
        cartImage.image = [UIImage imageNamed:@"购物车图标"];
    }
    else
    {
        shareImage.frame = CGRectMake(15, 11, 20, 22);
        shareClickBtn.frame = CGRectMake(0, 0, 30, 44);
        cartImage.frame = CGRectMake(46.5, 13, 17, 18);
        cartClickBtn.frame = CGRectMake(40, 0, 30, 44);
        cartImage.image = [UIImage imageNamed:@"商品编辑"];
    }
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:rightBarView];
    self.navigationItem.rightBarButtonItem = rightBtn;

    [self.view setBackgroundColor:BB_Back_Color_Here];
    
   
    UIView *myView = [[[UIView alloc]init]autorelease];
    [myView setFrame:CGRectMake(0, 0, WIDTH, 215)];
    myView.backgroundColor = BB_Back_Color_Here;
    self.mytable.tableHeaderView = myView;
    
//    self.player = [[[ImagePlayerView alloc]init]autorelease];
//    [player setFrame:CGRectMake(0, 0, WIDTH, 215)];
//    player.scrollInterval = 3;
//    player.imagePlayerViewDelegate = self;
//    player.pageControlPosition = ICPageControlPosition_BottomCenter;
//    player.hidePageControl = NO;
//    [myView addSubview:player];
    
    [self reSetTableViewFrame:CGRectMake(0, 0, WIDTH, UI_View_Hieght-49)];
    [mytable setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self forbidAddMore];
    
    
    self.tabbarView = [[[UIView alloc] init] autorelease];
    [XtomFunction addbordertoView:tabbarView radius:0 width:0.5 color:BB_Gray];
    tabbarView.frame = CGRectMake(-0.5, UI_View_Hieght - 49, WIDTH+1, 49);
    tabbarView.backgroundColor = [UIColor colorWithRed:244/255.f green:244/255.f blue:244/255.f alpha:1];
    [self.view addSubview:tabbarView];
    
    if ([keytype integerValue] == 1)
    {
        
        UIImageView * consultImg = [[[UIImageView alloc] init] autorelease];
        consultImg.userInteractionEnabled = YES;
        consultImg.frame = CGRectMake(26.5, (49-34.5)/2, 20.5, 34.5);
        consultImg.image = [UIImage imageNamed:@"立即咨询.png"];
        [tabbarView addSubview:consultImg];
        
        UIButton * consultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        consultBtn.frame = CGRectMake(0, 0, 70, 49);
        [consultBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [consultBtn setImage:[UIImage imageNamed:@"store_shoppingcart"] forState:UIControlStateNormal];
        [tabbarView addSubview:consultBtn];
        consultBtn.tag = 1;
        
       
        UIButton * addCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addCarBtn.frame = CGRectMake(70, 4.5,(WIDTH-84)/2, 40);
        [addCarBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [addCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addCarBtn.backgroundColor = [UIColor colorWithRed:245/255.f green:43/255.f blue:91/255.f alpha:1];
        [addCarBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [tabbarView addSubview:addCarBtn];
        addCarBtn.tag = 2;
        
        UIButton * buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        buyBtn.frame = CGRectMake((WIDTH-84)/2+4+70, 4.5, (WIDTH-84)/2, 40);
        [buyBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
        [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buyBtn.backgroundColor = BB_Button_Color;
        [buyBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [tabbarView addSubview:buyBtn];
        buyBtn.tag = 3;
    }
    else if ([keytype integerValue] == 2)
    {
       
        UIImageView * deleteImg = [[[UIImageView alloc] init] autorelease];
        deleteImg.userInteractionEnabled = YES;
        deleteImg.frame = CGRectMake((WIDTH-289)/4, 8, 97, 36);
        deleteImg.image = [UIImage imageNamed:@"删除商品图标.png"];
        [tabbarView addSubview:deleteImg];
        
        UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.frame = CGRectMake((WIDTH-289)/4, 0, 97, 49);
        [deleteBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [tabbarView addSubview:deleteBtn];
        deleteBtn.tag = 1;
        
        self.outdateImg = [[[UIImageView alloc] init] autorelease];
        outdateImg.userInteractionEnabled = YES;
        outdateImg.frame = CGRectMake((WIDTH-289)/4*2+97, 8, 97, 36);
        if (isOutdate)
        {
            outdateImg.image = [UIImage imageNamed:@"上架商品图标.png"];
        }
        else
        {
            outdateImg.image = [UIImage imageNamed:@"下架商品图标.png"];
        }
        [tabbarView addSubview:outdateImg];
        
        UIButton * outdateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        outdateBtn.frame = CGRectMake((WIDTH-289)/4*2+97, 0, 97, 49);
        [outdateBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [tabbarView addSubview:outdateBtn];
        outdateBtn.tag = 2;
        
        UIImageView * consultImg = [[[UIImageView alloc] init] autorelease];
        consultImg.userInteractionEnabled = YES;
        consultImg.frame = CGRectMake((WIDTH-289)/4*3+97*2, 8, 95, 36);
        if (isSetting)
        {
            consultImg.image = [UIImage imageNamed:@"取消推荐.png"];
        }
        else
        {
            consultImg.image = [UIImage imageNamed:@"设置推荐图标.png"];
        }
        consultImg.tag = 22;
        [tabbarView addSubview:consultImg];
        
        UIButton * consultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        consultBtn.frame = CGRectMake((WIDTH-289)/4*3+97*2, 0, 95, 49);
        [consultBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [tabbarView addSubview:consultBtn];
        consultBtn.tag = 3;
    }
    
    
    self.displayView = [[[UIView alloc]init]autorelease];
    [displayView setFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [displayView setHidden:YES];
    displayView.alpha = 0.5;
    [displayView setBackgroundColor:[UIColor blackColor]];
    [[XtomFunction xfuncGetAppdelegate].window addSubview:displayView];
    
    
    self.whiteBack = [[[UIView alloc] init] autorelease];
    whiteBack.backgroundColor = BB_Back_Color_Here;
    whiteBack.frame = CGRectMake(0, HEIGHT-200, WIDTH, 200);
    [[XtomFunction xfuncGetAppdelegate].window addSubview:whiteBack];
    [whiteBack setHidden:YES];
    
    
    self.logoImage1 = [[[UIImageView alloc] init] autorelease];
    logoImage1.frame = CGRectMake(12.5, -48, 103, 103);
    [XtomFunction addBorderToView:logoImage1];
    logoImage1.image = [UIImage imageNamed:@""];
    logoImage1.backgroundColor = [UIColor yellowColor];
    
    [whiteBack addSubview:logoImage1];
    
    
    self.cancelImage = [[[UIImageView alloc] init] autorelease];
    cancelImage.frame = CGRectMake(WIDTH-44, HEIGHT-200-15, 30, 30);
    cancelImage.image = [UIImage imageNamed:@"取消购买.png"];
    [[XtomFunction xfuncGetAppdelegate].window addSubview:cancelImage];
    cancelImage.userInteractionEnabled = YES;
    [cancelImage setHidden:YES];
    
    self.buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonCancel.frame = CGRectMake(WIDTH-60, HEIGHT-200-60/2, 60, 60);
    [buttonCancel addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [buttonCancel setBackgroundColor:[UIColor clearColor]];
    buttonCancel.tag = 10000000;
    [[XtomFunction xfuncGetAppdelegate].window addSubview:buttonCancel];
    [buttonCancel setHidden:YES];
    
   
    self.goodsPrice1 = [[[UILabel alloc] init] autorelease];
    goodsPrice1.frame = CGRectMake(128, 14, 150, 25.5);
    goodsPrice1.text = @"120元";
    goodsPrice1.textColor = BB_Button_Color;
    goodsPrice1.textAlignment = NSTextAlignmentLeft;
    goodsPrice1.font = [UIFont systemFontOfSize:18];
    [whiteBack addSubview:goodsPrice1];
    
    
    self.goodsTitle1 = [[[UILabel alloc] init] autorelease];
    goodsTitle1.frame = CGRectMake(128, 39.5, 200, 20);
    goodsTitle1.text = @"库存 0";
    goodsTitle1.textColor = [UIColor blackColor];
    goodsTitle1.textAlignment = NSTextAlignmentLeft;
    goodsTitle1.font = [UIFont systemFontOfSize:15];
    [whiteBack addSubview:goodsTitle1];
    
    
    UILabel * buyNum = [[[UILabel alloc] init] autorelease];
    buyNum.frame = CGRectMake(15, 92, 100, 25);
    buyNum.text = @"购买数量";
    buyNum.textColor = [UIColor blackColor];
    buyNum.textAlignment = NSTextAlignmentLeft;
    buyNum.font = [UIFont systemFontOfSize:16];
    [whiteBack addSubview:buyNum];
    
    
    UIImageView * inputImage = [[[UIImageView alloc] init] autorelease];
    inputImage.frame = CGRectMake(WIDTH-126, 88, 224/2, 32.5);
    inputImage.image = [UIImage imageNamed:@"购买数量背景图.png"];
    inputImage.userInteractionEnabled = YES;
    [whiteBack addSubview:inputImage];
    
    
    UIButton * subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    subBtn.frame = CGRectMake(0, 0, 56, 32.5);

    [subBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    subBtn.tag = 10;
    [inputImage addSubview:subBtn];
    
    
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(56, 0, 56, 32.5);
    
    [addBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.tag = 11;
    [inputImage addSubview:addBtn];
    
    
    self.numTextFeild = [[[UILabel alloc] init] autorelease];
    numTextFeild.textColor = [UIColor grayColor];
    numTextFeild.font = [UIFont systemFontOfSize:15.0];
    numTextFeild.text = @"";
    numTextFeild.frame = CGRectMake(34, 0, 44, 32.5);
    numTextFeild.textAlignment = NSTextAlignmentCenter;
    [inputImage addSubview:numTextFeild];
    
    
    UIButton * finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [finishBtn setBackgroundColor:BB_Button_Color];
    finishBtn.frame = CGRectMake(0, 200-49, WIDTH, 49);
    [finishBtn setTitle:@"确定" forState:UIControlStateNormal];
    [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    finishBtn.tag = 12;
    [whiteBack addSubview:finishBtn];
}

- (void)loadData
{
    [self requestVirtualDetail];
}

- (void)leftBtnPressed
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

- (void)gotoCart
{
    if ([keytype integerValue] == 1)
    {
        //MyBuyCarListVC * buycar = [[[MyBuyCarListVC alloc] init] autorelease];
        //[self.navigationController pushViewController:buycar animated:YES];
    }
    else
    {
        //ShiWuNewPublishVC * publish = [[[ShiWuNewPublishVC alloc] init] autorelease];
        //publish.isEdit = YES;
        NSMutableDictionary * temDict = [[[NSMutableDictionary alloc] init] autorelease];
        
        
        [temDict setObject:dataSource[@"id"] forKey:@"id"];
        
        
        NSMutableArray * temArr1 = [[[NSMutableArray alloc] init] autorelease];
        NSString *avatar = dataSource[@"blogImgItems"];
        if(![XtomFunction xfunc_check_strEmpty:avatar])
        {
            for (int i = 0; i < [dataSource[@"blogImgItems"] count]; i++)
            {
                NSMutableDictionary * temDict1 = [[[NSMutableDictionary alloc] init] autorelease];
                for(NSString * key in [dataSource[@"blogImgItems"][i] allKeys])
                {
                    NSString * value = dataSource[@"blogImgItems"][i][key];
                    
                    if(![XtomFunction xfunc_check_strEmpty:value])
                    {
                        [temDict1 setObject:value forKey:key];
                    }
                }
                [temArr1 addObject:temDict1];
            }
        }
        [temDict setObject:temArr1 forKey:@"goodsPic"];
        
        
        [temDict setObject:dataSource[@"name"] forKey:@"name"];
        
        
        NSString *string = [dataSource[@"typename"] stringByReplacingOccurrencesOfString:@"," withString:@"-"];
        [[dataSource[@"typename"] componentsSeparatedByString:@","] componentsJoinedByString:@"-"];
        [temDict setObject:string forKey:@"typename"];
        [temDict setObject:dataSource[@"typeid"] forKey:@"typeid"];

        NSString * val1 = dataSource[@"blogParams"];
        NSMutableArray * temArr3 = [[[NSMutableArray alloc] init] autorelease];
        NSMutableArray * temArr4 = [[[NSMutableArray alloc] init] autorelease];
        if (![XtomFunction xfunc_check_strEmpty:val1])
        {
            NSMutableArray * canshuArr = dataSource[@"blogParams"];
            for (int i = 0; i < [canshuArr count]; i++)
            {
                NSMutableDictionary * temDict1 = [[[NSMutableDictionary alloc] init] autorelease];
                for(NSString * key in [dataSource[@"blogParams"][i] allKeys])
                {
                    NSString * value = dataSource[@"blogParams"][i][key];
                   
                    if(![XtomFunction xfunc_check_strEmpty:value])
                    {
                        [temDict1 setObject:value forKey:key];
                    }
                }
                if ([dataSource[@"blogParams"][i][@"param_type"] integerValue] == 1)
                {

                }
                else
                {
                    [temArr4 addObject:temDict1];
                }
            }
        }
        
        
        [temDict setObject:temArr3 forKey:@"XiTongCanShu"];
        
        
        [temDict setObject:temArr4 forKey:@"GeXingCanShu"];
        
        
        [temDict setObject:dataSource[@"leftcount"] forKey:@"leftcount"];
        
        
        [temDict setObject:dataSource[@"price"] forKey:@"price"];
        
        
        [temDict setObject:dataSource[@"oldprice"] forKey:@"oldprice"];
        
       
        [temDict setObject:dataSource[@"expressfee"] forKey:@"expressfee"];
        
        
        [temDict setObject:dataSource[@"expressforfree"] forKey:@"expressforfree"];
        
        
        [temDict setObject:dataSource[@"content"] forKey:@"content"];
        
        
        NSMutableArray * temArr2 = [[[NSMutableArray alloc] init] autorelease];
        NSString * val = dataSource[@"imgItems"];
        if(![XtomFunction xfunc_check_strEmpty:val])
        {
            for (int i = 0; i < [dataSource[@"imgItems"] count]; i++)
            {
                NSMutableDictionary * temDict1 = [[[NSMutableDictionary alloc] init] autorelease];
                for(NSString * key in [dataSource[@"imgItems"][i] allKeys])
                {
                    NSString * value = dataSource[@"imgItems"][i][key];
                    
                    if(![XtomFunction xfunc_check_strEmpty:value])
                    {
                        [temDict1 setObject:value forKey:key];
                    }
                }
                [temArr2 addObject:temDict1];
            }
        }
        [temDict setObject:temArr2 forKey:@"describePic"];
//        
//        publish.dataSource = temDict;
//        [self.navigationController pushViewController:publish animated:YES];
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
//    NSString *myname = [dataSource objectForKey:@"name"]?[dataSource objectForKey:@"name"]:@"薅羊毛";
//    
//    NSString *myCon = [dataSource objectForKey:@"content"]?[dataSource objectForKey:@"content"]:@"薅羊毛是一款不错的软件哦~~";
//    
//    NSString *myUrl = [NSString stringWithFormat:@"%@share/sdk.php?id=%@&client_id=%@",[[[XtomManager sharedManager] myinitInfor] objectForKey:@"sys_plugins"], self.keyid, [[XtomManager sharedManager] motherInfor][@"id"]];
//    NSLog(@"%@", myUrl);
//    
//    NSString * myImage = [dataSource objectForKey:@"imgurl0"]?[dataSource objectForKey:@"imgurl0"]:[NSString stringWithFormat:@"%@images/logo.png",REQUEST_MAINLINK_INIT];
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

- (void)setBuyView
{
   
    NSString *downavatar = [dataSource objectForKey:@"imgurl0"];
    logoImage1.image = [UIImage imageNamed:@"商城_默认广告页3.png"];
    if(![XtomFunction xfunc_check_strEmpty:downavatar])
    {
        NSString *document = [NSString stringWithFormat:@"%@/%@",BB_CASH_DOCUMENT,BB_CASH_AVATAR];
        [[XtomCashManager sharedManager] addImgToImgViewFromDocumentORURL:logoImage1 document:document url:downavatar];
    }
    
    goodsPrice1.text = [NSString stringWithFormat:@"%@元", [dataSource objectForKey:@"price"]];
    
    goodsTitle1.text = [NSString stringWithFormat:@"库存 %@", [dataSource objectForKey:@"leftcount"]];
}


- (void)collectClick
{
    if ([[dataSource objectForKey:@"collectflag"] integerValue] == 0)
    {
        operType = 1;
        [dataSource setObject:@"1" forKey:@"collectflag"];
    }
    else
    {
        operType = 2;
        [dataSource setObject:@"0" forKey:@"collectflag"];
    }
    [mytable reloadData];
    [self requestOperator:keyid];
}

- (void)buttonClick:(UIButton *)button
{
    if (button.tag == 1)
    {
        if ([keytype integerValue] == 1)
        {
            if ([[dataSource objectForKey:@"client_id"] isEqualToString:[[[XtomManager sharedManager] motherInfor] objectForKey:@"id"]])
            {
                [XtomFunction openIntervalHUD:@"这是自己发布的商品哦" view:self.view];
                return;
//                InforVC * info = [[[InforVC alloc] init] autorelease];
//                [self.navigationController pushViewController:info animated:YES];
            }
            else
            {
                [dataSource setObject:[dataSource objectForKey:@"client_id"] forKeyedSubscript:@"id"];
                NSString * userId = [dataSource objectForKey:@"client_id"];
//                WeiChatVC *chatVC = [[WeiChatVC alloc]initWithChatter:userId];
//                chatVC.isChatGroup=NO;
//                chatVC.dataSource = [[[NSMutableDictionary alloc]init]autorelease];
//                chatVC.dataSource = self.dataSource;
//                [self.navigationController pushViewController:chatVC animated:YES];
            }
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您确定要删除该商品吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            alert.tag = 99;
            alert.delegate = self;
            [alert release];
        }
    }
    if (button.tag == 2)
    {
        if ([keytype integerValue] == 1)
        {
            if ([[dataSource objectForKey:@"client_id"] isEqualToString:[[[XtomManager sharedManager] motherInfor] objectForKey:@"id"]])
            {
                [XtomFunction openIntervalHUD:@"这是自己发布的商品哦" view:self.view];
                return;
            }
            [self requestAddtoCart];
        }
        else
        {
            NSNotification *notification = [NSNotification notificationWithName:CHANGE_SWGOODS_SUCCESS object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            if (isOutdate)
            {
                NSLog(@"上架");
                operType = 5;
                [self requestDeleteGoods];
            }
            else
            {
                NSLog(@"下架");
                operType = 6;
                [self requestDeleteGoods];
            }
        }
    }
    if (button.tag == 3)
    {
        if ([keytype integerValue] == 1)
        {
            NSLog(@"立即抢购");
            if ([[dataSource objectForKey:@"client_id"] isEqualToString:[[[XtomManager sharedManager] motherInfor] objectForKey:@"id"]])
            {
                [XtomFunction openIntervalHUD:@"这是自己发布的商品哦" view:self.view];
                return;
            }
            if ([[dataSource objectForKey:@"leftcount"] integerValue] == 0)
            {
                [XtomFunction openIntervalHUD:@"库存不足！" view:self.view];
                return;
            }
            [numTextFeild becomeFirstResponder];
            [displayView setHidden:NO];
            [whiteBack setHidden:NO];
            [cancelImage setHidden:NO];
            [numTextFeild becomeFirstResponder];
            [displayView setHidden:NO];
            [whiteBack setHidden:NO];
            [cancelImage setHidden:NO];
            numTextFeild.text = @"1";
            [buttonCancel setHidden:NO];
        }
        else
        {
            if (isSetting)
            {
                isSetting = NO;
                operType = 7;
                [self requestDeleteGoods];
            }
            else
            {
                isSetting = YES;
                operType = 4;
                [self requestDeleteGoods];
            }
        }
    }
    if (button.tag == 6)
    {
        if (isParameterOpen)
        {
            isParameterOpen = NO;
        }
        else
        {
            isParameterOpen = YES;
        }
        [mytable reloadData];
    }
    if (button.tag == 7)
    {
        NSMutableDictionary * temDic = [[dataSource objectForKey:@"shopInfo"] objectAtIndex:0];
        NSString * tels = [temDic objectForKey:@"tel"];
        UIAlertView * av = [[[UIAlertView alloc] initWithTitle:@"" message:tels delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil] autorelease];
        [av show];
    }
    if (button.tag == 8)
    {
//        CategoryVC * category = [[[CategoryVC alloc] init] autorelease];
//        category.keytype = @"3";
//        category.keyid = @"2";
//        category.sellerid = [dataSource  objectForKey:@"client_id"];
//        category.isShiWu = YES;
//        category.typeName = @"全部";
//        [self.navigationController pushViewController:category animated:YES];
    }
    if (button.tag == 9)
    {
//        StoreDetailVC * store = [[[StoreDetailVC alloc] init] autorelease];
//        store.keyid = [[[dataSource objectForKey:@"shopInfo"] objectAtIndex:0] objectForKey:@"id"];
//        store.isShiWu = YES;
//        store.delegate = self;
//        [self.navigationController pushViewController:store animated:YES];
    }
    if (button.tag == 10)
    {
        if ([numTextFeild.text integerValue] > 1)
        {
            numTextFeild.text = [NSString stringWithFormat:@"%d", [numTextFeild.text intValue]-1];
        }
    }
    if (button.tag == 11)
    {
        if ([[dataSource objectForKey:@"leftcount"] isEqualToString:numTextFeild.text])
        {
            return;
        }
        numTextFeild.text = [NSString stringWithFormat:@"%d", [numTextFeild.text intValue]+1];
    }
    if (button.tag == 12)
    {
        
        [numTextFeild resignFirstResponder];
        [displayView setHidden:YES];
        [whiteBack setHidden:YES];
        [cancelImage setHidden:YES];
        [buttonCancel setHidden:YES];
        
//        OrderCreateVC * order = [[[OrderCreateVC alloc]init]autorelease];
//        order.isReality = YES;
//        order.dataSource = [NSMutableArray arrayWithObjects:dataSource, nil];
//        order.keytype = @"2";
//        order.sectionNum = 4;
//        order.buycount = [numTextFeild.text integerValue];
//        order.keyid = [dataSource objectForKey:@"id"];
//        [self.navigationController pushViewController:order animated:YES];
    }
    if (button.tag == 10000000)
    {
        [numTextFeild resignFirstResponder];
        [displayView setHidden:YES];
        [whiteBack setHidden:YES];
        [cancelImage setHidden:YES];
        [buttonCancel setHidden:YES];
    }
}

//- (void)handlemySingleTap:(TapGR *)tap
//{
//    if (tap.touchI == 2)
//    {
//        
//        NSInteger count = 1;
//        UITableViewCell *temCell = (UITableViewCell *)[mytable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:tap.touchRow inSection:2]];
//        
//        NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
//        for (int i = 0; i < count; i++)
//        {
//            
//            NSString *url = [picArr[tap.touchRow-1] objectForKey:@"imgurlbig"];
//            MJPhoto *photo = [[[MJPhoto alloc] init]autorelease];
//            photo.url = [NSURL URLWithString:url];
//            photo.srcImageView = (UIImageView *)[temCell viewWithTag:2000];
//            [photos addObject:photo];
//        }
//        
//        
//        MJPhotoBrowser *browser = [[[MJPhotoBrowser alloc] init]autorelease];
//        browser.currentPhotoIndex = 0;
//        browser.photos = photos;
//        [browser show];
//    }
//    else
//    {
//       
//        NSMutableArray * imgArr = [[dataArray objectAtIndex:tap.touchRow-1] objectForKey:@"imgItems"];
//        
//        NSInteger count = imgArr.count;
//        GoodsReplyCell *temCell = (GoodsReplyCell *)[mytable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:tap.touchRow inSection:4]];
//        
//        NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
//        for (int i = 0; i < count; i++)
//        {
//           
//            NSString *url = [imgArr[i] objectForKey:@"imgurlbig"];
//            MJPhoto *photo = [[[MJPhoto alloc] init]autorelease];
//            photo.url = [NSURL URLWithString:url];
//            photo.srcImageView = (UIImageView *)[temCell viewWithTag:i+3000];
//            [photos addObject:photo];
//        }
//        
//        
//        MJPhotoBrowser *browser = [[[MJPhotoBrowser alloc] init]autorelease];
//        browser.currentPhotoIndex = tap.touchI;
//        browser.photos = photos;
//        [browser show];
//    }
//}


//- (void)gotoUserHome:(TapGR *)tap
//{
//    NSString * client_id = @"";
//    NSString * nickname = @"";
//    if (tap.touchI == 3)
//    {
//        client_id = [dataSource objectForKey:@"client_id"];
//        nickname = [dataSource objectForKey:@"nickname"];
//    }
//    else if (tap.touchI == 4)
//    {
//        client_id = [[dataArray objectAtIndex:tap.touchRow-1] objectForKey:@"client_id"];
//        nickname = [[dataArray objectAtIndex:tap.touchRow-1] objectForKey:@"nickname"];
//    }
//    if ([client_id isEqualToString:[[[XtomManager sharedManager] motherInfor] objectForKey:@"id"]])
//    {
//        InforVC *myVC = [[[InforVC alloc]init]autorelease];
//        [self.navigationController pushViewController:myVC animated:YES];
//    }
//    else
//    {
//        FriendHomeVC * detail = [[[FriendHomeVC alloc] init] autorelease];
//        detail.keyid = client_id;
//        detail.nickname = nickname;
//        [self.navigationController pushViewController:detail animated:YES];
//    }
//}
//

- (void)operateSuccess
{
    [self requestVirtualDetail];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 99 && buttonIndex == 1)
    {
        operType = 3;
        [self requestDeleteGoods];
    }
    else
    {
        if (buttonIndex == 1)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", [[[dataSource objectForKey:@"shopInfo"] objectAtIndex:0] objectForKey:@"tel"]]]];
        }
    }
}


//- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
//{

//    NSString *temStr = [[self.dataTopAd objectAtIndex:index] objectForKey:@"imgurlbig"];
//    imageView.tag = 1000+index;
//    [imageView setImage:[UIImage imageNamed:@"商城_默认广告页4.png"]];
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    imageView.clipsToBounds = YES;
//    if(![XtomFunction xfunc_check_strEmpty:temStr])
//    {
//        NSString *document = [NSString stringWithFormat:@"%@/%@",BB_CASH_DOCUMENT,BB_CASH_AVATAR];
//        [[XtomCashManager sharedManager] addImgToImgViewFromDocumentORURL:imageView document:document url:temStr];
//    }
//    
//}

//- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
//{
//    
//    int count = (int)[self.dataTopAd count];
//    
//    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
//    for (int i = 0; i<count; i++)
//    {
//    
//        NSString *url = [self.dataTopAd[i] objectForKey:@"imgurlbig"];
//        MJPhoto *photo = [[[MJPhoto alloc] init]autorelease];
//        photo.url = [NSURL URLWithString:url];
//        photo.srcImageView = (UIImageView*)[mytable viewWithTag:1000+index];
//        [photos addObject:photo];
//    }
//    
//    
//    MJPhotoBrowser *browser = [[[MJPhotoBrowser alloc] init]autorelease];
//    browser.currentPhotoIndex = index;
//    browser.photos = photos;
//    [browser show];
//}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section)
    {
        return 2;
    }
    if (1 == section)
    {
        if (!isParameterOpen)
        {
            return 2;
        }
        return 2+paraArray.count;
    }
    if (2 == section)
    {

        return 1+picArr.count;
    }
    if (3 == section)
    {
        if ([keytype integerValue] == 2)
        {
            return 0;
        }
        return 1;
    }
    if (4 == section)
    {
        NSInteger num = 0;
        if (dataArray.count >= 3)
        {
            num = 3;
        }
        else
        {
            num = dataArray.count;
        }
        return 1 + num;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            static NSString * cellID = @"RealityCell00";
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
            goodsDetailView.frame = CGRectMake(-0.5, 0, WIDTH+1, 80);
            [XtomFunction addbordertoView:goodsDetailView radius:0 width:0.5 color:BB_lineColor];
            [cell.contentView addSubview:goodsDetailView];
            
            
            UILabel * goodsNowPrice = [[[UILabel alloc] init] autorelease];
            goodsNowPrice.backgroundColor = [UIColor clearColor];
            goodsNowPrice.textAlignment = NSTextAlignmentLeft;
            goodsNowPrice.font = [UIFont systemFontOfSize:21];
            goodsNowPrice.textColor = BB_Button_Color;
            [goodsNowPrice setFrame:CGRectMake(15, 11.5, 100, 29)];
            goodsNowPrice.text = [NSString stringWithFormat:@"%@元", [dataSource objectForKey:@"price"]];
            [goodsDetailView addSubview:goodsNowPrice];
            
            NSMutableAttributedString * attrString =
            [[NSMutableAttributedString alloc] initWithString:goodsNowPrice.text];
            UIFont *smallFont = [UIFont systemFontOfSize:14];
            [attrString addAttribute:NSFontAttributeName value:smallFont range:[goodsNowPrice.text rangeOfString:@"元"]];
            goodsNowPrice.attributedText = attrString;
            
            
            UILabel * goodsOldPrice = [[[UILabel alloc] init] autorelease];
            goodsOldPrice.backgroundColor = [UIColor clearColor];
            goodsOldPrice.textAlignment = NSTextAlignmentLeft;
            goodsOldPrice.font = [UIFont systemFontOfSize:14];
            goodsOldPrice.textColor = [UIColor colorWithRed:165/255.f green:165/255.f blue:165/255.f alpha:1];
            [goodsOldPrice setFrame:CGRectMake(15 + 110, 19, 150, 21)];
            goodsOldPrice.text = [NSString stringWithFormat:@"%@元", [dataSource objectForKey:@"oldprice"]];
            NSUInteger length = [goodsOldPrice.text length];
            
            NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:goodsOldPrice.text];
            [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
            [goodsOldPrice setAttributedText:attri];
            [goodsDetailView addSubview:goodsOldPrice];
            
            
            UILabel * goodsName = [[[UILabel alloc] init] autorelease];
            goodsName.backgroundColor = [UIColor clearColor];
            goodsName.textAlignment = NSTextAlignmentLeft;
            goodsName.font = [UIFont systemFontOfSize:14];
            goodsName.textColor = [UIColor colorWithRed:151/255.f green:155/255.f blue:158/255.f alpha:1];
            [goodsName setFrame:CGRectMake(15, 41, WIDTH-94-15, 31)];
            goodsName.text = [dataSource objectForKey:@"name"];
            [goodsDetailView addSubview:goodsName];
            
            
            UIView * lineView = [[[UIView alloc] init] autorelease];
            lineView.frame = CGRectMake(WIDTH-49, 23, 0.5, 34);
            lineView.backgroundColor = [UIColor colorWithRed:210/255.f green:210/255.f blue:210/255.f alpha:1];
            [goodsDetailView addSubview:lineView];
            
            
            UIImageView * collectImage = [[[UIImageView alloc] init] autorelease];
            collectImage.frame = CGRectMake(WIDTH-35, 31, 19, 18);
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
            collectBtn.frame = CGRectMake(WIDTH-50, 12, 50, 40);
            [collectBtn addTarget:self action:@selector(collectClick) forControlEvents:UIControlEventTouchUpInside];
            [goodsDetailView addSubview:collectBtn];
            
           
            UIView * scanView = [[[UIView alloc] init] autorelease];
            scanView.frame = CGRectMake(0, 80, WIDTH, 43.5);
            scanView.backgroundColor = [UIColor whiteColor];
           
            [cell.contentView addSubview:scanView];
            NSArray * arr = @[@"已售", @"浏览", @"库存"];
            for (int i = 0; i < 3; i++)
            {
                UILabel * scanLabel = [[[UILabel alloc] init] autorelease];
                scanLabel.backgroundColor = [UIColor clearColor];
                scanLabel.font = [UIFont systemFontOfSize:17];
                scanLabel.textColor = [UIColor colorWithRed:165/255.f green:165/255.f blue:165/255.f alpha:1];
                [scanLabel setFrame:CGRectMake(15+((WIDTH-40)/3+5)*i, 0, (WIDTH-40)/3, 43.5)];
                switch (i)
                {
                    case 0:
                    {
                        scanLabel.text = [NSString stringWithFormat:@"%@ %@", arr[0], [dataSource objectForKey:@"paycount"]];
                        scanLabel.textAlignment = NSTextAlignmentLeft;
                    }
                        break;
                    case 1:
                    {
                        scanLabel.text = [NSString stringWithFormat:@"%@ %@", arr[1], [dataSource objectForKey:@"visitcount"]];
                        scanLabel.textAlignment = NSTextAlignmentCenter;
                    }
                        break;
                    case 2:
                    {
                        scanLabel.text = [NSString stringWithFormat:@"%@ %@", arr[2], [dataSource objectForKey:@"leftcount"]];
                        scanLabel.textAlignment = NSTextAlignmentRight;
                    }
                        break;
                    default:
                        break;
                }
                [scanView addSubview:scanLabel];
                
            }
            
            return cell;
        }
        static NSString * cellID = @"RealityCell01";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = BB_White_Color;
            
            
            UILabel * typeLabel = [[[UILabel alloc] init] autorelease];
            typeLabel.backgroundColor = [UIColor clearColor];
            typeLabel.textAlignment = NSTextAlignmentLeft;
            typeLabel.font = [UIFont systemFontOfSize:14];
            typeLabel.textColor = BB_Gray;
            [typeLabel setFrame:CGRectMake(15, 0, WIDTH-30, 43.5)];
            typeLabel.tag = 33;
            [cell.contentView addSubview:typeLabel];
            
            
            UIImageView * detailImage = [[[UIImageView alloc] init] autorelease];
            detailImage.frame = CGRectMake(80, 15, 11, 11);
            detailImage.tag = 44;
            detailImage.image = [UIImage imageNamed:@"邮"];
            [cell.contentView addSubview:detailImage];
            
            
            UILabel * rightLabel = [[[UILabel alloc] init] autorelease];
            rightLabel.backgroundColor = [UIColor clearColor];
            rightLabel.textAlignment = NSTextAlignmentLeft;
            rightLabel.font = [UIFont systemFontOfSize:14];
            rightLabel.textColor = BB_Gray;
            [rightLabel setFrame:CGRectMake(15, 0, WIDTH-30, 43.5)];
            rightLabel.tag = 55;
            [cell.contentView addSubview:rightLabel];
        }
        UILabel * typeLabel = (UILabel *)[cell viewWithTag:33];
        typeLabel.text = [NSString stringWithFormat:@"运费 %@", [dataSource objectForKey:@"expressfee"]];
        CGSize typeSize = [XtomFunction getSizeWithStrNo:typeLabel.text width:0 font:14];
        [typeLabel setFrame:CGRectMake(15, 0, typeSize.width, 43.5)];
        
        UIImageView * detailImage = (UIImageView *)[cell viewWithTag:44];
        detailImage.frame = CGRectMake(typeSize.width+30, 15, 11, 11);
        
        UILabel * rightLabel = (UILabel *)[cell viewWithTag:55];
        if (![XtomFunction xfunc_check_strEmpty:dataSource[@"expressforfree"]])
             {
                 rightLabel.text = [NSString stringWithFormat:@"满%@元，包邮", [dataSource objectForKey:@"expressforfree"]];
                 rightLabel.frame = CGRectMake(typeSize.width+46, 0, WIDTH-30, 43.5);
             }
        
        return cell;
        
    }
    if (1 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            static NSString * cellID = @"RealityCell02";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = BB_White_Color;
                
                
                UILabel * typeLabel = [[[UILabel alloc] init] autorelease];
                typeLabel.backgroundColor = [UIColor clearColor];
                typeLabel.textAlignment = NSTextAlignmentRight;
                typeLabel.font = [UIFont systemFontOfSize:14];
                typeLabel.textColor = BB_Graydark;
                [typeLabel setFrame:CGRectMake(WIDTH-115, 0, 100, 48)];
                typeLabel.tag = 3;
                [cell.contentView addSubview:typeLabel];
            }
            UILabel * typeLabel = (UILabel *)[cell viewWithTag:3];
            NSString *nstring = [dataSource objectForKey:@"typename"];
            NSArray * array = [nstring componentsSeparatedByString:@","];
            for (int i = 0; i < [array count]; i++) {
                NSLog(@"string:%@", [array objectAtIndex:i]);
            }
            typeLabel.text = [array lastObject];
            cell.textLabel.text = @"类型";
            return cell;
        }
        if (1 == indexPath.row)
        {
            static NSString * cellID = @"RealityCell03";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = BB_White_Color;
                cell.separatorInset = UIEdgeInsetsMake(0, WIDTH, 0, 0);
            }
            else
            {
                for(UIView *view in cell.contentView.subviews)
                {
                    [view removeFromSuperview];
                }
            }
            
            
            UILabel * parameterLabel = [[[UILabel alloc] init] autorelease];
            parameterLabel.backgroundColor = [UIColor clearColor];
            parameterLabel.textAlignment = NSTextAlignmentLeft;
            parameterLabel.font = [UIFont systemFontOfSize:14];
            parameterLabel.textColor = BB_Graydark;
            [parameterLabel setFrame:CGRectMake(15, 0, 100, 36)];
            parameterLabel.text = @"商品参数";
            [cell.contentView addSubview:parameterLabel];
            
            
            UIImageView * upOrDownImage = [[[UIImageView alloc] init] autorelease];
            upOrDownImage.frame = CGRectMake(WIDTH-27, 15, 12, 6);
            [cell.contentView addSubview:upOrDownImage];
            
            if (!isParameterOpen)
            {
                upOrDownImage.image = [UIImage imageNamed:@"列表合上.png"];
            }
            else
            {
                upOrDownImage.image = [UIImage imageNamed:@"列表展开.png"];
            }
            
            UIButton * upOrDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            upOrDownBtn.frame = CGRectMake(WIDTH-40, 0, 40, 36);
            [upOrDownBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            upOrDownBtn.tag = 6;
            [cell.contentView addSubview:upOrDownBtn];
            
            return cell;
        }
        static NSString * cellID = @"RealityCell04";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = BB_White_Color;
            cell.separatorInset = UIEdgeInsetsMake(0, WIDTH, 0, 0);
            
            
            UILabel * parameterName = [[[UILabel alloc] init] autorelease];
            parameterName.backgroundColor = [UIColor clearColor];
            parameterName.textAlignment = NSTextAlignmentLeft;
            parameterName.font = [UIFont systemFontOfSize:14];
            parameterName.textColor = BB_Gray;
            [parameterName setFrame:CGRectMake(15, 0, WIDTH-30, 20)];
            parameterName.tag = 921;
            parameterName.numberOfLines = 0;
            [cell.contentView addSubview:parameterName];
        }
        
        UILabel * parameterName = (UILabel *)[cell viewWithTag:921];
        NSMutableDictionary * temDict = [paraArray objectAtIndex:indexPath.row-2];
        parameterName.text = [NSString stringWithFormat:@"%@：%@", [temDict objectForKey:@"param_key"], [temDict objectForKey:@"param_value"]];
        CGSize titleLabelSize = [XtomFunction getSizeWithStrNo:parameterName.text width:WIDTH-30 font:14];
        parameterName.frame = CGRectMake(15, 5, WIDTH-30, titleLabelSize.height);
        NSMutableAttributedString *attrString =
        [[NSMutableAttributedString alloc] initWithString:parameterName.text];
        UIColor *rcolor = BB_Graydark;
        NSRange range = [parameterName.text rangeOfString:[NSString stringWithFormat:@"%@：", [temDict objectForKey:@"param_key"]]];
        [attrString addAttribute:NSForegroundColorAttributeName value:rcolor range:NSMakeRange(0, range.length)];
        parameterName.attributedText = attrString;
        
        return cell;
        
    }
    if (2 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            static NSString * cellID = @"RealityCell05";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = BB_White_Color;
                cell.separatorInset = UIEdgeInsetsMake(0, WIDTH, 0, 0);
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
            describeLabel.font = [UIFont systemFontOfSize:14];
            describeLabel.textColor = BB_Graydark;
            [describeLabel setFrame:CGRectMake(15, 7, 100, 33)];
            describeLabel.text = @"商品描述";
            [cell.contentView addSubview:describeLabel];
           
            UILabel * describeDetail = [[[UILabel alloc] init] autorelease];
            describeDetail.backgroundColor = [UIColor clearColor];
            describeDetail.textAlignment = NSTextAlignmentLeft;
            describeDetail.font = [UIFont systemFontOfSize:12];
            describeDetail.textColor = BB_Gray;
            [describeDetail setFrame:CGRectMake(15, 40, 100, 0)];
            describeDetail.text = [dataSource objectForKey:@"content"];
            describeDetail.numberOfLines = 0;
            CGSize size = [XtomFunction getSizeWithStrNo:describeDetail.text width:WIDTH-30 font:12];
            describeDetail.frame = CGRectMake(15, 40, WIDTH-30, size.height);
            describeDetail.tag = 4;
            [cell.contentView addSubview:describeDetail];
            
            return cell;
        }
        static NSString * cellID = @"RealityCell0500";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = BB_White_Color;
            cell.separatorInset = UIEdgeInsetsMake(0, WIDTH, 0, 0);
            
            UIImageView * detailImage = [[[UIImageView alloc] init] autorelease];
            detailImage.frame = CGRectMake(15, 0, WIDTH-30, 198);
            detailImage.contentMode = UIViewContentModeScaleAspectFill;
            detailImage.clipsToBounds = YES;
            detailImage.tag = 2000;
            [cell.contentView addSubview:detailImage];
            detailImage.userInteractionEnabled = YES;
        }
        
        UIImageView * detailImage = (UIImageView *)[cell viewWithTag:2000];
        NSMutableDictionary * temDict = [picArr objectAtIndex:indexPath.row-1];
        NSString *downavatar = [temDict objectForKey:@"imgurlbig"];;
        detailImage.image = [UIImage imageNamed:@"商城_默认广告页4.png"];
        CGFloat width = WIDTH-30;
        CGFloat height = 100;
        if (![XtomFunction xfunc_check_strEmpty:[temDict objectForKey:@"imgwidth"]])
        {
            width = [[temDict objectForKey:@"imgwidth"] floatValue];
        }
        if (![XtomFunction xfunc_check_strEmpty:[temDict objectForKey:@"imgheight"]])
        {
            height = [[temDict objectForKey:@"imgheight"] floatValue];
        }
        detailImage.frame = CGRectMake(15, 0, WIDTH-30, (WIDTH-30)*height/width);
        if(![XtomFunction xfunc_check_strEmpty:downavatar])
        {
            NSString *document = [NSString stringWithFormat:@"%@/%@",BB_CASH_DOCUMENT,BB_CASH_AVATAR];
            [[XtomCashManager sharedManager] addImgToImgViewFromDocumentORURL:detailImage document:document url:downavatar];
        }
        
//        TapGR *temTap = [[[TapGR alloc] initWithTarget:self action:@selector(handlemySingleTap:)]autorelease];
//        [detailImage addGestureRecognizer:temTap];
//        temTap.numberOfTapsRequired = 1;
//        temTap.numberOfTouchesRequired = 1;
//        temTap.touchRow = indexPath.row;
//        temTap.touchI = indexPath.section;
//        temTap.delegate = self;
        
        return cell;
    }
    if (3 == indexPath.section)
    {
        static NSString * cellID = @"RealityCell06";
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
        NSMutableDictionary * temDic = [[dataSource objectForKey:@"shopInfo"] objectAtIndex:0];
        
        UIImageView * logoImage = [[[UIImageView alloc] init] autorelease];
        logoImage.userInteractionEnabled = YES;
        [XtomFunction addbordertoView:logoImage radius:0 width:0.5 color:BB_lineColor];
        logoImage.frame = CGRectMake(12, 8, 43, 43);
        logoImage.contentMode = UIViewContentModeScaleAspectFill;
        logoImage.clipsToBounds=YES;
        [cell.contentView addSubview:logoImage];
        NSString *avatar = [temDic objectForKey:@"shop_avatar"];
        logoImage.image = [UIImage imageNamed:@"商城_默认广告页3.png"];
        if(![XtomFunction xfunc_check_strEmpty:avatar])
        {
            NSString *document = [NSString stringWithFormat:@"%@/%@",BB_CASH_DOCUMENT,BB_CASH_AVATAR];
            [[XtomCashManager sharedManager] addImgToImgViewFromDocumentORURL:logoImage document:document url:avatar];
        }
        
//        logoImage.userInteractionEnabled = YES;
//        TapGR *temTap = [[[TapGR alloc] initWithTarget:self action:@selector(gotoUserHome:)]autorelease];
//        [logoImage addGestureRecognizer:temTap];
//        temTap.numberOfTapsRequired = 1;
//        temTap.numberOfTouchesRequired = 1;
//        temTap.touchRow = 0;
//        temTap.touchI = 3;
//        temTap.delegate = self;
        
        UILabel * goodsName = [[[UILabel alloc] init] autorelease];
        goodsName.backgroundColor = [UIColor clearColor];
        goodsName.textAlignment = NSTextAlignmentLeft;
        goodsName.font = [UIFont systemFontOfSize:17];
        goodsName.textColor = BB_Graydark;
        [goodsName setFrame:CGRectMake(65, 6.5, WIDTH-65-12, 24)];
        goodsName.text = [temDic objectForKey:@"shop_name"];
        [cell.contentView addSubview:goodsName];
        
        UILabel * collectNum = [[[UILabel alloc] init] autorelease];
        collectNum.backgroundColor = [UIColor clearColor];
        collectNum.textAlignment = NSTextAlignmentLeft;
        collectNum.font = [UIFont systemFontOfSize:15];
        collectNum.textColor = BB_Button_Color;
        [collectNum setFrame:CGRectMake(65, 31, WIDTH-65-12, 20)];
        collectNum.text = [NSString stringWithFormat:@"%@人收藏", [temDic objectForKey:@"collectcount"]];
        [cell.contentView addSubview:collectNum];
        NSMutableAttributedString *attrString =
        [[NSMutableAttributedString alloc] initWithString:collectNum.text];
        UIColor *rcolor = [UIColor grayColor];
        [attrString addAttribute:NSForegroundColorAttributeName value:rcolor range:[collectNum.text rangeOfString:@"人收藏"]];
        collectNum.attributedText = attrString;
        
        UIButton * allGoodsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [allGoodsBtn setFrame:CGRectMake((WIDTH-291)/3, 65, 145.5, 33.5)];
        allGoodsBtn.backgroundColor = BB_White_Color;
        allGoodsBtn.tag = 8;
        [allGoodsBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [XtomFunction addbordertoView:allGoodsBtn radius:0 width:0.5 color:BB_Gray];
        [cell.contentView addSubview:allGoodsBtn];
        
        UIImageView * allGoodsImg = [[[UIImageView alloc]init]autorelease];
        [allGoodsImg setFrame:CGRectMake(37, 10.5, 17.5, 12.5)];
        allGoodsImg.contentMode = UIViewContentModeScaleAspectFill;
        [allGoodsImg setClipsToBounds:YES];
        allGoodsImg.image = [UIImage imageNamed:@"全部商品"];
        [allGoodsBtn addSubview:allGoodsImg];
        
        UILabel * allGoodsLabel = [[[UILabel alloc]init]autorelease];
        allGoodsLabel.backgroundColor = [UIColor clearColor];
        allGoodsLabel.textAlignment = NSTextAlignmentCenter;
        allGoodsLabel.font = [UIFont systemFontOfSize:12];
        allGoodsLabel.textColor = BB_Blake;
        [allGoodsLabel setFrame:CGRectMake(54.5, 0, 56, 33.5)];
        allGoodsLabel.text = @"全部商品";
        [allGoodsBtn addSubview:allGoodsLabel];
        
        
        UIButton * storeInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [storeInBtn setFrame:CGRectMake((WIDTH-291)/3*2 + 145.5, 65, 145.5, 33.5)];
        storeInBtn.backgroundColor = BB_White_Color;
        storeInBtn.tag = 9;
        [storeInBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [XtomFunction addbordertoView:storeInBtn radius:0 width:0.5 color:BB_Gray];
        [cell.contentView addSubview:storeInBtn];
        
        UIImageView * storeInImg = [[[UIImageView alloc]init]autorelease];
        [storeInImg setFrame:CGRectMake(40, 10, 14, 14)];
        storeInImg.contentMode = UIViewContentModeScaleAspectFill;
        [storeInImg setClipsToBounds:YES];
        storeInImg.image = [UIImage imageNamed:@"进入店铺"];
        [storeInBtn addSubview:storeInImg];
        
        UILabel * storeInLabel = [[[UILabel alloc]init]autorelease];
        storeInLabel.backgroundColor = [UIColor clearColor];
        storeInLabel.textAlignment = NSTextAlignmentCenter;
        storeInLabel.font = [UIFont systemFontOfSize:12];
        storeInLabel.textColor = BB_Blake;
        [storeInLabel setFrame:CGRectMake(54, 0, 58, 33.5)];
        storeInLabel.text = @"进入店铺";
        [storeInBtn addSubview:storeInLabel];
        
        
        UIView * lineView = [[[UIView alloc] init] autorelease];
        lineView.frame = CGRectMake(0, 108.5, WIDTH, 0.5);
        lineView.backgroundColor = BB_BordLine_Color;
//        [cell.contentView addSubview:lineView];
    
        
        UILabel * telLabel = [[[UILabel alloc] init] autorelease];
        telLabel.backgroundColor = [UIColor clearColor];
        telLabel.textAlignment = NSTextAlignmentLeft;
        telLabel.font = [UIFont systemFontOfSize:14];
        telLabel.textColor = BB_Graydark;
        [telLabel setFrame:CGRectMake(11, 109, WIDTH-80-11, 49)];
        telLabel.text = [NSString stringWithFormat:@"咨询电话：%@", [temDic objectForKey:@"tel"]];
        [cell.contentView addSubview:telLabel];
        
        UIView * lineView1 = [[[UIView alloc] init] autorelease];
        lineView1.frame = CGRectMake(WIDTH-70.5, 124.5, 0.5, 17);
        lineView1.backgroundColor = BB_BordLine_Color;
        [cell.contentView addSubview:lineView1];
        
        UIImageView * telImg = [[[UIImageView alloc]init]autorelease];
        [telImg setFrame:CGRectMake(WIDTH-45, 120, 20.5, 26)];
        telImg.image = [UIImage imageNamed:@"商家_电话图标"];
        [cell.contentView addSubview:telImg];
        
        UIButton * telBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [telBtn setFrame:CGRectMake(WIDTH-70, 109, 70, 49)];
        [telBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        telBtn.tag = 7;
        [cell.contentView addSubview:telBtn];
        
        return cell;
    }
    if (4 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            static NSString * cellID = @"RealityCell07";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = BB_White_Color;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            else
            {
                for(UIView *view in cell.contentView.subviews)
                {
                    [view removeFromSuperview];
                }
            }
            
            UILabel * evaluateLabel = [[[UILabel alloc] init] autorelease];
            evaluateLabel.backgroundColor = [UIColor clearColor];
            evaluateLabel.textAlignment = NSTextAlignmentLeft;
            evaluateLabel.font = [UIFont systemFontOfSize:14];
            evaluateLabel.textColor = BB_Graydark;
            [evaluateLabel setFrame:CGRectMake(15, 6, 100, 30)];
            evaluateLabel.text = @"评价";
            [cell.contentView addSubview:evaluateLabel];
           
            NSInteger starNum = [[dataSource objectForKey:@"stars"] integerValue];
            for (int i = 0; i < 5; i++)
            {
                UIImageView * star = [[[UIImageView alloc] init] autorelease];
                star.image = [UIImage imageNamed:@"store_reply_star_nor.png"];
                star.frame = CGRectMake(15 + i * 15, 36, 14, 12.5);
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
            [starNumLabel setFrame:CGRectMake(90, 36, 100, 12.5)];
            starNumLabel.text = [NSString stringWithFormat:@"%@.0", [dataSource objectForKey:@"stars"]];
            [cell.contentView addSubview:starNumLabel];
            return cell;
        }
        static NSString * cellID = @"RealityCell08";
        GoodsReplyCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil)
        {
//            cell = [[[GoodsReplyCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.backgroundColor = BB_White_Color;
        }
        
        NSMutableDictionary *temDic = [dataArray objectAtIndex:indexPath.row-1];

        NSString *downavatar = [temDic objectForKey:@"avatar"];
        cell.userHeaderImage.image = [UIImage imageNamed:@"商城_默认广告页1.png"];
        if(![XtomFunction xfunc_check_strEmpty:downavatar])
        {
            NSString *document = [NSString stringWithFormat:@"%@/%@",BB_CASH_DOCUMENT,BB_CASH_AVATAR];
            [[XtomCashManager sharedManager] addImgToImgViewFromDocumentORURL:cell.userHeaderImage document:document url:downavatar];
        }
        
//        cell.userHeaderImage.userInteractionEnabled = YES;
//        TapGR *temTap = [[[TapGR alloc] initWithTarget:self action:@selector(gotoUserHome:)]autorelease];
//        [cell.userHeaderImage addGestureRecognizer:temTap];
//        temTap.numberOfTapsRequired = 1;
//        temTap.numberOfTouchesRequired = 1;
//        temTap.touchRow = indexPath.row;
//        temTap.touchI = indexPath.section;
//        temTap.delegate = self;
        
        [cell.userNameLabel setText:[temDic objectForKey:@"nickname"]];
        
        cell.publishTimeLabel.text = [XtomFunction getTimeFromDate:[temDic objectForKey:@"regdate"]];
        for (int i = 0; i< cell.starArray.count; i++)
        {
            UIImageView * image = [cell.starArray objectAtIndex:i];
            image.frame = CGRectMake(WIDTH-67.5 + i * 12, 16.5, 11, 10);
            if (i < [[temDic objectForKey:@"stars"] intValue])
            {
                image.image = [UIImage imageNamed:@"store_replylist_star_sel.png"];
            }
            else
            {
                image.image = [UIImage imageNamed:@"store_replylist_star_nor.png"];
            }
        }
        
        NSString * blogName = [temDic objectForKey:@"content"];
        cell.commentDetailLabel.text = blogName;
        
        CGSize myblogSize = [XtomFunction getSizeWithStrNo:blogName width:WIDTH-63 font:16];
        cell.commentDetailLabel.frame = CGRectMake(53, 53, WIDTH-63, myblogSize.height);
        NSMutableArray * imgArr = [temDic objectForKey:@"imgItems"];
        for (int i = 0; i < cell.imageArr.count; i++)
        {
            if (i < imgArr.count)
            {
                UIImageView * image = [cell.imageArr objectAtIndex:i];
                image.hidden = NO;
                image.frame = CGRectMake(15+73*i, 53 + myblogSize.height + 10, 70, 62);
                image.userInteractionEnabled = YES;
                image.tag = 3000 + i;
                
//                TapGR *temTap = [[[TapGR alloc] initWithTarget:self action:@selector(handlemySingleTap:)]autorelease];
//                [image addGestureRecognizer:temTap];
//                temTap.numberOfTapsRequired = 1;
//                temTap.numberOfTouchesRequired = 1;
//                temTap.touchRow = indexPath.row;
//                temTap.touchI = i;
//                temTap.delegate = self;
                
                NSString *downavatar = [imgArr[i] objectForKey:@"imgurl"];
                if(![XtomFunction xfunc_check_strEmpty:downavatar])
                {
                    NSString *document = [NSString stringWithFormat:@"%@/%@",BB_CASH_DOCUMENT,BB_CASH_AVATAR];
                    [[XtomCashManager sharedManager] addImgToImgViewFromDocumentORURL:image document:document url:downavatar];
                }
            }
            else
            {
                UIImageView * image = [cell.imageArr objectAtIndex:i];
                image.hidden = YES;
            }
        }
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
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            return 123.5;
        }
        return 43.5;
    }
    if (1 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            return 48;
        }
        if (1 == indexPath.row)
        {
            return 36;
        }
        if (!isParameterOpen)
        {
            return 0;
        }
        else
        {
            NSMutableDictionary * temDict = [paraArray objectAtIndex:indexPath.row - 2];
            
            NSString * para = [NSString stringWithFormat:@"%@：%@", [temDict objectForKey:@"param_key"], [temDict objectForKey:@"param_value"]];
            CGSize titleLabelSize = [XtomFunction getSizeWithStrNo:para width:WIDTH-30 font:14];
            return titleLabelSize.height + 10;
        }
    }
    if (2 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            CGSize size = [XtomFunction getSizeWithStrNo:dataSource[@"content"] width:WIDTH-30 font:12];
            return 40+size.height+10;
        }
        CGFloat width = WIDTH-30;
        CGFloat height = 100;
        NSMutableDictionary * temDict = picArr[indexPath.row-1];
        if (![XtomFunction xfunc_check_strEmpty:[temDict objectForKey:@"imgwidth"]])
        {
            width = [[temDict objectForKey:@"imgwidth"] floatValue];
        }
        if (![XtomFunction xfunc_check_strEmpty:[temDict objectForKey:@"imgheight"]])
        {
            height = [[temDict objectForKey:@"imgheight"] floatValue];
        }
        return (WIDTH-30)*height/width+10;
    }
    if (3 == indexPath.section)
    {
        return 158;
    }
    if (4 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            return 60;
        }
        NSMutableDictionary * temDict = [dataArray objectAtIndex:indexPath.row-1];
        CGSize myblogSize = [XtomFunction getSizeWithStrNo:[temDict objectForKey:@"content"] width:WIDTH-63 font:16];
        NSMutableArray * imgArr = [temDict objectForKey:@"imgItems"];
        if (imgArr.count == 0)
        {
            return 53+myblogSize.height+10;
        }
        return 53+myblogSize.height+10 + 62 + 10;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (4 == indexPath.section && 0 == indexPath.row)
    {
//        EvaluateVC * evaluate = [[[EvaluateVC alloc] init] autorelease];
//        evaluate.keyid = self.keyid;
//        evaluate.starNum = [dataSource objectForKey:@"stars"];
//        [self.navigationController pushViewController:evaluate animated:YES];
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
            [dic setObject:@"2" forKey:@"keytype"];
            [dic setObject:@"1" forKey:@"oper"];
        }
            break;
        case 2:
        {
            [dic setObject:@"2" forKey:@"keytype"];
            [dic setObject:@"2" forKey:@"oper"];
        }
            break;
        default:
            break;
    }
    [dic setObject:operId forKey:@"keyid"];
//    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_FOLLOW_COLLECT_OPERATOR] target:self selector:@selector(responseOperator:) parameter:dic];
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


- (void)requestAddtoCart
{
    NSString *token = [[XtomManager sharedManager] userToken];
    
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token forKey:@"token"];
    [dic setObject:self.keyid forKey:@"keyid"];
    [dic setObject:@"1" forKey:@"buycount"];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_CART_ADD] target:self selector:@selector(responseAddtoCart:) parameter:dic];
}

- (void)responseAddtoCart:(NSDictionary *)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        [XtomFunction openIntervalHUDOK:@"已成功加入购物车" view:self.view];
    }
    else
    {
        if([info objectForKey:@"msg"])
        {
            [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:self.view];
        }
    }
}


- (void)requestVirtualDetail
{
//    NSString *token = [[XtomManager sharedManager] userToken];
//    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
//    [dic setObject:token forKey:@"token"];
//    [dic setObject:keyid forKey:@"id"];
//    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_BLOG_GET] target:self selector:@selector(responseVirtualDetail:) parameter:dic];
}

- (void)responseVirtualDetail:(NSDictionary *)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        if(![XtomFunction xfunc_check_strEmpty:[info objectForKey:@"infor"]])
        {
            if (!dataSource)
            {
                self.dataSource = [[[NSMutableDictionary alloc]init]autorelease];
                self.dataTopAd = [[[NSMutableArray alloc] init] autorelease];
                self.paraArray = [[[NSMutableArray alloc] init] autorelease];
                self.picArr = [[[NSMutableArray alloc] init] autorelease];
            }
            [dataSource removeAllObjects];
            [dataTopAd removeAllObjects];
            [paraArray removeAllObjects];
            [picArr removeAllObjects];
            NSDictionary *temDict = [[info objectForKey:@"infor"] objectAtIndex:0];
            for(NSString *key in temDict.allKeys)
            {
                NSString *value = [temDict objectForKey:key];
                if(![XtomFunction xfunc_check_strEmpty:value])
                {
                    [dataSource setObject:value forKey:key];
                }
            }
            NSString * val1 = [[[info objectForKey:@"infor"] objectAtIndex:0] objectForKey:@"blogParams"];
            if (![XtomFunction xfunc_check_strEmpty:val1])
            {
                
                NSArray * temArr = [dataSource objectForKey:@"blogParams"];
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
                    [self.paraArray addObject:dict];
                }
            }
            
            NSString * val = [[[info objectForKey:@"infor"] objectAtIndex:0] objectForKey:@"blogImgItems"];
            if (![XtomFunction xfunc_check_strEmpty:val])
            {
                
                NSArray * temArr = [dataSource objectForKey:@"blogImgItems"];
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
                    [self.dataTopAd addObject:dict];
                }
                if (self.dataTopAd != 0)
                {
//                    [player initWithCount:dataTopAd.count delegate:self];
//                    if (dataTopAd.count == 1)
//                    {
//                        player.hidePageControl = YES;
//                    }
//                    else
//                    {
//                        player.hidePageControl = NO;
//                    }
                }
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
            
            
            NSString * val2 = dataSource[@"imgItems"];
            if (![XtomFunction xfunc_check_strEmpty:val2])
            {
                NSArray * temArr = dataSource[@"imgItems"];
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
                    if ([XtomFunction xfunc_check_strEmpty:dict[@"imgwidth"]] || [XtomFunction xfunc_check_strEmpty:dict [@"imgheight"]])
                    {
                        NSString * url = dict[@"imgurlbig"];
                        UIImage * image = [XtomFunction getImageFromURL:url];
                        [dict setValue:[NSString stringWithFormat:@"%f", image.size.width] forKey:@"imgwidth"];
                        [dict setValue:[NSString stringWithFormat:@"%f", image.size.height] forKey:@"imgheight"];
                    }
                    [self.picArr addObject:dict];
                }
            }
        }
        [self reShowView];
        [self setBuyView];
        [self requestReplyList];
    }
    else
    {
        if ([[info objectForKey:@"error_code"]integerValue] == 404)
        {
            [mytable setHidden:YES];
            [XtomFunction openIntervalHUD:@"很抱歉，该商品不存在" view:self.view];
            [self performSelector:@selector(gotoBack) withObject:nil afterDelay:1.2];
            
        }
        else
        {
            if([info objectForKey:@"msg"])
            {
                [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:nil];
            }
        }
    }
}


- (void)requestReplyList
{
    NSString *token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token forKey:@"token"];
    [dic setObject:@"2" forKey:@"keytype"];
    [dic setObject:keyid forKey:@"keyid"];
    NSLog(@"%@",keyid);
    
    [dic setObject:@"0" forKey:@"page"];
//    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_REPLY_LIST] target:self selector:@selector(responseReplyList:) parameter:dic];
}

- (void)responseReplyList:(NSDictionary *)info
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


- (void)requestDeleteGoods
{
    NSString *token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token forKey:@"token"];
    switch (operType)
    {
        case 3:
        {
            [dic setObject:@"1" forKey:@"keytype"];
        }
            break;
        case 4:
        {
            [dic setObject:@"2" forKey:@"keytype"];
        }
            break;
        case 5:
        {
            [dic setObject:@"4" forKey:@"keytype"];
        }
            break;
        case 6:
        {
            [dic setObject:@"5" forKey:@"keytype"];
        }
            break;
        case 7:
        {
            [dic setObject:@"3" forKey:@"keytype"];
        }
            break;
        default:
            break;
    }
    
    [dic setObject:keyid forKey:@"id"];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_BLOG_SAVEOPERATE] target:self selector:@selector(responseDeleteGoods:) parameter:dic];
}

- (void)responseDeleteGoods:(NSDictionary *)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        UIImageView * consultImg = (UIImageView *)[self.view viewWithTag:22];
        switch (operType)
        {
            case 3:
            {
                [XtomFunction openIntervalHUD:@"删除商品成功" view:nil];
                [self leftBtnPressed];
            }
                break;
            case 4:
            {
                [consultImg setImage:[UIImage imageNamed:@"取消推荐"]];
                [XtomFunction openIntervalHUD:@"设置推荐成功" view:nil];
            }
                break;
            case 5:
            {
                [XtomFunction openIntervalHUD:@"上架商品成功" view:nil];
                isOutdate = NO;
                self.outdateImg.image = [UIImage imageNamed:@"下架商品图标.png"];
            }
                break;
            case 6:
            {
                [XtomFunction openIntervalHUD:@"下架商品成功" view:nil];
                isOutdate = YES;
                self.outdateImg.image = [UIImage imageNamed:@"上架商品图标.png"];
            }
                break;
            case 7:
            {
                [consultImg setImage:[UIImage imageNamed:@"设置推荐图标"]];
                [XtomFunction openIntervalHUD:@"取消推荐成功" view:nil];
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
            [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:self.view];
        }
    }
}


-(void)gotoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)reShowView
{
    [mytable reloadData];
}

- (void)refresh
{
    [self requestVirtualDetail];
}

@end
