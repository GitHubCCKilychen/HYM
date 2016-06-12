//
//  SendReplyVC.m
//  DDwork
//
//  Created by 平川嘉恒 on 13-12-17.
//  Copyright (c) 2013年 Admin. All rights reserved.
//

#define CountLegth 1000

#import "SendReplyVC.h"
#import "Navbar.h"
#import "XtomConst.h"

@interface SendReplyVC ()
{
    MBProgressHUD *waitMB;
}
@end

@implementation SendReplyVC
@synthesize mytextView;
@synthesize countLabel;

@synthesize delegate;
@synthesize sendType;
@synthesize blogid;
@synthesize authorId;
@synthesize cliendId;
@synthesize nickname;
@synthesize publishContent;
@synthesize keytype;
@synthesize isPush;

-(void)dealloc
{
    [mytextView release];mytextView = nil;
    [countLabel release];countLabel = nil;
    
    [authorId release];authorId = nil;
    [cliendId release];cliendId = nil;
    [nickname release];nickname = nil;
    [publishContent release];publishContent = nil;
    [keytype release];keytype = nil;
    [super dealloc];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [mytextView resignFirstResponder];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadSet];
}
-(void)loadSet
{
    
    [self.view setBackgroundColor:BB_Back_Color_Here];
    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftbtnPressed:) image:@"common_return.png" imageH:@"common_return.png"];
    [self.navigationItem setRightItemWithTarget:self action:@selector(rightbtnPressed:) title:@"提交"];
    
   
    UIView *allBackView = [[[UIView alloc]init]autorelease];
    allBackView.frame = CGRectMake(0, 0, WIDTH, 145);
    [XtomFunction addbordertoView:allBackView radius:1.0f width:1.0f color:BB_Border_Color];
    [allBackView setBackgroundColor:BB_White_Color];
    [self.view addSubview:allBackView];
    
    
    self.mytextView = [[[BWTextView alloc]init]autorelease];
    mytextView.frame = CGRectMake(10, 0, WIDTH-20, 125);
    mytextView.font = [UIFont systemFontOfSize:16];
    mytextView.backgroundColor = [UIColor clearColor];
    mytextView.textAlignment = NSTextAlignmentLeft;
    mytextView.textColor = [UIColor grayColor];
    mytextView.delegate = self;
    [mytextView becomeFirstResponder];
    [allBackView addSubview:mytextView];
    
    
    self.countLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 120, 314, 29)]autorelease];
    countLabel.backgroundColor = [UIColor clearColor];
    countLabel.textColor = [UIColor grayColor];
    countLabel.textAlignment = NSTextAlignmentRight;
    countLabel.font = [UIFont systemFontOfSize:13];
    [allBackView addSubview:countLabel];
    
    if (sendType == ContentTypeReply)
    {
        [self.navigationItem setNewTitle:@"我要评论"];
        mytextView.placeholder = @"请输入内容...";
        [self.navigationItem setRightItemWithTarget:self action:@selector(rightbtnPressed:) title:@"发表"];
    }else if (sendType == ContentTypeInfor)
    {
       
        if ([keytype integerValue] == 3)
        {
            [self.navigationItem setNewTitle:@"店铺详情"];
            mytextView.text = publishContent;
        }
        else if ([keytype integerValue] == 4)
        {
            [self.navigationItem setNewTitle:@"详情描述"];
            mytextView.text = publishContent;
        }
        else if ([keytype integerValue] == 5)
        {
            [self.navigationItem setNewTitle:@"拒绝原因"];
        }
        else
        {
            [self.navigationItem setNewTitle:@"详细地址"];
            mytextView.text = publishContent;
        }
    }else if (sendType == ContentTypeReport)
    {
        [self.navigationItem setNewTitle:@"意见反馈"];
        mytextView.placeholder = @"请输入您对软件的建议和意见";
        mytextView.text = publishContent;
    }else if (sendType == ContentTypeVIP)
    {
        [self.navigationItem setNewTitle:@"vip申请"];
        mytextView.placeholder = @"请填写vip申请书...";
        mytextView.text = publishContent;
    }
    countLabel.text = [NSString stringWithFormat:@"%d/%d",(int)mytextView.text.length,(int)CountLegth];
}

-(void)leftbtnPressed:(id)sender
{
    NSString *temStr = mytextView.text;
    temStr = [temStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if(0 == temStr.length)
    {
        [self goBack];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"还未提交,确定要返回吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.delegate = self;
        alert.tag = 1;
        [alert show];
        [alert release];
    }
}
-(void)rightbtnPressed:(id)sender
{
    if (mytextView.text.length == 0)
    {
        [XtomFunction openIntervalHUD:@"文本框不能为空" view:self.view];
        return;
    }
    
   
    [mytextView resignFirstResponder];
    
    if (sendType == ContentTypeReply)
    {
        [self requestSaveReply];
    }
    if (sendType == ContentTypeReport)
    {
        [self requestSaveAdvice];
    }
    if (sendType == ContentTypeInfor)
    {
        [delegate sendReplyOK:ContentTypeInfor content:mytextView.text];
        [self goBack];
    }
    if (sendType == ContentTypeVIP)
    {
        [delegate sendReplyOK:ContentTypeVIP content:mytextView.text];
        [self goBack];
    }
}

-(void)goBack
{
    
    if (isPush)
    {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [mytextView resignFirstResponder];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(1 == alertView.tag&&1 == buttonIndex)
    {
        [self goBack];
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if(textView.text.length > CountLegth)
    {
        textView.text = [textView.text substringToIndex:CountLegth];
    }
    countLabel.text = [NSString stringWithFormat:@"%d/%d",(int)textView.text.length,(int)CountLegth];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    
}
- (void)requestSaveReply
{
    NSString *token = [[XtomManager sharedManager] userToken];
    
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token forKey:@"token"];
    [dic setObject:self.keytype forKey:@"keytype"];
    [dic setObject:self.blogid forKey:@"keyid"];
    [dic setObject:self.cliendId forKey:@"buy_id"];
    [dic setObject:mytextView.text forKey:@"content"];
    
    waitMB = [XtomFunction openHUD:@"正在评论" view:self.view];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_REPLY_ADD] target:self selector:@selector(responseSaveReply:) parameter:dic];
}
- (void)responseSaveReply:(NSDictionary*)info
{
    [XtomFunction closeHUD:waitMB];
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        [delegate sendReplyOK:ContentTypeReply content:nil];
        [self goBack];
    }else
    {
        if([info objectForKey:@"msg"])
        {
            [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:self.view];
        }
    }
}

- (void)requestSaveAdvice
{
    NSString *token = [[XtomManager sharedManager] userToken];
    
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token forKey:@"token"];
    [dic setObject:mytextView.text forKey:@"content"];
    
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_SAVE_ADVICE] target:self selector:@selector(responseSaveAdvice:) parameter:dic];
}
- (void)responseSaveAdvice:(NSDictionary*)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        [delegate sendReplyOK:ContentTypeReport content:nil];
        [self goBack];
    }else
    {
        if([info objectForKey:@"msg"])
        {
            [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:self.view];
            [self.navigationItem.rightBarButtonItem setEnabled:YES];
        }
    }
}
@end

