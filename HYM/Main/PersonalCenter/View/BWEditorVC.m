//
//  BWEditorVC.m
//  BAOWEN
//
//  Created by 平川嘉恒 on 13-10-12.
//  Copyright (c) 2013年 平川嘉恒. All rights reserved.
//

#import "BWEditorVC.h"
#import "Navbar.h"
#define NUMBERS @"0123456789\n"

@interface BWEditorVC ()
@property (nonatomic,retain)UIView *backView;//白色背景框
@property (nonatomic,retain)UITextField *myTextField;
@property (nonatomic,retain)UILabel *myLabel;//下面的提示语句
@property (nonatomic,retain)UIPickerView *myPicker;//选择器
@property (nonatomic,retain)UIDatePicker *myDatePicker;//时间筛选器
@property (nonatomic,retain)NSDateFormatter *myDateFormatter;//筛选样式
@end

@implementation BWEditorVC
@synthesize editorType;
@synthesize key;
@synthesize title;
@synthesize content;
@synthesize explanation;
@synthesize placeholder;
@synthesize mymaxlength;
@synthesize keyBoardType;
@synthesize dataSource;
@synthesize delegate;

//私有的
@synthesize backView;
@synthesize myTextField;
@synthesize myLabel;
@synthesize myPicker;
@synthesize myDatePicker;
@synthesize myDateFormatter;
@synthesize isPrice;
@synthesize isNum;

-(void)dealloc
{
    [key release];key = nil;
    [title release];title = nil;
    [content release];content = nil;
    [explanation release];explanation = nil;
    [placeholder release];placeholder = nil;
    [dataSource release];dataSource = nil;
    
    [backView release];backView = nil;
    [myTextField release];myTextField = nil;
    [myLabel release];myLabel = nil;
    [myPicker release];myPicker = nil;
    [myDatePicker release];myDatePicker = nil;
    [myDateFormatter release];myDateFormatter = nil;
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(infoAction) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [super viewDidDisappear:animated];
}

