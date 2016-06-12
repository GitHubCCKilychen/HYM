//
//  TiXianVC.m
//  PingChuan
//
//  Created by pengli on 15/10/21.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "TiXianVC.h"
#import "TiXianDeatailVC.h"
#define NUMBERS @"0123456789\n"

@interface TiXianVC ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    NSInteger paySection;
    BOOL _isTextField;
}
@property (nonatomic, retain) UITableView * myTableView;
@property (nonatomic, retain) UITextField * textFeild;
@property (nonatomic, copy) NSString * orderStr;
@end

@implementation TiXianVC
@synthesize myTableView;
@synthesize textFeild;
@synthesize orderStr;

- (void)dealloc
{
    [myTableView release]; myTableView = nil;
    [textFeild release]; textFeild = nil;
    [orderStr release]; orderStr = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BB_NOTIFICATION_OrderOK object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BB_NOTIFICATION_OrderFail object:nil];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(infoAction) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)infoAction
{
    
    if ([textFeild.text isEqualToString:@"."])
    {
        textFeild.text = @"0.";
    }
    if ([textFeild.text isEqualToString:@"0"])
    {
        textFeild.text = @"0.";
    }
    NSInteger count = 0;
    for (int j = 0; j < [textFeild.text length]; j++)
    {
        char s = [textFeild.text characterAtIndex:j];
        if (s == '.' )
        {
            count++;
        }
    }
    NSMutableString * str = [NSMutableString stringWithString:textFeild.text];
    if (count>1)
    {
        [str deleteCharactersInRange:NSMakeRange(textFeild.text.length-1, 1)];
        count = 1;
    }
    textFeild.text = str;
    
   
    if (count == 1)
    {
        NSRange range1 = [textFeild.text rangeOfString:@"."];
        NSArray * arr = [textFeild.text componentsSeparatedByString:@"."];
        if (arr.count > 1)
        {
            NSString * str = arr[1];
            if (str.length > 2)
            {
                textFeild.text = [textFeild.text substringWithRange:NSMakeRange(0, range1.location+3)];
            }
        }
        
    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadSet];
}

- (void)loadSet
{
    
    [self.navigationItem setNewTitle:@"申请提现"];
    [self.navigationController.navigationBar setBarTintColor:NavigationColor];
    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftBtnPressed:) image:@"common_return.png" imageH:@"common_return.png"];
    self.view.backgroundColor = BB_Back_Color_Here;
    
    self.myTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UI_View_Hieght) style:UITableViewStyleGrouped] autorelease];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    paySection = 1;
}


