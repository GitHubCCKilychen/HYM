//
//  ReplyVC.m
//  PingChuan
//
//  Created by pengli on 15/11/10.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "ReplyVC.h"
#import "BBButton.h"
#import "BWTextView.h"
#import "CTAssetsPickerController.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@interface ReplyVC ()<UITextViewDelegate, UIActionSheetDelegate, CTAssetsPickerControllerDelegate, UIImagePickerControllerDelegate>
{
    NSInteger firstNum;
    NSInteger secondNum;
    NSInteger thirdNum;
    NSInteger uploadNum;
    MBProgressHUD * waitMB;
}
@property (nonatomic, retain) BWTextView * mytextView;
@property (nonatomic, retain) UILabel * countLabel;
@property (nonatomic, retain) UIScrollView * picScroll;
@property (nonatomic, retain) BBButton * addBtn;
@property (nonatomic, retain) NSMutableArray * listArray;
@property (nonatomic, copy) NSString * publishId;
@end

@implementation ReplyVC
@synthesize mytextView;
@synthesize countLabel;
@synthesize picScroll;
@synthesize addBtn;
@synthesize listArray;
@synthesize publishId;

@synthesize keyid;

- (void)dealloc
{
    [mytextView release]; mytextView = nil;
    [countLabel release]; countLabel = nil;
    [picScroll release]; picScroll = nil;
    [addBtn release]; addBtn = nil;
    [listArray release]; listArray = nil;
    [publishId release]; publishId = nil;
    
    [keyid release]; keyid = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self loadSet];
    [self loadData];
}

- (void)loadSet
{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:NavigationColor];
    [self.navigationItem setNewTitle:@"评价"];
    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftBtnPressed) image:@"common_return.png" imageH:@"common_return.png"];
    [self.view setBackgroundColor:BB_Back_Color_Here];
    
    UIView * view1 = [[[UIView alloc] init] autorelease];
    view1.backgroundColor = [UIColor whiteColor];
    view1.frame = CGRectMake(0, 0, WIDTH, 120);
    [self.view addSubview:view1];
    view1.tag = 1001;
    NSArray * titleArr = @[@"服务态度", @"服务速度", @"服务质量"];
    
    for (int i = 0; i < 3; i++)
    {
        UIView * rowBack = [[[UIView alloc] init] autorelease];
        rowBack.backgroundColor = [UIColor clearColor];
        rowBack.frame = CGRectMake(0, 7.5+35*i, WIDTH, 35);
        [view1 addSubview:rowBack];
        
        UILabel * goodsSource = [[[UILabel alloc]init]autorelease];
        goodsSource.frame = CGRectMake(11, 0, 100, 35);
        goodsSource.backgroundColor = [UIColor clearColor];
        goodsSource.textAlignment = NSTextAlignmentLeft;
        goodsSource.font = [UIFont systemFontOfSize:15];
        [goodsSource setTextColor:BB_Blake];
        [goodsSource setText:titleArr[i]];
        [rowBack addSubview:goodsSource];
    
        for (int j = 0; j < 5; j++)
        {
            BBButton * star = [[[BBButton alloc] init] autorelease];
            star.frame = CGRectMake(84 + j * 18, (35-15)/2, 16.5, 15);
            [star setImage:[UIImage imageNamed:@"store_replylist_star_sel.png"] forState:UIControlStateNormal];
            star.btnRow = i;
            star.btnSection = j;
            star.tag = 10*i + j + 1;
            [rowBack addSubview:star];
            [star setHighlighted:NO];
            [star addTarget:self action:@selector(clickStar:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        UILabel * starNum = [[[UILabel alloc]init]autorelease];
        starNum.frame = CGRectMake(183, 0, 100, 35);
        starNum.backgroundColor = [UIColor clearColor];
        starNum.textAlignment = NSTextAlignmentLeft;
        starNum.font = [UIFont systemFontOfSize:15];
        [starNum setTextColor:BB_Blake];
        [starNum setText:@"5.0"];
        starNum.tag = i + 100;
        [rowBack addSubview:starNum];
    }
    
    UIView * view2 = [[[UIView alloc] init] autorelease];
    view2.backgroundColor = [UIColor whiteColor];
    view2.frame = CGRectMake(0, 126, WIDTH, 210);
    [self.view addSubview:view2];
    view2.tag = 2001;
    
    self.mytextView = [[[BWTextView alloc]init]autorelease];
    mytextView.frame = CGRectMake(5, 10, WIDTH-10, 93);
    mytextView.font = [UIFont systemFontOfSize:14];
    mytextView.backgroundColor = [UIColor clearColor];
    mytextView.textAlignment = NSTextAlignmentLeft;
    mytextView.textColor = [UIColor grayColor];
    mytextView.delegate = self;
    mytextView.placeholder = @"请填写评价，200字以内";
    mytextView.returnKeyType = UIReturnKeyDefault;
    [view2 addSubview:mytextView];
    
    
    UIView *okView = [[[UIView alloc]init]autorelease];
    [okView setFrame:CGRectMake(0, 0, WIDTH, 40)];
    okView.backgroundColor = BB_Back_Color_Here_Bar;
    mytextView.inputAccessoryView = okView;
    
    BBButton *okBtn = [BBButton buttonWithType:UIButtonTypeCustom];
    [okBtn setFrame:CGRectMake(260, 0, 60, 40)];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [okBtn setTitleColor:BB_Blake forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(textOkBtn:) forControlEvents:UIControlEventTouchUpInside];
    [okView addSubview:okBtn];
    
    
    UIView *line = [[[UIView alloc]init]autorelease];
    [line setFrame:CGRectMake(0, 0, WIDTH, 0.5)];
    [line setBackgroundColor:BB_lineColor];
    [okView addSubview:line];
    
    
    self.countLabel = [[[UILabel alloc] initWithFrame:CGRectMake(5, 103, WIDTH-10, 15)]autorelease];
    countLabel.backgroundColor = [UIColor clearColor];
    countLabel.textColor = [UIColor grayColor];
    countLabel.textAlignment = NSTextAlignmentRight;
    countLabel.font = [UIFont systemFontOfSize:13];
    countLabel.text = [NSString stringWithFormat:@"%d/200",(int)mytextView.text.length];
    [view2 addSubview:countLabel];
    
    self.picScroll = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 118, WIDTH, 92)]autorelease];
    [view2 addSubview:picScroll];
    
    self.addBtn = [BBButton buttonWithType:UIButtonTypeCustom];
    [addBtn setFrame:CGRectMake(13, 10, 139/2, 139/2)];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"上传图片默认图.png"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(gotoAdd:) forControlEvents:UIControlEventTouchUpInside];
    [picScroll addSubview:addBtn];
    
    
    UIButton * replyBtn = [[[UIButton alloc] init] autorelease];
    replyBtn.frame = CGRectMake(24, 437-64, WIDTH-48, 39);
    [replyBtn setTitle:@"发布" forState:UIControlStateNormal];
    replyBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [replyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:replyBtn];
    [replyBtn setHighlighted:NO];
    [replyBtn addTarget:self action:@selector(publishReply:) forControlEvents:UIControlEventTouchUpInside];
    
    [replyBtn setBackgroundColor:BB_Button_Color];
}