- (void)infoAction
{
    if (isPrice)
    {
        // 限制输入钱数两位
        if ([myTextField.text isEqualToString:@"."])
        {
            myTextField.text = @"0.";
        }
        if ([myTextField.text isEqualToString:@"0"])
        {
            myTextField.text = @"0.";
        }
        NSInteger count = 0;
        for (int j = 0; j < [myTextField.text length]; j++)
        {
            char s = [myTextField.text characterAtIndex:j];
            if (s == '.' )
            {
                count++;
            }
        }
        NSMutableString * str = [NSMutableString stringWithString:myTextField.text];
        if (count>1)
        {
            [str deleteCharactersInRange:NSMakeRange(myTextField.text.length-1, 1)];
            count = 1;
        }
        myTextField.text = str;
         
         // 限制小数点后只输入两位
         // 取消小数点后的字符，截取前两位
        if (count == 1)
        {
            NSRange range1 = [myTextField.text rangeOfString:@"."];
            NSArray * arr = [myTextField.text componentsSeparatedByString:@"."];
            if (arr.count > 1)
            {
                NSString * str = arr[1];
                if (str.length > 2)
                {
                    myTextField.text = [myTextField.text substringWithRange:NSMakeRange(0, range1.location+3)];
                }
            }
         
        }
         
    }
    if (isNum)
    {
        if ([myTextField.text isEqualToString:@"0"])
        {
            myTextField.text = @"";
        }
    }
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
    [self.navigationItem setNewTitle:title];
    [self.view setBackgroundColor:BB_Back_Color_Here];
    //[self.navigationItem setLeftItemWithTarget:self action:@selector(leftbtnPressed:) image:@"返回.png" imageH:@"返回-点击.png"];
    //[self.navigationItem setLeftItemWithTarget:self action:@selector(leftbtnPressed:) image:@"箭头-640.png" imageH:@"箭头-640.png"];
    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftbtnPressed:) image:@"common_return.png" imageH:@"common_return.png"];
    /*
     if (BWEditorTypeNormalPick == editorType)
     {
     [self.navigationItem setRightItemWithTarget:self action:@selector(rightbtnPressed:) title:@"完成"];
     }
     */
    [self.navigationItem setRightItemWithTarget:self action:@selector(rightbtnPressed:) title:@"完成"];
    //白色背景
    self.backView = [[[UIView alloc]init]autorelease];
    backView.frame = CGRectMake(8, 10, 304, 40);
    [backView setBackgroundColor:BB_White_Color];
    [XtomFunction addbordertoView:backView radius:1.0f width:1.f color:BB_Border_Color];
    [self.view addSubview:backView];
    
    //输入框
    self.myTextField = [[[UITextField alloc]initWithFrame:CGRectMake(10, 5, 284, 30)]autorelease];
    myTextField.delegate = self;
    myTextField.placeholder = placeholder;
    myTextField.text = content;
    myTextField.keyboardType = self.keyBoardType;
    myTextField.returnKeyType = UIReturnKeyDone;
    myTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    myTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    myTextField.textAlignment = NSTextAlignmentLeft;
    myTextField.font = [UIFont systemFontOfSize:14];
    myTextField.textColor = [UIColor grayColor];
    myTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [backView addSubview:myTextField];
    
    //提示语
    self.myLabel = [[[UILabel alloc]init]autorelease];
    myLabel.backgroundColor = [UIColor clearColor];
    myLabel.textAlignment = NSTextAlignmentRight;
    myLabel.font = [UIFont systemFontOfSize:12];
    myLabel.frame = CGRectMake(0, backView.frame.size.height+15, 312, 14);
    myLabel.userInteractionEnabled = NO;
    myLabel.textColor = [UIColor grayColor];
    myLabel.text = explanation;
    [self.view addSubview:myLabel];
    
    if (BWEditorTypeSinleInput == editorType)
    {
        [myTextField becomeFirstResponder];
        [myPicker setHidden:YES];
    }
    if (BWEditorTypeNormalPick == editorType)
    {
        //选择器
        self.myPicker = [[[UIPickerView alloc]init]autorelease];
        myPicker.dataSource = self;
        myPicker.delegate = self;
        [myPicker reloadAllComponents];
        myPicker.showsSelectionIndicator = YES;
        myPicker.frame = CGRectMake(0.0f, UI_View_Hieght-216.0f, 320.0f, 216.0f);
        [self.view addSubview:myPicker];
        
        [myTextField setEnabled:NO];
        [myLabel setHidden:YES];
        for(int i = 0;i<dataSource.count;i++)
        {
            if([myTextField.text isEqualToString:[dataSource objectAtIndex:i]])
            {
                [myPicker selectRow:i inComponent:0 animated:NO];
                break;
            }
        }
    }
    if (BWEditorTypeTimePick == editorType)
    {
        //时间筛选器
        self.myDateFormatter = [[[NSDateFormatter alloc] init]autorelease];
        [myDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        
        self.myDatePicker = [[[UIDatePicker alloc]init]autorelease];
        [myDatePicker setBackgroundColor:BB_White_Color];
        NSLocale * locale = [[NSLocale alloc] initWithLocaleIdentifier:@"Chinese"];
        [self.myDatePicker setLocale:locale];
        myDatePicker.datePickerMode = UIDatePickerModeDateAndTime;
        [myDatePicker setDate:[myDateFormatter dateFromString:myTextField.text] animated:NO];
        [myDatePicker setFrame:CGRectMake(0.0f, UI_View_Hieght-216, 320.0f, 216.0f)];
        [myDatePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:myDatePicker];
        
        [myTextField setEnabled:NO];
        [myLabel setHidden:YES];
    }
}
-(void)loadData
{
    
}
#pragma mark- 自定义
#pragma mark 事件
-(void)leftbtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightbtnPressed:(id)sender
{
    if (isPrice)
    {
        if ([myTextField.text isEqualToString:@"0."])
        {
            [XtomFunction openIntervalHUD:@"价格输入不正确，请重新输入" view:self.view];
            return;
        }
    }
    [self okGoback];
}
//点击完成
-(void)okGoback
{
    NSString *temStr = myTextField.text;
    if (myTextField.text.length >= mymaxlength)
    {
        temStr = [myTextField.text substringWithRange:NSMakeRange(0, mymaxlength)];
    }
    [delegate inforEditer:self backValue:temStr];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 时间选择
-(void)dateChanged:(id)sender
{
    NSDate *selected = [myDatePicker date];
    NSString *destDateString = [myDateFormatter stringFromDate:selected];
    [myTextField setText:destDateString];
    NSLog(@"选取的时间：%@",destDateString);
    destDateString = [NSString stringWithFormat:@"%@:00",[destDateString substringWithRange:NSMakeRange(0, 16)]];
}
#pragma mark - Touch delegate
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[myTextField resignFirstResponder];
}

// 限制输入两位
#pragma mark - UITextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (isPrice)
    {
        if (string.length != 0)
        {
            NSLog(@"哈哈，不是删除");
        }
        else
        {
            if ([myTextField.text isEqualToString:@"0."])
            {
                myTextField.text = @"";
            }
        }
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
    [myTextField resignFirstResponder];
    [self okGoback];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}
#pragma mark- UIPickerView Datasource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return dataSource.count;
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [dataSource objectAtIndex:row];
}
#pragma mark- UIPickerView Delegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    myTextField.text = [dataSource objectAtIndex:row];
    
}
@end
