//
//  UserOrderVC.m
//  PingChuan
//
//  Created by pengli on 15/10/21.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "UserOrderVC.h"
#import "UserOrderListVC.h"
#import "RefundedListVC.h"

@interface UserOrderVC ()

@property (nonatomic, retain) UILabel * lineLabel;
@property (nonatomic, retain) UserOrderListVC * order0;
@property (nonatomic, retain) UserOrderListVC * order1;
@property (nonatomic, retain) UserOrderListVC * order2;
@property (nonatomic, retain) UserOrderListVC * order3;
@property (nonatomic, retain) UserOrderListVC * order4;

@end

@implementation UserOrderVC

@synthesize lineLabel;
@synthesize order0;
@synthesize order1;
@synthesize order2;
@synthesize order3;
@synthesize order4;

@synthesize navSelectType;
@synthesize isCart;

- (void)dealloc
{
    [lineLabel release]; lineLabel = nil;
    [order0 release]; order0 = nil;
    [order1 release]; order1 = nil;
    [order2 release]; order2 = nil;
    [order3 release]; order3 = nil;
    [order4 release]; order4 = nil;
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIButton * button = (UIButton *)[self.view viewWithTag:10+navSelectType];
    
    button.selected = YES;
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    button.userInteractionEnabled = NO;
    
    CGPoint point = button.frame.origin;
    lineLabel.frame = CGRectMake(point.x, 42, 60, 3);
    for (int i = 0; i < 5; i++)
    {
        UIButton * selButton = (UIButton *)[self.view viewWithTag:10+i];
        
        if (selButton.tag == button.tag) {
            continue;
        }
        selButton.selected = NO;
        selButton.userInteractionEnabled = YES;
        selButton.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    if (navSelectType == 0)
    {
        order0.keytype = @"0";
        order0.view.hidden = NO;
        order1.view.hidden = YES;
        order2.view.hidden = YES;
        order3.view.hidden = YES;
        order4.view.hidden = YES;
        [order0 getmyData];
    }
    if (navSelectType == 1)
    {
        order1.keytype = @"1";
        order0.view.hidden = YES;
        order1.view.hidden = NO;
        order2.view.hidden = YES;
        order3.view.hidden = YES;
        order4.view.hidden = YES;
        [order1 getmyData];
    }
    if (navSelectType == 2)
    {
        order2.keytype = @"2";
        order0.view.hidden = YES;
        order1.view.hidden = YES;
        order2.view.hidden = NO;
        order3.view.hidden = YES;
        order4.view.hidden = YES;
        [order2 getmyData];
    }
    if (navSelectType == 3)
    {
        order3.keytype = @"3";
        order0.view.hidden = YES;
        order1.view.hidden = YES;
        order2.view.hidden = YES;
        order3.view.hidden = NO;
        order4.view.hidden = YES;
        [order3 getmyData];
    }
    if (navSelectType == 4)
    {
        order4.keytype = @"4";
        order0.view.hidden = YES;
        order1.view.hidden = YES;
        order2.view.hidden = YES;
        order3.view.hidden = YES;
        order4.view.hidden = NO;
        [order4 getmyData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadSet];
}

- (void)loadSet
{
    
    [self.navigationItem setNewTitle:@"我的订单"];
    [self.navigationController.navigationBar setBarTintColor:NavigationColor];
    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftBtnPressed) image:@"common_return.png" imageH:@"common_return.png"];
    [self.navigationItem setRightItemWithTarget:self action:@selector(rightBtnPressed) title:@"退款/售后"];
    self.view.backgroundColor = BB_Back_Color_Here;
    
   
    UIView * backView = [[[UIView alloc] init] autorelease];
    backView.backgroundColor = [UIColor whiteColor];
    backView.frame = CGRectMake(0, 0, WIDTH, 45);
    [self.view addSubview:backView];
    
    NSArray * titles = @[@"全部", @"待付款", @"待收货", @"待评价", @"待消费"];
    
    for (int i = 0; i < 5; i++)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((WIDTH-300)/2+i*60, 0, 60, 43.5);
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:BB_Button_Color forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+10;
        [backView addSubview:button];
        if (button.tag == 10) {
            button.selected = YES;
            button.userInteractionEnabled = NO;
            button.titleLabel.font = [UIFont systemFontOfSize:17];
        }
        else
        {
            button.selected = NO;
            button.userInteractionEnabled = YES;
        }
    }
    
    self.lineLabel = [[UILabel alloc] initWithFrame:CGRectMake((WIDTH-300)/2, 42, 60, 3)];
    lineLabel.backgroundColor = BB_Button_Color;
    [backView addSubview:lineLabel];
    
    
    
    if (!order0)
    {
        self.order0 = [[[UserOrderListVC alloc] init] autorelease];
        order0.keytype = @"0";
        [order0.view setFrame:CGRectMake(0, 48, WIDTH, UI_View_Hieght+64)];
        [order0.view setClipsToBounds:YES];
        order0.view.backgroundColor=[UIColor clearColor];
        [self.view addSubview:order0.view];
        order0.view.hidden = NO;
    }
    [order0 getmyData];
    
    
    if (!order1)
    {
        self.order1 = [[[UserOrderListVC alloc]init]autorelease];
        order1.keytype = @"1";
        [order1.view setFrame:CGRectMake(0, 55, WIDTH, UI_View_Hieght+64)];
        [order1.view setClipsToBounds:YES];
        order1.view.backgroundColor=[UIColor clearColor];
        [self.view addSubview:order1.view];
        order1.view.hidden = YES;
    }
    [order1 getmyData];
    
    
    if (!order2)
    {
        self.order2 = [[[UserOrderListVC alloc]init]autorelease];
        order2.keytype = @"2";
        [order2.view setFrame:CGRectMake(0, 55, WIDTH, UI_View_Hieght+64)];
        [order2.view setClipsToBounds:YES];
        order2.view.backgroundColor=[UIColor clearColor];
        [self.view addSubview:order2.view];
        order2.view.hidden = YES;
    }
    [order2 getmyData];
    
    
    if (!order3)
    {
        self.order3 = [[[UserOrderListVC alloc]init]autorelease];
        order3.keytype = @"3";
        [order3.view setFrame:CGRectMake(0, 55, WIDTH, UI_View_Hieght+64)];
        [order3.view setClipsToBounds:YES];
        order3.view.backgroundColor=[UIColor clearColor];
        [self.view addSubview:order3.view];
        order3.view.hidden = YES;
    }
    [order3 getmyData];
    
    
    if (!order4)
    {
        self.order4 = [[[UserOrderListVC alloc]init]autorelease];
        order4.keytype = @"4";
        [order4.view setFrame:CGRectMake(0, 55, WIDTH, UI_View_Hieght+64)];
        [order4.view setClipsToBounds:YES];
        order4.view.backgroundColor=[UIColor clearColor];
        [self.view addSubview:order4.view];
        order4.view.hidden = YES;
    }
    [order4 getmyData];
}

