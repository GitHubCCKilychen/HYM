//
//  CategoryVC.m
//  PingChuan
//
//  Created by pengli on 15/9/21.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "CategoryVC.h"
//#import "EvaluateVC.h"
#import "BBButton.h"
#import "CategoryGoodsCell.h"
#import "TapGR.h"
#import "RealityDetailVC.h"
#import "SearchHistoryVC.h"
//#import "WebVC.h"
//#import "LCPanNavigationController.h"
#import "StoreDetailVC.h"

@interface CategoryVC ()<UITextFieldDelegate, UIGestureRecognizerDelegate>
{
    BOOL isDelete;
    BOOL isFiltrate;
    MBProgressHUD * waitMB;
    NSInteger currentPage;
    BOOL isEnd;
    NSInteger ordertype;
    NSInteger orderby;
}
@property (nonatomic, retain) UIView * searchBackView;
@property (nonatomic, retain) UIView * searchBackView2;
@property (nonatomic, retain) UILabel * searchTextField;
@property (nonatomic, retain) UITextField * searchTextField2;
@property (nonatomic, retain) NSArray * imageArr0;
@property (nonatomic, retain) UIImageView * adImage;
@property (nonatomic, retain) UITableView * firstTable;
@property (nonatomic, retain) NSMutableArray * firstArr;
@property (nonatomic, retain) UITableView * secondTable;
@property (nonatomic, retain) NSMutableArray * secondArr;
@property (nonatomic, retain) UIView * displayView;
@property (nonatomic, retain) UIView * filtrateView;
@property (nonatomic, retain) UITextField * leftPrice;
@property (nonatomic, retain) UITextField * rightPrice;
@property (nonatomic, retain) UIView * surePriceView;
@property (nonatomic, retain) UIView * priceDisplayView;
@property (nonatomic, retain) UIButton * cancelBtn;
@property (nonatomic, retain) NSMutableArray * dataArray;
@property (nonatomic, retain) NSMutableArray * dataTopAd;

@end

@implementation CategoryVC
@synthesize searchBackView;
@synthesize searchBackView2;
@synthesize searchTextField;
@synthesize searchTextField2;
@synthesize imageArr0;
@synthesize adImage;
@synthesize firstTable;
@synthesize firstArr;
@synthesize secondTable;
@synthesize secondArr;
@synthesize displayView;
@synthesize filtrateView;
@synthesize leftPrice;
@synthesize rightPrice;
@synthesize surePriceView;
@synthesize priceDisplayView;
@synthesize cancelBtn;
@synthesize dataArray;
@synthesize dataTopAd;

@synthesize keytype;
@synthesize isFirst;
@synthesize isSecond;
@synthesize keyid;
@synthesize searchKey;
@synthesize typeName;

- (void)dealloc
{
    [searchBackView release]; searchBackView = nil;
    [searchBackView2 release]; searchBackView2 = nil;
    [searchTextField release]; searchTextField = nil;
    [searchTextField2 release]; searchTextField2 = nil;
    [imageArr0 release]; imageArr0 = nil;
    [adImage release]; adImage = nil;
    [firstTable release]; firstTable = nil;
    [firstArr release]; firstArr = nil;
    [secondTable release]; secondTable = nil;
    [secondArr release]; secondArr = nil;
    [displayView release]; displayView = nil;
    [filtrateView release]; filtrateView = nil;
    [leftPrice release]; leftPrice = nil;
    [rightPrice release]; rightPrice = nil;
    [surePriceView release]; surePriceView = nil;
    [priceDisplayView release]; priceDisplayView = nil;
    [cancelBtn release]; cancelBtn = nil;
    [dataArray release]; dataArray = nil;
    [dataTopAd release]; dataTopAd = nil;
    
    [keytype release]; keytype = nil;
    [keyid release]; keyid = nil;
    [searchKey release]; searchKey = nil;
    [typeName release]; typeName = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BUY_SUCCESS_XUNI object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BUY_SUCCESS_SHIQU object:nil];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([keytype integerValue] == 1)
    {
        [searchBackView setHidden:NO];
    }
    if ([keytype integerValue] == 2)
    {
        [searchBackView2 setHidden:NO];
        [cancelBtn setHidden:NO];
    }
    if ([keytype integerValue] == 3)
    {
       // [self.navigationItem setNewTitle:@"全部商品"];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(infoAction:) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeGoodsState)
                                                 name:BUY_SUCCESS_XUNI
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeGoodsState)
                                                 name:BUY_SUCCESS_SHIQU
                                               object:nil];
}

- (void)changeGoodsState
{
    [self refresh];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if ([keytype integerValue] == 1)
    {
        [searchBackView setHidden:YES];
    }
    if ([keytype integerValue] == 2)
    {
        [searchBackView2 setHidden:YES];
        [cancelBtn setHidden:YES];
    }
    [super viewWillDisappear:animated];
    
    [self.searchBackView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadSet];
    [self loadData];
}