- (void)leftBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)okButtonPress:(id)sender
{
    if ([textFeild.text isEqualToString:@"0."])
    {
        [XtomFunction openIntervalHUD:@"价格输入不正确，请重新输入" view:self.view];
        return;
    }
    if ([XtomFunction xfunc_check_strEmpty:textFeild.text])
    {
        [XtomFunction openIntervalHUD:@"请输入提现金额" view:nil];
        return;
    }
    if (paySection == -1)
    {
        [XtomFunction openIntervalHUD:@"请选择提现方式" view:nil];
        return;
    }
    TiXianDeatailVC * detail = [[[TiXianDeatailVC alloc] init] autorelease];
    detail.keytype = [NSString stringWithFormat:@"%zd", paySection];
    detail.applyfee = textFeild.text;
    [self.navigationController pushViewController:detail animated:YES];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length != 0)
    {
        
    }
    else
    {
        if ([textFeild.text isEqualToString:@"0."])
        {
            textFeild.text = @"";
        }
    }
    return [self validateNumber:string];
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



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _isTextField = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _isTextField = NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section)
    {
        return 1;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        static NSString * cellID = @"RechargeCell00";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            
            UILabel * moneyLabel = [[[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 25)] autorelease];
            moneyLabel.text = @"提现金额(元)";
            moneyLabel.textColor = [UIColor grayColor];
            moneyLabel.font = [UIFont systemFontOfSize:15];
            [cell.contentView addSubview:moneyLabel];
            
            
            self.textFeild = [[[UITextField alloc] initWithFrame:CGRectMake(0, 55, WIDTH, 35)] autorelease];
            textFeild.textAlignment = NSTextAlignmentCenter;
            textFeild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            textFeild.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            textFeild.placeholder = @"请输入您要提现的金额";
            textFeild.delegate = self;
            textFeild.returnKeyType = UIReturnKeyDone;
        
            [cell.contentView addSubview:self.textFeild];
            
            
            UILabel * infoLabel = [[[UILabel alloc] initWithFrame:CGRectMake(13, 113, WIDTH-26, 20)] autorelease];
            infoLabel.text = @"*提现金额100元以下，收取1元手续费；100元以上不收取费用";
            infoLabel.textColor = [UIColor grayColor];
            infoLabel.font = [UIFont systemFontOfSize:9];
            [cell.contentView addSubview:infoLabel];
            
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:infoLabel.text];
            UIColor *rcolor = BB_Button_Color;
            [attr addAttribute:NSForegroundColorAttributeName value:rcolor range:NSMakeRange(0, 1)];
            infoLabel.attributedText = attr;
        }
        return cell;
    }
    if (1 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            static NSString *CellIdentifier = @"OrderCell05";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if(cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell setSeparatorInset:UIEdgeInsetsMake(0, 13, 0, 0)];
                cell.backgroundColor = BB_White_Color;
                
                
                UILabel *labLeft = [[[UILabel alloc]init]autorelease];
                labLeft.backgroundColor = [UIColor clearColor];
                labLeft.textAlignment = NSTextAlignmentLeft;
                labLeft.font = [UIFont systemFontOfSize:15];
                labLeft.textColor = BB_Blake;
                [labLeft setFrame:CGRectMake(13, 0, 150, 42)];
                [labLeft setText:@"选择其他提现方式"];
                [cell.contentView addSubview:labLeft];
            }
            
            return cell;
        }
        static NSString * CellIdentifier = @"OrderCell06";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsMake(0, 80, 0, 0)];
            cell.backgroundColor = BB_White_Color;
            
            
            UIImageView *leftImgView = [[[UIImageView alloc]init]autorelease];
            leftImgView.tag = 9;
            [cell.contentView addSubview:leftImgView];
            
            
            UILabel *labLeft = [[[UILabel alloc]init]autorelease];
            labLeft.backgroundColor = [UIColor clearColor];
            labLeft.textAlignment = NSTextAlignmentLeft;
            labLeft.font = [UIFont systemFontOfSize:15];
            labLeft.textColor = BB_Graydark;
            labLeft.tag = 10;
            [cell.contentView addSubview:labLeft];
            
            
            UIImageView *rightImgView = [[[UIImageView alloc]init]autorelease];
            [rightImgView setFrame:CGRectMake(280, 27, 22, 22)];
            rightImgView.tag = 12;
            [cell.contentView addSubview:rightImgView];
        }
        NSMutableArray *temArr = [[[NSMutableArray alloc]initWithObjects:@"支付宝账户提现",@"银联账户提现",@"微信账户提现",nil]autorelease];
        
        
        UIImageView *leftImgView = (UIImageView*)[cell viewWithTag:9];
        if (1 == indexPath.row)
        {
            [leftImgView setFrame:CGRectMake(13, 29, 56, 19.9)];
            [leftImgView setImage:[UIImage imageNamed:@"支付宝.png"]];
        }
        if (2 == indexPath.row)
        {
            [leftImgView setFrame:CGRectMake(15, 24, 51, 27.5)];
            [leftImgView setImage:[UIImage imageNamed:@"银联.png"]];
        }
        if (3 == indexPath.row)
        {
            [leftImgView setFrame:CGRectMake(23, 20, 36, 36)];
            [leftImgView setImage:[UIImage imageNamed:@"微信充值.png"]];
        }
        
        UILabel *labLeft = (UILabel*)[cell viewWithTag:10];
        labLeft.frame = CGRectMake(80, 0, 200, 76.5);
        labLeft.text = [temArr objectAtIndex:indexPath.row-1];
        

        UIImageView *rightImgView = (UIImageView*)[cell viewWithTag:12];
        if (paySection == indexPath.row)
        {
            [rightImgView setImage:[UIImage imageNamed:@"支付方式_选中.png"]];
            [XtomFunction addbordertoView:rightImgView radius:0.0f width:0.0f color:[UIColor clearColor]];
        }else
        {
            [rightImgView setImage:nil];
            [XtomFunction addbordertoView:rightImgView radius:11.0f width:1.0f color:BB_Graylight];
        }
        
        return cell;
    }
    return nil;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footView = [[[UIView alloc] init] autorelease];
    footView.backgroundColor = [UIColor clearColor];
    if (1 == section) {
        
        UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginButton setFrame:CGRectMake(24, 40, WIDTH-48, 42)];
        [loginButton addTarget:self action:@selector(okButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [loginButton setTitle:@"提现" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginButton setBackgroundColor:BB_Button_Color];
        [footView addSubview:loginButton];
    }
    return footView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (1 == section)
    {
        return 10;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (1 == section)
    {
        return 90;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        return 140;
    }
    if (0 == indexPath.row)
    {
        return 42;
    }
    return 76.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isTextField)
    {
        [textFeild resignFirstResponder];
        return;
    }
    if (indexPath.section == 0)
    {
        return;
    }
    paySection = indexPath.row;
    [myTableView reloadData];
}

@end