- (void)loadData
{
    uploadNum = 0;
    firstNum = 5;
    secondNum = 5;
    thirdNum = 5;
    self.listArray = [[[NSMutableArray alloc] init] autorelease];
}

- (void)leftBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickStar:(BBButton *)button
{
    switch (button.btnRow)
    {
        case 0:
        {
            firstNum = button.btnSection+1;
            for (int i = 0; i < 5; i++)
            {
                BBButton * star = (BBButton *)[self.view viewWithTag:i + 1];
                if (i <= button.btnSection)
                {
                    [star setImage:[UIImage imageNamed:@"store_replylist_star_sel.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [star setImage:[UIImage imageNamed:@"store_replylist_star_nor.png"] forState:UIControlStateNormal];
                }
            }
            UILabel * starNum = (UILabel *)[self.view viewWithTag:100];
            starNum.text = [NSString stringWithFormat:@"%ld.0", firstNum];
        }
            break;
        case 1:
        {
            secondNum = button.btnSection+1;
            for (int i = 0; i < 5; i++)
            {
                BBButton * star = (BBButton *)[self.view viewWithTag:i + 1 + 10];
                if (i <= button.btnSection)
                {
                    [star setImage:[UIImage imageNamed:@"store_replylist_star_sel.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [star setImage:[UIImage imageNamed:@"store_replylist_star_nor.png"] forState:UIControlStateNormal];
                }
            }
            UILabel * starNum = (UILabel *)[self.view viewWithTag:101];
            starNum.text = [NSString stringWithFormat:@"%ld.0", secondNum];
        }
            break;
        case 2:
        {
            thirdNum = button.btnSection+1;
            for (int i = 0; i < 5; i++)
            {
                BBButton * star = (BBButton *)[self.view viewWithTag:i + 1 + 20];
                if (i <= button.btnSection)
                {
                    [star setImage:[UIImage imageNamed:@"store_replylist_star_sel.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [star setImage:[UIImage imageNamed:@"store_replylist_star_nor.png"] forState:UIControlStateNormal];
                }
            }
            UILabel * starNum = (UILabel *)[self.view viewWithTag:102];
            starNum.text = [NSString stringWithFormat:@"%ld.0", thirdNum];
        }
            break;
        default:
            break;
    }
}


- (void)textOkBtn:(BBButton *)button
{
    [mytextView resignFirstResponder];
}

- (void)gotoAdd:(id)sender
{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"添加图片" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"相册",@"相机",@"取消", nil];
    [actionSheet setCancelButtonIndex:2];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    AppDelegate *adelegate = [XtomFunction xfuncGetAppdelegate];
    [actionSheet showInView:adelegate.window];
    [actionSheet release];
}


-(void)gotoCam:(id)sender
{
    if (listArray.count == 4)
    {
        [XtomFunction openIntervalHUD:@"图片最多4张" view:self.view];
        return;
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
        [picker release];
    }
    else
    {
        [XtomFunction openIntervalHUD:@"打开相机错误" view:self.view];
    }
}

- (void)gotoPic:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        CTAssetsPickerController *picker = [[[CTAssetsPickerController alloc] init]autorelease];
        picker.maximumNumberOfSelection = 4 - listArray.count;
        picker.assetsFilter = [ALAssetsFilter allPhotos];
        picker.delegate = self;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
    else
    {
        [XtomFunction openIntervalHUD:@"连接到图片库错误" view:self.view];
    }
}


-(void)initMyPicScroll
{
    for (BBButton *temBtn in self.picScroll.subviews)
    {
        [temBtn removeFromSuperview];
    }
    for (int i = 0; i<listArray.count; i++)
    {
        UIImageView *temImgView = [[[UIImageView alloc]init]autorelease];
        temImgView.tag = i+200;
        temImgView.contentMode = UIViewContentModeScaleAspectFill;
        temImgView.clipsToBounds = YES;
        [temImgView setFrame:CGRectMake(13+(13+65)*i, 10, 65, 65)];
        [temImgView setImage:[listArray objectAtIndex:i]];
        [picScroll addSubview:temImgView];
        
        BBButton *picBtn = [BBButton buttonWithType:UIButtonTypeCustom];
        [picBtn setFrame:CGRectMake(13+(13+65)*i, 10, 65, 65)];
        picBtn.btnRow = i;
        [picBtn addTarget:self action:@selector(gotoScan:) forControlEvents:UIControlEventTouchUpInside];
        [picScroll addSubview:picBtn];
        
        BBButton *temBtn = [BBButton buttonWithType:UIButtonTypeCustom];
        temBtn.btnRow = i;
        [temBtn setFrame:CGRectMake(13+(13+65)*i+55, 0, 20, 20)];
        [temBtn setBackgroundImage:[UIImage imageNamed:@"红删除.png"] forState:UIControlStateNormal];
        [temBtn addTarget:self action:@selector(gotoDelete:) forControlEvents:UIControlEventTouchUpInside];
        [picScroll addSubview:temBtn];
    }
    if (listArray.count >= 4)
    {
        return;
    }
    self.addBtn = [BBButton buttonWithType:UIButtonTypeCustom];
    [addBtn setFrame:CGRectMake(13+(13+65)*listArray.count, 10, 65, 65)];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"上传图片默认图.png"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(gotoAdd:) forControlEvents:UIControlEventTouchUpInside];
    [picScroll addSubview:addBtn];
}

- (void)gotoDelete:(BBButton *)sender
{
    [listArray removeObjectAtIndex:sender.btnRow];
    [self initMyPicScroll];
}


-(void)gotoScan:(BBButton*)sender
{
    [mytextView resignFirstResponder];
    
    NSInteger count = listArray.count;
    
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        
        MJPhoto *photo = [[[MJPhoto alloc] init]autorelease];
        photo.image = listArray[i];
        photo.srcImageView = (UIImageView*)[self.view viewWithTag:i+200];
        [photos addObject:photo];
    }
    
    
    MJPhotoBrowser *browser = [[[MJPhotoBrowser alloc] init]autorelease];
    browser.currentPhotoIndex = sender.btnRow;
    browser.photos = photos;
    [browser show];
}

- (void)mypublishOK
{
    [XtomFunction closeHUD:waitMB];
    [XtomFunction openIntervalHUDOK:@"评论成功" view:nil];
   
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}


-(void)keyboardWillShow:(NSNotification *)notification
{
    
    CGFloat animationTime = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:animationTime animations:^{
        CGRect keyBoardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        NSLog(@"%f", keyBoardFrame.size.height);
        UIView * view1 = (UIView *)[self.view viewWithTag:1001];
        view1.frame = CGRectMake(0, -120, WIDTH, 120);
        UIView * view2 = (UIView *)[self.view viewWithTag:2001];
        view2.frame = CGRectMake(0, 0, WIDTH, 210);
        
    }];
}
-(void)keyboardWillHide:(NSNotification *)notification
{
    UIView * view1 = (UIView *)[self.view viewWithTag:1001];
    view1.frame = CGRectMake(0, 0, WIDTH, 120);
    UIView * view2 = (UIView *)[self.view viewWithTag:2001];
    view2.frame = CGRectMake(0, 126, WIDTH, 210);
}


- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    image = [XtomFunction getImage:image];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [listArray addObject:image];
    
    [self initMyPicScroll];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    for (int i = 0; i<assets.count; i++)
    {
        ALAsset *mystr = [assets objectAtIndex:i];
        
        UIImage *image = [UIImage imageWithCGImage:mystr.defaultRepresentation.fullScreenImage];
        image = [XtomFunction getImage:image];
        [listArray addObject:image];
        
        [self initMyPicScroll];
    }
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self gotoPic:nil];
    }
    else if (buttonIndex == 1)
    {
        [self gotoCam:nil];
    }
    else if (buttonIndex == 2)
    {
        NSLog(@"取消");
    }
}