- (void)buttonClick:(UIButton *)button
{
    navSelectType = button.tag - 10;
    
    button.selected = YES;
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    button.userInteractionEnabled = NO;
    
    CGPoint point = button.frame.origin;
    lineLabel.frame = CGRectMake(point.x, 42, 60, 3);
    for (int i = 0; i < 5; i++)
    {
        UIButton * selButton = (UIButton *)[self.view viewWithTag:10+i];
        
        if (selButton.tag == button.tag) {
            continue;
        }
        selButton.selected = NO;
        selButton.userInteractionEnabled = YES;
        selButton.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    
    if (button.tag == 10)
    {
        order0.keytype = @"0";
        order0.view.hidden = NO;
        order1.view.hidden = YES;
        order2.view.hidden = YES;
        order3.view.hidden = YES;
        order4.view.hidden = YES;
        [order0 getmyData];
        [order0.mytable reloadData];
    }
    if (button.tag == 11)
    {
        order1.keytype = @"1";
        order0.view.hidden = YES;
        order1.view.hidden = NO;
        order2.view.hidden = YES;
        order3.view.hidden = YES;
        order4.view.hidden = YES;
        [order1 getmyData];
        [order1.mytable reloadData];
    }
    if (button.tag == 12)
    {
        order2.keytype = @"2";
        order0.view.hidden = YES;
        order1.view.hidden = YES;
        order2.view.hidden = NO;
        order3.view.hidden = YES;
        order4.view.hidden = YES;
        [order2 getmyData];
        [order2.mytable reloadData];
    }
    if (button.tag == 13)
    {
        order3.keytype = @"3";
        order0.view.hidden = YES;
        order1.view.hidden = YES;
        order2.view.hidden = YES;
        order3.view.hidden = NO;
        order4.view.hidden = YES;
        [order3 getmyData];
        [order3.mytable reloadData];
    }
    if (button.tag == 14)
    {
        order4.keytype = @"4";
        order0.view.hidden = YES;
        order1.view.hidden = YES;
        order2.view.hidden = YES;
        order3.view.hidden = YES;
        order4.view.hidden = NO;
        [order4 getmyData];
        [order4.mytable reloadData];
    }
}

- (void)leftBtnPressed
{
    if (isCart)
    {
        NSInteger count = [self.navigationController.viewControllers count];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:count-3] animated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)rightBtnPressed
{
    RefundedListVC * account = [[[RefundedListVC alloc]init]autorelease];
    [self.navigationController pushViewController:account animated:YES];
}

@end