- (void)loadSet
{
////    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
////    [self.navigationController.navigationBar setBarTintColor:NavigationColor];
    [self.view setBackgroundColor:BB_Back_Color_Here];

    if ([keytype integerValue] == 3)
    {
        [self.navigationItem setNewTitle:@"全部商品"];
        [self.navigationItem setLeftItemWithTarget:self action:@selector(leftBtnPressed) image:@"common_return.png" imageH:@"common_return.png"];
        [self.navigationItem setRightItemWithTarget:self action:@selector(rightBtnPressed) image:@"common_search_sel.png" imageH:@"common_search_sel.png"];
        isDelete = YES;
    }
    else
    {
        if ([keytype integerValue] == 2)
        {
            [self.navigationItem setLeftItemWithTarget:self action:@selector(leftBtnPressed) title:@""];
            [self.navigationItem setRightItemWithTarget:self action:@selector(leftBtnPressed) title:@""];
            isDelete = YES;
            
            
            self.searchBackView2 = [[[UIView alloc] init] autorelease];
            searchBackView2.frame = CGRectMake(10, 6.5, WIDTH-65, 29);
            searchBackView2.backgroundColor = [UIColor whiteColor];
            [XtomFunction addbordertoView:searchBackView2 radius:0 width:0.5 color:BB_Gray];
            [self.navigationController.navigationBar addSubview:searchBackView2];
            
            UIImageView * searchImg = [[[UIImageView alloc] init] autorelease];
            searchImg.frame = CGRectMake(9, 7, 15, 14.5);
            searchImg.image = [UIImage imageNamed:@"common_search.png"];
            [searchBackView2 addSubview:searchImg];
            
            
            self.searchTextField2 = [[[UITextField alloc] init] autorelease];
            searchTextField2.backgroundColor = [UIColor clearColor];
            searchTextField2.textAlignment = NSTextAlignmentLeft;
            searchTextField2.textColor = [UIColor blackColor];
            searchTextField2.font = [UIFont systemFontOfSize:15];
            searchTextField2.frame = CGRectMake(30, 0, WIDTH-150, 29);
            searchTextField2.placeholder = @"请输入商品名称";
            searchTextField2.delegate = self;
            searchTextField2.returnKeyType = UIReturnKeySearch;
            searchTextField2.clearButtonMode = UITextFieldViewModeWhileEditing;
            searchTextField2.keyboardType = UIKeyboardTypeDefault;
            searchTextField2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            [searchBackView2 addSubview:searchTextField2];
            self.searchTextField2.text = searchKey;
            
            self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            cancelBtn.frame = CGRectMake(WIDTH-55, 0, 55, 44);
            [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
            [cancelBtn setTitleColor:BB_Button_Color forState:UIControlStateNormal];
            cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            [cancelBtn addTarget:self action:@selector(rightBtnPressed) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationController.navigationBar addSubview:cancelBtn];
        }
        else
        {
//            [self.navigationItem setLeftItemWithTarget:self action:@selector(leftBtnPressed) image:@"common_return.png" imageH:@"common_return.png"];
//            [self.navigationItem setRightItemWithTarget:self action:@selector(rightBtnPressed) image:@"common_filtrate.png" imageH:@"common_filtrate.png"];
//
            self.searchBackView = [[[UIView alloc] init] autorelease];
            searchBackView.frame = CGRectMake(50, 6.5, WIDTH-110, 29);
            searchBackView.backgroundColor = [UIColor whiteColor];
            [XtomFunction addbordertoView:searchBackView radius:0 width:0.5 color:BB_Gray];
            [self.navigationController.navigationBar addSubview:searchBackView];
            
            UIImageView * searchImg = [[[UIImageView alloc] init] autorelease];
            searchImg.frame = CGRectMake(9, 7, 15, 14.5);
            searchImg.image = [UIImage imageNamed:@"common_search.png"];
            [searchBackView addSubview:searchImg];
            
//
            self.searchTextField = [[[UILabel alloc] init] autorelease];
            searchTextField.backgroundColor = [UIColor clearColor];
            searchTextField.textAlignment = NSTextAlignmentLeft;
            searchTextField.textColor = [UIColor blackColor];
            searchTextField.font = [UIFont systemFontOfSize:15];
            searchTextField.frame = CGRectMake(30, 0, WIDTH-150, 29);
            searchTextField.text = @"请输入商品名称";
            searchTextField.textColor = BB_Graylight;
            [searchBackView addSubview:searchTextField];
            
            UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            searchBtn.frame = CGRectMake(0, 0, WIDTH-110, 29);
            [searchBtn addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [searchBackView addSubview:searchBtn];
        }
    }
    
    
    UIView * typeView = [[[UIView alloc] init] autorelease];
    typeView.frame = CGRectMake(0, 0, WIDTH, 45);
    typeView.backgroundColor = [UIColor whiteColor];
    [XtomFunction addbordertoView:typeView radius:0 width:0.5 color:BB_BordLine_Color];
    [self.view addSubview:typeView];
    
    
    UIButton * typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [typeBtn setFrame:CGRectMake(0, 0, 90, 45)];
    [typeBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    typeBtn.tag = 1;
    [typeView addSubview:typeBtn];
    [XtomFunction addbordertoView:typeBtn radius:0 width:0.5 color:BB_Graylight];
    
    
    UILabel * typeLabel = [[[UILabel alloc] init] autorelease];
    typeLabel.backgroundColor = [UIColor clearColor];
    typeLabel.textAlignment = NSTextAlignmentCenter;
    typeLabel.font = [UIFont systemFontOfSize:12];
    typeLabel.textColor = BB_Graydark;
    [typeLabel setFrame:CGRectMake(12, 0, 63, 44)];
    typeLabel.tag = 2;
    typeLabel.text = typeName;
    [typeBtn addSubview:typeLabel];
    
    
    UIImageView * typeImage = [[[UIImageView alloc] init] autorelease];
    typeImage.frame = CGRectMake(79.5, 20.5, 5.5, 5.5);
    typeImage.image = [UIImage imageNamed:@"类型_下角标.png"];
    [typeBtn addSubview:typeImage];
    
   
    self.imageArr0 = @[@"综合", @"价格", @"销量"];
    
    for (int i = 0; i < 3; i++)
    {
        
        UIButton * typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [typeBtn setFrame:CGRectMake((WIDTH-90)/3*i+90, 0, (WIDTH-90)/3, 44)];
        [typeBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        typeBtn.tag = i+11;
        [typeView addSubview:typeBtn];
        [typeBtn setSelected:NO];
        
        
        UILabel * typeLabel = [[[UILabel alloc] init] autorelease];
        typeLabel.backgroundColor = [UIColor clearColor];
        typeLabel.textAlignment = NSTextAlignmentCenter;
        typeLabel.font = [UIFont systemFontOfSize:14];
        typeLabel.textColor = BB_Graydark;
        [typeLabel setFrame:CGRectMake(10.5, 0, (WIDTH-90)/3-35.5, 44)];
        typeLabel.text = imageArr0[i];
        [typeBtn addSubview:typeLabel];
        
        
        UIImageView * typeImage = [[[UIImageView alloc] init] autorelease];
        typeImage.frame = CGRectMake((WIDTH-90)/3-25, 17.5, 7, 10.5);
        typeImage.tag = 14+i;
        [typeBtn addSubview:typeImage];
        
        
        UIView * lineView1 = [[[UIView alloc] init] autorelease];
        lineView1.frame = CGRectMake(-1, 17, 0.5, 12);
        lineView1.backgroundColor = BB_Graylight;
        [typeBtn addSubview:lineView1];
        if (i == 0)
        {
            typeImage.image = [UIImage imageNamed:@"逆向排序.png"];
            [typeBtn setSelected:YES];
        }
        else
        {
            typeImage.image = [UIImage imageNamed:@"默认排序.png"];
            [typeBtn setSelected:NO];
        }
    }

    self.displayView = [[[UIView alloc]init]autorelease];
    [displayView setFrame:CGRectMake(0, 45, WIDTH, UI_View_Hieght-40)];
    [displayView setHidden:YES];
    displayView.alpha = 0.5;
    [displayView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:displayView];

    
    TapGR *temTap = [[[TapGR alloc] initWithTarget:self action:@selector(handleDisplayTap:)]autorelease];
    temTap.numberOfTapsRequired = 1;
    temTap.numberOfTouchesRequired = 1;
    temTap.delegate = self;
    temTap.touchRow = 1;
    [displayView addGestureRecognizer:temTap];

    
    self.firstTable = [[[UITableView alloc] initWithFrame:CGRectMake(0, 45, 100, 46*8) style:UITableViewStylePlain]autorelease];
    [XtomFunction addbordertoView:firstTable radius:0 width:0.5 color:BB_Graylight];
    [firstTable setBackgroundColor:BB_Back_Color_Here];
    [firstTable setBackgroundView:nil];
    firstTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    firstTable.dataSource = self;
    firstTable.delegate = self;
    [firstTable setHidden:YES];
    firstTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:firstTable];
    [firstTable setHidden:YES];
    
    
    [firstTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    if ([firstTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [firstTable setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([firstTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [firstTable setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
    self.secondTable = [[[UITableView alloc] initWithFrame:CGRectMake(99.5, 45, WIDTH-99.5, 273) style:UITableViewStylePlain]autorelease];
    [XtomFunction addbordertoView:secondTable radius:0 width:0.5 color:BB_Graylight];
    [secondTable setBackgroundColor:BB_Back_Color_Here];
    [secondTable setBackgroundView:nil];
    secondTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    secondTable.dataSource = self;
    secondTable.delegate = self;
    [secondTable setHidden:YES];
    secondTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:secondTable];
    [secondTable setHidden:YES];
    
    
    [secondTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    if ([secondTable respondsToSelector:@selector(setSeparatorInset:)])
    {
        [secondTable setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([secondTable respondsToSelector:@selector(setLayoutMargins:)])
    {
        [secondTable setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
    self.filtrateView = [[[UIView alloc] init] autorelease];
    filtrateView.frame = CGRectMake(-1, 0, WIDTH+2, 106);
    filtrateView.backgroundColor = BB_Back_Color_Here;
    [XtomFunction addbordertoView:filtrateView radius:0 width:1 color:BB_Gray];
    [self.view addSubview:filtrateView];
    [filtrateView setHidden:YES];
    isFiltrate = NO;
    
    
    UILabel * priceLabel = [[[UILabel alloc] init] autorelease];
    priceLabel.backgroundColor = [UIColor clearColor];
    priceLabel.textAlignment = NSTextAlignmentLeft;
    priceLabel.font = [UIFont systemFontOfSize:15];
    priceLabel.textColor = BB_Blake;
    [priceLabel setFrame:CGRectMake(12, 13, 150, 30)];
    priceLabel.tag = 40;
    priceLabel.text = @"价格区间：（元）";
    [filtrateView addSubview:priceLabel];
    
    
    self.leftPrice = [[[UITextField alloc] init] autorelease];
    [XtomFunction addbordertoView:leftPrice radius:0.5 width:0.5 color:[UIColor blackColor]];
    leftPrice.backgroundColor = [UIColor whiteColor];
    leftPrice.textAlignment = NSTextAlignmentCenter;
    leftPrice.textColor = [UIColor blackColor];
    leftPrice.font = [UIFont systemFontOfSize:15];
    leftPrice.frame = CGRectMake(12, 51, (WIDTH-74)/2, 37.5);
    
    leftPrice.delegate = self;
    leftPrice.returnKeyType = UIReturnKeyDefault;
    leftPrice.clearButtonMode = UITextFieldViewModeWhileEditing;
    leftPrice.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    leftPrice.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [filtrateView addSubview:leftPrice];
    
    
    UIView * lineView1 = [[[UIView alloc] init] autorelease];
    lineView1.backgroundColor = [UIColor blackColor];
    lineView1.frame = CGRectMake((WIDTH-40)/2, 68.5, 40, 0.5);
    [filtrateView addSubview:lineView1];
    
    
    self.rightPrice = [[[UITextField alloc] init] autorelease];
    [XtomFunction addbordertoView:rightPrice radius:0.5 width:0.5 color:[UIColor blackColor]];
    rightPrice.backgroundColor = [UIColor whiteColor];
    rightPrice.textAlignment = NSTextAlignmentCenter;
    rightPrice.textColor = [UIColor blackColor];
    rightPrice.font = [UIFont systemFontOfSize:15];
    rightPrice.frame = CGRectMake((WIDTH-74)/2 + 62, 51, (WIDTH-74)/2, 37.5);
    
    rightPrice.delegate = self;
    rightPrice.returnKeyType = UIReturnKeyDefault;
    rightPrice.clearButtonMode = UITextFieldViewModeWhileEditing;
    rightPrice.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    rightPrice.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [filtrateView addSubview:rightPrice];
    
    
    UIButton * finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    finishBtn.frame = CGRectMake(WIDTH-70, 8, 60, 40);
    [finishBtn setTitle:@"确定" forState:UIControlStateNormal];
    finishBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [finishBtn setTitleColor:BB_Button_Color forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    finishBtn.tag = 7;
    [filtrateView addSubview:finishBtn];
    
    self.priceDisplayView = [[[UIView alloc]init]autorelease];
    [priceDisplayView setFrame:CGRectMake(0, UI_View_Hieght-40, WIDTH, 40)];
    priceDisplayView.alpha = 0.5;
    [priceDisplayView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:priceDisplayView];
    [priceDisplayView setHidden:YES];
    
    
    TapGR *temTap1 = [[[TapGR alloc] initWithTarget:self action:@selector(handleDisplayTap:)]autorelease];
    temTap1.numberOfTapsRequired = 1;
    temTap1.numberOfTouchesRequired = 1;
    temTap1.delegate = self;
    temTap1.touchRow = 2;
    [priceDisplayView addGestureRecognizer:temTap1];
    
    
    
    [mytable setFrame:CGRectMake(0, 48, WIDTH, UI_View_Hieght-48)];
    [footerView setFrame:CGRectMake(0, UI_View_Hieght, WIDTH, 30)];
    [mytable setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [mytable setSeparatorInset:UIEdgeInsetsMake(0, 100, 0, 0)];
}

- (void)loadData
{
    [self requestFirstGoodsType];
    [self requestGoodsList];
    [self requestAdList];
}

- (void)leftBtnPressed
{
    if ([keytype integerValue] == 3)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)rightBtnPressed
{
    if ([keytype integerValue] == 3)
    {
        SearchHistoryVC * search = [[[SearchHistoryVC alloc] init] autorelease];
        search.keyType = @"1";
        [self.navigationController pushViewController:search animated:YES];
    }
    else if ([keytype integerValue] == 2)
    {
        [searchTextField2 resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        UIButton * button = (UIButton *)[self.view viewWithTag:1];
        if (!button.selected)
        {
            [leftPrice becomeFirstResponder];
            
            [filtrateView setHidden:NO];
            [priceDisplayView setHidden:NO];
            isFiltrate = YES;
            [mytable setUserInteractionEnabled:NO];
        }
    }
}

- (void)searchButtonClick
{
    SearchHistoryVC * search = [[[SearchHistoryVC alloc] init] autorelease];
    search.keyType = @"1";
    [self.navigationController pushViewController:search animated:YES];
}


- (void)buttonClick:(UIButton *)button
{
    if (button.tag == 1)
    {
        if (button.selected)
        {
            [button setSelected:NO];
            [displayView setHidden:YES];
            [firstTable setHidden:YES];
            [secondTable setHidden:YES];
        }
        else
        {
            [button setSelected:YES];
            [displayView setHidden:NO];
            [firstTable setHidden:NO];
            [firstTable reloadData];
        }
        return;
    }
    if (button.tag > 10 && button.tag < 14)
    {
        UIButton * selectBtn = (UIButton *)[self.view viewWithTag:1];
        [selectBtn setSelected:NO];
        [displayView setHidden:YES];
        [firstTable setHidden:YES];
        [secondTable setHidden:YES];
        UIImageView * image1 = (UIImageView *)[self.view viewWithTag:14];
        UIImageView * image2 = (UIImageView *)[self.view viewWithTag:15];
        UIImageView * image3 = (UIImageView *)[self.view viewWithTag:16];
        UIButton * button1 = (UIButton *)[self.view viewWithTag:11];
        UIButton * button2 = (UIButton *)[self.view viewWithTag:12];
        UIButton * button3 = (UIButton *)[self.view viewWithTag:13];
        if (button.tag == 11)
        {
            orderby = 0;
            if (button.selected)
            {
                image1.image = [UIImage imageNamed:@"正向排序"];
                button.selected = NO;
                ordertype = 1;
            }
            else
            {
                image1.image = [UIImage imageNamed:@"逆向排序"];
                button.selected = YES;
                ordertype = 0;
            }
            image2.image = [UIImage imageNamed:@"默认排序.png"];
            image3.image = [UIImage imageNamed:@"默认排序.png"];
            button2.selected = NO;
            button3.selected = NO;
        }
        if (button.tag == 12)
        {
            orderby = 1;
            if (button.selected)
            {
                image2.image = [UIImage imageNamed:@"正向排序"];
                button.selected = NO;
                ordertype = 1;
            }
            else
            {
                image2.image = [UIImage imageNamed:@"逆向排序"];
                button.selected = YES;
                ordertype = 0;
            }
            image1.image = [UIImage imageNamed:@"默认排序.png"];
            image3.image = [UIImage imageNamed:@"默认排序.png"];
            button1.selected = NO;
            button3.selected = NO;
        }
        if (button.tag == 13)
        {
            orderby = 2;
            if (button.selected)
            {
                image3.image = [UIImage imageNamed:@"正向排序"];
                button.selected = NO;
                ordertype = 1;
            }
            else
            {
                image3.image = [UIImage imageNamed:@"逆向排序"];
                button.selected = YES;
                ordertype = 0;
            }
            image1.image = [UIImage imageNamed:@"默认排序.png"];
            image2.image = [UIImage imageNamed:@"默认排序.png"];
            button1.selected = NO;
            button2.selected = NO;
        }
        
        [self requestGoodsList];
    }
    
    if (button.tag == 7)
    {
        if (isFiltrate)
        {
            if ([leftPrice.text isEqualToString:@""] || [rightPrice.text isEqualToString:@""])
            {
                [XtomFunction openIntervalHUD:@"你还未输入想要的价格区间" view:self.view];
                return;
            }
            if ([leftPrice.text floatValue]>=[rightPrice.text floatValue])
            {
                [XtomFunction openIntervalHUD:@"您输入的价格区间有误，请重新输入" view:self.view];
                return;
            }
        }
        [surePriceView setHidden:YES];
        [filtrateView setHidden:YES];
        [priceDisplayView setHidden:YES];
        [leftPrice resignFirstResponder];
        [rightPrice resignFirstResponder];
        NSLog(@"确定了筛选条件");
        
        [self requestGoodsList];
        isFiltrate = NO;
    }
}


- (void)buttonClick1:(BBButton *)button
{
    if (button.btnRow == 1)
    {
        isDelete = YES;
        [mytable reloadData];
    }
}


- (void)handleDisplayTap:(TapGR *)gs
{
    if (gs.touchRow == 1)
    {
        [displayView setHidden:YES];
        [firstTable setHidden:YES];
        [secondTable setHidden:YES];
        UIButton * button = (UIButton *)[self.view viewWithTag:1];
        [button setSelected:NO];
        return;
    }
    if (gs.touchRow == 2)
    {
        NSLog(@"点击的是筛选阴影层");
        [priceDisplayView setHidden:YES];
        [filtrateView setHidden:YES];
        isFiltrate = NO;
        [leftPrice resignFirstResponder];
        [rightPrice resignFirstResponder];
    }
}


-(void)keyboardWillShow:(NSNotification *)notification
{
    [mytable setUserInteractionEnabled:NO];
    CGFloat animationTime = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:animationTime animations:^{
        CGRect keyBoardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
        priceDisplayView.frame = CGRectMake(0, 106,WIDTH,UI_View_Hieght - keyBoardFrame.size.height - 106);
    }];
}
-(void)keyboardWillHide:(NSNotification *)notification
{
    [mytable setUserInteractionEnabled:YES];
    
    CGFloat animationTime = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:animationTime animations:^{
        
        priceDisplayView.frame = CGRectMake(0, UI_View_Hieght,WIDTH,priceDisplayView.frame.size.height);
        
    }];
}

- (void)infoAction:(NSNotification *)noti
{
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == leftPrice || textField == rightPrice)
    {
        return [self validateNumber:string];
    }
    return YES;
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.searchTextField2)
    {
        [self requestGoodsList];
    }
    return [textField resignFirstResponder];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (firstTable == tableView || secondTable == tableView)
    {
        if ([cell respondsToSelector:@selector(setSeparatorInset:)])
        {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)])
        {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (firstTable == tableView || secondTable == tableView)
    {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (firstTable == tableView)
    {
        return firstArr.count;
    }
    if (secondTable == tableView)
    {
//        NSLog(@"%ld", secondArr.count);
        return secondArr.count;
    }
    if (0 == section)
    {
        if (isDelete)
        {
            return 0;
        }
        return 1;
    }
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (firstTable == tableView)
    {
        static NSString * cellID = @"CategoryCell00";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.backgroundColor = BB_White_Color;
        }
        NSMutableDictionary * temDic = [firstArr objectAtIndex:indexPath.row];
        cell.textLabel.text = [temDic objectForKey:@"name"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        return cell;
    }
    if (secondTable == tableView)
    {
        static NSString * cellID = @"CategoryCell01";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = BB_White_Color;
        }
        NSMutableDictionary * temDic = [secondArr objectAtIndex:indexPath.row];
        cell.textLabel.text = [temDic objectForKey:@"name"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        return cell;
    }
    if (0 == indexPath.section)
    {
        static NSString * cellID = @"CategoryCell02";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil)
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
        self.adImage = [[[UIImageView alloc] init] autorelease];
        adImage.frame = CGRectMake(0, 0, WIDTH, 50);
        adImage.image = [UIImage imageNamed:@"商城_默认广告页4.png"];
        adImage.contentMode = UIViewContentModeScaleAspectFill;
        adImage.clipsToBounds = YES;
        
        if (dataTopAd.count > 0)
        {
            NSString *avatar = [[dataTopAd objectAtIndex:0] objectForKey:@"imgurl"];
            if(![XtomFunction xfunc_check_strEmpty:avatar])
            {
                NSString *document = [NSString stringWithFormat:@"%@/%@",BB_CASH_DOCUMENT,BB_CASH_AVATAR];
                [[XtomCashManager sharedManager] addImgToImgViewFromDocumentORURL:self.adImage document:document url:avatar];
            }
            [cell.contentView addSubview:adImage];
            
            UIImageView * xImage = [[[UIImageView alloc] init] autorelease];
            xImage.frame = CGRectMake(WIDTH-7.5-26.5, 6.5, 26.5, 26.5);
            xImage.image = [UIImage imageNamed:@"store_addelete.png"];
            [cell.contentView addSubview:xImage];
            
            BBButton * xBtn = [BBButton buttonWithType:UIButtonTypeCustom];
            [xBtn setFrame:CGRectMake(WIDTH-50, 0, 50, 50)];
            xBtn.btnRow = 1;
            xBtn.backgroundColor = [UIColor clearColor];
            [xBtn addTarget:self action:@selector(buttonClick1:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:xBtn];
        }
        
        return cell;
    }
    
    static NSString * cellID = @"CategoryCell03";
    CategoryGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[[CategoryGoodsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = BB_White_Color;
    }
    NSMutableDictionary * temDict = [dataArray objectAtIndex:indexPath.row];
    NSString *downavatar = [temDict objectForKey:@"imgurl0"];
    cell.logoImage.image = [UIImage imageNamed:@"商城_默认广告页3.png"];
    if(![XtomFunction xfunc_check_strEmpty:downavatar])
    {
        NSString *document = [NSString stringWithFormat:@"%@/%@",BB_CASH_DOCUMENT,BB_CASH_AVATAR];
        [[XtomCashManager sharedManager] addImgToImgViewFromDocumentORURL:cell.logoImage document:document url:downavatar];
    }
    
    if ([[temDict objectForKey:@"recommentflag"] integerValue] == 1)
    {
        [cell.hotFlag setHidden:NO];
    }
    else
    {
        [cell.hotFlag setHidden:YES];
    }
    
    [cell.hotFlag setHidden:YES];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (mytable == tableView)
    {
        if (0 == section)
        {
            if (dataTopAd.count == 0)
            {
                return 0.01;
            }
            return 3;
        }
        return 5;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (firstTable == tableView || secondTable  == tableView)
    {
        return 46;
    }
    if (0 == indexPath.section)
    {
        if (0 == dataTopAd.count)
        {
            return 0;
        }
        else
        {
            return 50;
        }
    }
    
    return 84;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (firstTable == tableView)
    {
        NSMutableDictionary * temDict = [firstArr objectAtIndex:indexPath.row];
        if ([[[firstArr objectAtIndex:indexPath.row] objectForKey:@"name"] isEqualToString:@"全部"])
        {
            [displayView setHidden:YES];
            [firstTable setHidden:YES];
        }
        else
        {
            [self requestSecondGoodsType:[temDict objectForKey:@"id"]];
        }
        
        UILabel * typeLabel = (UILabel *)[self.view viewWithTag:2];
        typeLabel.text = [[firstArr objectAtIndex:indexPath.row] objectForKey:@"name"];
        self.isSecond = NO;
        self.isFirst = YES;
        self.keyid = [[firstArr objectAtIndex:indexPath.row] objectForKey:@"id"];
        [self requestGoodsList];
    }
    if (secondTable == tableView)
    {
        [displayView setHidden:YES];
        [firstTable setHidden:YES];
        [secondTable setHidden:YES];
        
        UIButton * button = (UIButton *)[self.view viewWithTag:1];
        button.selected = NO;
        [firstTable deselectRowAtIndexPath:indexPath animated:YES];
        UILabel * typeLabel = (UILabel *)[self.view viewWithTag:2];
        if ([typeLabel.text isEqualToString:@"全部"])
        {
            typeLabel.text = [[secondArr objectAtIndex:indexPath.row] objectForKey:@"name"];
            self.isSecond = NO;
            self.isFirst = YES;
            self.keyid = [[secondArr objectAtIndex:indexPath.row] objectForKey:@"id"];
            [self requestGoodsList];
        }
        else if (![[[secondArr objectAtIndex:indexPath.row] objectForKey:@"name"] isEqualToString:@"全部"])
        {
            typeLabel.text = [[secondArr objectAtIndex:indexPath.row] objectForKey:@"name"];
            self.isSecond = YES;
            self.isFirst = NO;
            self.keyid = [[secondArr objectAtIndex:indexPath.row] objectForKey:@"id"];
            [self requestGoodsList];
        }
    }
    if (mytable == tableView)
    {
        if (0 == indexPath.section)
        {
            NSMutableDictionary * temDic = [self.dataTopAd objectAtIndex:0];
            if ([[temDic objectForKey:@"keytype"] integerValue] == 2)
            {
//                WebVC *web = [[[WebVC alloc]init]autorelease];
//                web.urlPath =[temDic objectForKey:@"clickid"];
//                web.objectTitle = @"网页";
//                web.isAdgust = NO; 
//                [self.navigationController pushViewController:web animated:YES];
            }
            else if ([[temDic objectForKey:@"keytype"]integerValue] == 4)
            {
//                StoreDetailVC * detail = [[[StoreDetailVC alloc]init]autorelease];
//                detail.isPresent = YES;
//                detail.keyid = [temDic objectForKey:@"keyid"];
//               [self.navigationController pushViewController:detail animated:YES];
            }
            else if ([[temDic objectForKey:@"keytype"]integerValue] == 1)
            {
                if ([[temDic objectForKey:@"blogtype"]integerValue] == 1)
                {

                }
                else if ([[temDic objectForKey:@"blogtype"]integerValue] == 2)
                {
                    RealityDetailVC * detail = [[[RealityDetailVC alloc] init] autorelease];
                    detail.isPresent = YES;
                    detail.keytype = @"1";
                    detail.keyid = [temDic objectForKey:@"keyid"];
                    [self.navigationController pushViewController:detail animated:YES];
                }
            }
        }
        else
        {
            NSMutableDictionary * temDict = [dataArray objectAtIndex:indexPath.row];
            if ([[temDict objectForKey:@"blogtype"]integerValue] == 1)
            {
            }
            else if ([[temDict objectForKey:@"blogtype"]integerValue] == 2)
            {
                RealityDetailVC * detail = [[[RealityDetailVC alloc] init] autorelease];
                detail.keytype = @"1";
                detail.keyid = [temDict objectForKey:@"id"];
                [self.navigationController pushViewController:detail animated:YES];
            }
        }
    }
}


- (void)requestFirstGoodsType
{
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:@"0" forKey:@"parentid"];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_TYPE_LIST] target:self selector:@selector(responseFirstGoodsType:) parameter:dic];
}

- (void)responseFirstGoodsType:(NSDictionary*)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        
        if (!firstArr)
        {
            self.firstArr = [[[NSMutableArray alloc] init] autorelease];
        }
        [firstArr removeAllObjects];
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
                [self.firstArr addObject:dict];
            }
            if (HEIGHT-64-45-20<45*firstArr.count)
            {
                [firstTable setFrame:CGRectMake(0, 44, 99.5, HEIGHT-64-45)];
            }
            else
            {
                [firstTable setFrame:CGRectMake(0, 44, 99.5, 45*firstArr.count)];
            }
            [firstTable reloadData];
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


- (void)requestSecondGoodsType:(NSString *)parentid
{
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:parentid?parentid:@"0" forKey:@"parentid"];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_TYPE_LIST] target:self selector:@selector(responseSecondGoodsType:) parameter:dic];
}

- (void)responseSecondGoodsType:(NSDictionary*)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        if (!secondArr)
        {
            self.secondArr = [[[NSMutableArray alloc] init] autorelease];
        }
        [secondArr removeAllObjects];
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
                [self.secondArr addObject:dict];
            }
            [secondTable setHidden:NO];
            [secondTable setFrame:CGRectMake(99.5, 45, WIDTH-99.5, 46*secondArr.count)];
            [secondTable reloadData];
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


- (void)requestAdList
{
    NSMutableDictionary * dic = [[[NSMutableDictionary alloc] init] autorelease];
    NSString *url = [NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_SHOWCASEAD_LIST];
    [XTomRequest requestWithURL:url target:self selector:@selector(responseAdList:) parameter:dic];
}

- (void)responseAdList:(NSDictionary*)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        if (!dataTopAd)
        {
            self.dataTopAd = [[[NSMutableArray alloc] init] autorelease];
        }
        [dataTopAd removeAllObjects];
        
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
                [self.dataTopAd addObject:dict];
            }
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


- (void)requestGoodsList
{
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    //此处有问题
    NSString * client_id = [[[XtomManager sharedManager] motherInfor] objectForKey:@"id"];
//    [dic setObject:client_id forKey:@"client_id"];
    if (!isFirst && !isSecond)
    {
        [dic setObject:@"1" forKey:@"keytype"];
    }
    else if (isFirst && !isSecond)
    {
        [dic setObject:@"6" forKey:@"keytype"];
    }
    else if (!isFirst && isSecond)
    {
        [dic setObject:@"1" forKey:@"keytype"];
    }
//    [dic setObject:keyid forKey:@"keyid"];
    [dic setObject:self.sellerid?self.sellerid:@"无" forKey:@"sellerid"];
    [dic setObject:[NSString stringWithFormat:@"%d", orderby+1] forKey:@"orderby"];
    switch (ordertype)
    {
        case 0:
        {
            [dic setObject:@"desc" forKey:@"ordertype"];
        }
            break;
        case 1:
        {
            [dic setObject:@"asc" forKey:@"ordertype"];
        }
            break;
        default:
            break;
    }
    if ([keytype integerValue] == 2)
    {
        [dic setObject:self.searchTextField2.text forKey:@"keyword"];
    }
    else
    {
        [dic setObject:@"" forKey:@"keyword"];
    }
    if ([keytype integerValue] == 3)
    {
        [dic setObject:@"2" forKey:@"keytype"];
        if (self.isShiWu)
        {
            [dic setObject:@"2" forKey:@"keyid"];
        }
        else
        {
            [dic setObject:@"1" forKey:@"keyid"];
        }
        if (isSecond)
        {
            [dic setObject:keyid forKey:@"typeid2"];
        }
        
    }
    [dic setObject:[NSString stringWithFormat:@"%d",(int)currentPage] forKey:@"page"];
    if (isFiltrate)
    {
        [dic setObject:leftPrice.text forKey:@"price1"];
        [dic setObject:rightPrice.text forKey:@"price2"];
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_BLOG_LIST];
    [XTomRequest requestWithURL:url target:self selector:@selector(responseGoodsList:) parameter:dic];
}

- (void)responseGoodsList:(NSDictionary*)info
{
    if (waitMB)
    {
        [XtomFunction closeHUD:waitMB];waitMB = nil;
    }
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        if (!dataArray)
        {
            self.dataArray = [[[NSMutableArray alloc]init]autorelease];
        }
        if(0 == currentPage)
        {
            if (dataArray.count != 0)
            {
                if (isDelete)
                {
                    [mytable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                }
                else
                {
                    [mytable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                }
            }
            [dataArray removeAllObjects];
        }
        NSString *val=[[info objectForKey:@"infor"]objectForKey:@"listItems"];
        if ([XtomFunction xfunc_check_strEmpty:val])
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
            NSArray *temArr = [[info objectForKey:@"infor"]objectForKey:@"listItems"];
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
                }
                else
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
                    }
                    [self.dataArray addObject:dict];
                }
            }
        }
    }
    else
    {
        if([info objectForKey:@"msg"])
        {
            [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:self.view];
        }
    }
    [self reShowView];
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
    if ([keytype integerValue] == 2)
    {
        if(0 == dataArray.count)
        {
            [self showNoDataView:@"没有您要的搜索结果"];
            [self showNoDataImg:@"暂无数据"];
        }
        else
        {
            [self hideNoDataView];
        }
    }
    else
    {
        if(0 == dataArray.count)
        {
            [self showNoDataView:@"暂无数据"];
        }
        else
        {
            [self hideNoDataView];
        }
    }
    [mytable reloadData];
}


- (void)refresh
{
    currentPage = 0;
    isEnd = NO;
    [self requestGoodsList];
}

-(void)addMore
{
    if (!isEnd)
    {
        currentPage++;
    }
    [self requestGoodsList];
}


@end