- (void)textViewDidChange:(UITextView *)textView
{
    self.countLabel.text = [NSString stringWithFormat:@"%ld/200",[textView.text length]];
  
    if (textView.text.length > 999)
    {
        textView.text = [textView.text substringToIndex:999];
    }
}

- (void)publishReply:(UIButton *)button
{
    if (firstNum == 0)
    {
        [XtomFunction openIntervalHUD:@"请对服务态度作出评价" view:self.view];
        return;
    }
    if (secondNum == 0)
    {
        [XtomFunction openIntervalHUD:@"请对服务速度作出评价" view:self.view];
        return;
    }
    if (thirdNum == 0)
    {
        [XtomFunction openIntervalHUD:@"请对服务质量作出评价" view:self.view];
        return;
    }
    if ([XtomFunction xfunc_check_strEmpty:mytextView.text])
    {
        [XtomFunction openIntervalHUD:@"文字内容不能为空" view:self.view];
        return;
    }
    if (mytextView.text.length > 200)
    {
        [XtomFunction openIntervalHUD:@"内容不能超过200字" view:self.view];
        return;
    }
    [self requestReplyAdd];
}


- (void)requestReplyAdd
{
    NSString *token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token forKey:@"token"];
    [dic setObject:@"2" forKey:@"keytype"];
    [dic setObject:keyid forKey:@"keyid"];
    [dic setObject:mytextView.text forKey:@"content"];
    [dic setObject:[NSString stringWithFormat:@"%ld", firstNum] forKey:@"stars_attitude"];
    [dic setObject:[NSString stringWithFormat:@"%ld", secondNum] forKey:@"stars_speed"];
    [dic setObject:[NSString stringWithFormat:@"%ld", thirdNum] forKey:@"stars_qulity"];
    waitMB = [XtomFunction openHUD:@"正在发布" view:self.view];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_GOODS_REPLY_ADD] target:self selector:@selector(responseReplyAdd:) parameter:dic];
}

- (void)responseReplyAdd:(NSDictionary *)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        if(![XtomFunction xfunc_check_strEmpty:[info objectForKey:@"infor"]])
        {
            NSString *str = [[[info objectForKey:@"infor"] objectAtIndex:0] objectForKey:@"reply_id"];
            NSString *blogid = [NSString stringWithFormat:@"%@",str];
            self.publishId = blogid;
            
            
            NSMutableArray *ImgArr = self.listArray;
            if (ImgArr.count == 0)
            {
                [self mypublishOK];
            }
            else
            {
                for (int i = 0; i<ImgArr.count; i++)
                {
                    UIImage *img = [ImgArr objectAtIndex:i];
                    NSData *temData = UIImageJPEGRepresentation(img, 0.8);
                    [self requestPublishFile:@"16" keyid:blogid orderby:[NSString stringWithFormat:@"%d",i] data:temData];
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
}

- (void)requestPublishFile:(NSString*)keytype keyid:(NSString*)keyid1 orderby:(NSString*)orderby data:(NSData*)data
{
    NSString *token = [[XtomManager sharedManager] userToken];
    
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token forKey:@"token"];
    [dic setObject:keytype forKey:@"keytype"];
    [dic setObject:keyid1 forKey:@"keyid"];
    [dic setObject:orderby forKey:@"orderby"];
    [dic setObject:data forKey:@"temp_file"];
    [dic setObject:@"无" forKey:@"content"];
    [dic setObject:@"0" forKey:@"duration"];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_UPLOAD_FILE] target:self selector:@selector(responsePublishFile:) parameter:dic];
}
- (void)responsePublishFile:(NSDictionary*)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        uploadNum ++;
        
        NSMutableArray *ImgArr = self.listArray;
        if (uploadNum == ImgArr.count)
        {
            [self mypublishOK];
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
@end
