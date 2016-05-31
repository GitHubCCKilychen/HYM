//
//  PostPublishNewVC.m
//  PingChuan
//
//  Created by pengli on 16/1/12.
//  Copyright © 2016年 平川嘉恒. All rights reserved.
//

#import "PostPublishNewVC.h"
//#import "PublicTypeVC.h"
#import "MyTextView.h"
#import "BBImgView.h"
#import "BWTextView.h"
#import "BBButton.h"
#import "TapGR.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@interface PostPublishNewVC ()<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIGestureRecognizerDelegate>
{
    NSInteger operRow;
    MBProgressHUD * waitMB;
    BOOL isTihuan;
}
@property (nonatomic, retain) UITableView * myTableView;
@property (nonatomic, retain) UITextField * titleTextField;
@property (nonatomic, retain) UIView * tabbarView;
@property (nonatomic, retain) NSMutableArray * uploadArray;
@end

@implementation PostPublishNewVC
@synthesize myTableView;
@synthesize titleTextField;
@synthesize tabbarView;
@synthesize dataArray;
@synthesize dataSource;
@synthesize uploadArray;
@synthesize keytype;
@synthesize isEdit;
@synthesize keyid;
@synthesize isCopy;

- (void)dealloc
{
    [myTableView release]; myTableView = nil;
    [titleTextField release]; titleTextField = nil;
    [tabbarView release]; tabbarView = nil;
    [dataArray release]; dataArray = nil;
    [dataSource release]; dataSource = nil;
    [keyid release]; keyid = nil;
    [uploadArray release]; uploadArray = nil;
    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(infoAction) name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [super viewDidDisappear:animated];
}
- (void)infoAction
{
    if (titleTextField.text.length > 36)
    {
        titleTextField.text = [titleTextField.text substringToIndex:36];
        [XtomFunction openIntervalHUD:@"当前输入超出限制" view:self.view];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSet];
}

- (void)loadSet
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:NavigationColor];
    self.title = @"发表帖子";
//    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftBtnPressed) image:@"common_return.png" imageH:@"common_return.png"];
//    [self.navigationItem setRightItemWithTarget:self action:@selector(gotoPublish) title:@"发布"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.myTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UI_View_Hieght-49) style:UITableViewStylePlain] autorelease];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    [myTableView setBackgroundView:nil];
    [myTableView setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 0)];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myTableView];
    [myTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    if ([myTableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [myTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([myTableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [myTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    self.tabbarView = [[[UIView alloc] init] autorelease];
    [XtomFunction addbordertoView:tabbarView radius:0 width:0.5 color:BB_Gray];
    tabbarView.frame = CGRectMake(-0.5, UI_View_Hieght - 49, WIDTH+1, 49);
    tabbarView.backgroundColor = [UIColor colorWithRed:244/255.f green:244/255.f blue:244/255.f alpha:1];
    [self.view addSubview:tabbarView];
    UIImageView * shareImg = [[[UIImageView alloc] init] autorelease];
    shareImg.userInteractionEnabled = YES;
    shareImg.frame = CGRectMake(11, 6, 36, 36);
    shareImg.image = [UIImage imageNamed:@"帖子_输入文字.png"];
    [tabbarView addSubview:shareImg];
    UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(0, 0, 53, 49);
    [shareBtn addTarget:self action:@selector(gotoAddText) forControlEvents:UIControlEventTouchUpInside];
    [tabbarView addSubview:shareBtn];
    shareBtn.tag = 1;
    UIImageView * commentImg = [[[UIImageView alloc] init] autorelease];
    commentImg.userInteractionEnabled = YES;
    commentImg.frame = CGRectMake(53, 6, 36, 36);
    commentImg.image = [UIImage imageNamed:@"帖子_选择图片.png"];
    [tabbarView addSubview:commentImg];
    UIButton * commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentBtn.frame = CGRectMake(53, 0, 53, 49);
    [commentBtn addTarget:self action:@selector(gotoAddPic) forControlEvents:UIControlEventTouchUpInside];
    [tabbarView addSubview:commentBtn];
    commentBtn.tag = 2;
    self.uploadArray = [[[NSMutableArray alloc] init] autorelease];
    [uploadArray addObjectsFromArray:dataArray];
}
- (void)leftBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)gotoPublish
{
    [self hideKeyboard];
    NSMutableDictionary * temDict = [dataSource objectForKey:@"publicType"];
    if ([XtomFunction xfunc_check_strEmpty:[temDict objectForKey:@"name"]])
    {
        [XtomFunction openIntervalHUD:@"请选择帖子分类" view:self.view];
        return;
    }
    
    if ([XtomFunction xfunc_check_strEmpty:[dataSource objectForKey:@"title"]])
    {
        [XtomFunction openIntervalHUD:@"请补全帖子标题" view:self.view];
        return;
    }
    if (dataArray.count == 0)
    {
        [XtomFunction openIntervalHUD:@"请补全图文详情" view:self.view];
        return;
    }
    for (int i = 0; i < dataArray.count; i++)
    {
        NSMutableDictionary * temDict = [dataArray objectAtIndex:i];
        if ([[temDict objectForKey:@"isPic"] integerValue] == 0)
        {
            if ([XtomFunction xfunc_check_strEmpty:[temDict objectForKey:@"content"]])
            {
                [XtomFunction openIntervalHUD:@"请补全图文详情" view:self.view];
                return;
            }
        }
    }
    [self requestPostAdd];
}
- (void)hideKeyboard
{
    for (int i = 0; i < dataArray.count; i++)
    {
        NSMutableDictionary * temDict = [dataArray objectAtIndex:i];
        if ([[temDict objectForKey:@"isPic"] integerValue] == 0)
        {
            UITableViewCell * temCell1 = (UITableViewCell *)[myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i+2 inSection:0]];
            BWTextView * textField0 = (BWTextView *)[temCell1 viewWithTag:6];
            [textField0 resignFirstResponder];
        }
    }
    [titleTextField resignFirstResponder];
}
- (void)gotoScanBig
{

    int count = 1;
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        NSString *url = [[dataArray objectAtIndex:operRow-2] objectForKey:@"imgurlbig"];
        MJPhoto *photo = [[[MJPhoto alloc] init]autorelease];
        photo.url = [NSURL URLWithString:url];
        UITableViewCell *temCell = (UITableViewCell *)[myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:operRow inSection:0]];
        UIImageView * image = (UIImageView *)[temCell viewWithTag:7];
        photo.srcImageView = image;
        [photos addObject:photo];
    }
    MJPhotoBrowser *browser = [[[MJPhotoBrowser alloc] init]autorelease];
    browser.currentPhotoIndex = 0;
    browser.photos = photos;
    [browser show];
}
- (void)deleteRowWith:(BBButton *)button
{
    [dataArray removeObjectAtIndex:button.btnRow-2];
    [uploadArray removeObjectAtIndex:button.btnRow-2];
    [myTableView reloadData];
}
- (void)gotoAddText
{
    NSMutableDictionary * temDict = [[[NSMutableDictionary alloc] init] autorelease];
    [temDict setObject:@"0" forKey:@"isPic"];
    [dataArray addObject:temDict];
    [uploadArray addObject:temDict];
    [myTableView reloadData];
}
- (void)gotoAddPic
{
    isTihuan = NO;
    operRow = dataArray.count+2;
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"添加图片" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"相册",@"相机",@"取消", nil];
    [actionSheet setCancelButtonIndex:2];
    actionSheet.delegate = self;
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    AppDelegate *adelegate = [XtomFunction xfuncGetAppdelegate];
    [actionSheet showInView:adelegate.window];
    actionSheet.tag = 99;
    [actionSheet release];
}
- (void)handlemySingleTap:(TapGR *)tap
{
    isTihuan = YES;
    operRow = tap.touchRow;
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"添加图片" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"查看大图",@"相册",@"相机",@"取消", nil];
    [actionSheet setCancelButtonIndex:3];
    actionSheet.delegate = self;
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    AppDelegate *adelegate = [XtomFunction xfuncGetAppdelegate];
    [actionSheet showInView:adelegate.window];
    actionSheet.tag = 999;
    [actionSheet release];
}
- (void)textOkBtn:(BBButton *)button
{
    UITableViewCell * temCell = [myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:operRow inSection:0]];
    MyTextView * textView1 = (MyTextView *)[temCell viewWithTag:6];
    [textView1 resignFirstResponder];
}
-(void)gotoCam:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
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
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
        [picker release];
    }
    else
    {
        [XtomFunction openIntervalHUD:@"连接到图片库错误" view:self.view];
    }
}
-(void)actionActive
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25f];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:nil cache:NO];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:nil];
}
- (void)mypublishOK
{
    [XtomFunction closeHUD:waitMB];
    [XtomFunction openIntervalHUDOK:@"发布成功" view:nil];
    NSNotification *notification = [NSNotification notificationWithName:PUBLISH_BLOG_SUCCEED object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)selectType:(NSMutableDictionary *)paraDic
{
    [self.dataSource setObject:paraDic forKey:@"publicType"];
    [myTableView reloadData];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 99)
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
            
        }
    }
    if (actionSheet.tag == 999)
    {
        if (buttonIndex == 0)
        {
            [self gotoScanBig];
        }
        else if (buttonIndex == 1)
        {
            [self gotoPic:nil];
        }
        else if (buttonIndex == 2)
        {
            [self gotoCam:nil];
        }
        else if (buttonIndex == 3)
        {
            
        }
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    if (isTihuan)
    {
        NSMutableDictionary * temDict = [dataArray objectAtIndex:operRow-2];
        [temDict setObject:@"1" forKey:@"isPic"];
        [temDict setObject:@"1" forKey:@"isLocal"];
        [temDict setObject:image forKey:@"image"];
        [myTableView reloadData];
        [picker dismissViewControllerAnimated:YES completion:nil];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
        NSData *temData = UIImageJPEGRepresentation(image, 0.8);
        [self requestImageAddFromLocal:@"21" keyid:@"0" orderby:@"0" data:temData duration:@"0"];
    }
    else
    {
        image = [XtomFunction getImage:image];
        NSMutableDictionary * temDict = [[[NSMutableDictionary alloc] init] autorelease];
        [temDict setObject:@"1" forKey:@"isPic"];
        [temDict setObject:@"1" forKey:@"isLocal"];
        [temDict setObject:image forKey:@"image"];
        [dataArray addObject:temDict];
        [uploadArray addObject:temDict];
        [myTableView reloadData];
        [picker dismissViewControllerAnimated:YES completion:nil];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
        NSData *temData = UIImageJPEGRepresentation(image, 0.8);
        [self requestImageAddFromLocal:@"21" keyid:@"0" orderby:@"0" data:temData duration:@"0"];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (BOOL)textViewShouldBeginEditing:(BWTextView *)textView
{
    operRow = textView.viewRow;
    [myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:operRow inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    return YES;
}
- (BOOL)textViewShouldEndEditing:(BWTextView *)textView
{
    NSMutableDictionary * temDict = [dataArray objectAtIndex:operRow-2];
    [temDict setObject:textView.text forKey:@"content"];
    [myTableView reloadData];
    return [textView resignFirstResponder];
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [dataSource setObject:titleTextField.text forKey:@"title"];
    [myTableView reloadData];
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [titleTextField resignFirstResponder];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2+dataArray.count+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row)
    {
        static NSString * cellID = @"PublishCell00";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = BB_White_Color;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text = @"帖子分类";
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor colorWithRed:48/255.f green:49/255.f blue:53/255.f alpha:1];
        if (![XtomFunction xfunc_check_strEmpty:[[dataSource objectForKey:@"publicType"] objectForKey:@"name"]])
        {
            cell.detailTextLabel.text = [[dataSource objectForKey:@"publicType"] objectForKey:@"name"];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
            cell.detailTextLabel.textColor = [UIColor colorWithRed:144/255.f green:147/255.f blue:149/255.f alpha:1];
        }
        return cell;
    }
    if (1 == indexPath.row)
    {
        static NSString * cellID = @"PublishCell01";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = BB_White_Color;
            self.titleTextField = [[[UITextField alloc]init]autorelease];
            titleTextField.textColor = [UIColor blackColor];
            titleTextField.font = [UIFont systemFontOfSize:15];
            titleTextField.placeholder = @"标题（最多36字符）";
            titleTextField.delegate = self;
            [titleTextField setValue:BB_Gray forKeyPath:@"_placeholderLabel.textColor"];
            titleTextField.frame = CGRectMake(16, 0, WIDTH-30, 50);
            titleTextField.textAlignment = NSTextAlignmentLeft;
            titleTextField.clearButtonMode = UITextFieldViewModeNever;
            titleTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            titleTextField.returnKeyType = UIReturnKeyDone;
            [cell.contentView addSubview:titleTextField];
        }
        if (![XtomFunction xfunc_check_strEmpty:[dataSource objectForKey:@"title"]])
        {
            titleTextField.text = [dataSource objectForKey:@"title"];
        }
        return cell;
    }
    if (2+dataArray.count == indexPath.row)
    {
        static NSString * cellID = @"PublishCell02";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = BB_White_Color;
        }
        return cell;
    }
    static NSString * cellID = @"PublishCell03";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = BB_White_Color;
        cell.separatorInset = UIEdgeInsetsMake(0, WIDTH, 0, 0);
        BWTextView * contentTextView = [[[BWTextView alloc] init] autorelease];
        contentTextView.frame = CGRectMake(15, 16, WIDTH-30, 126);
        contentTextView.tag = 6;
        contentTextView.font = [UIFont systemFontOfSize:15];
        contentTextView.backgroundColor = [UIColor clearColor];
        contentTextView.textAlignment = NSTextAlignmentLeft;
        contentTextView.textColor = [UIColor blackColor];
        contentTextView.delegate = self;
        contentTextView.placeholder = @"请输入内容";
        contentTextView.returnKeyType = UIReturnKeyDefault;
        contentTextView.autocorrectionType = NO;
        contentTextView.autocapitalizationType = NO;
        [XtomFunction addbordertoView:contentTextView radius:2 width:0.5 color:BB_Graylight];
        [cell.contentView addSubview:contentTextView];
        UIView * keyView = [[[UIView alloc]init]autorelease];
        [keyView setFrame:CGRectMake(0, 0, WIDTH, 49)];
        keyView.backgroundColor = [UIColor colorWithRed:246/255.f green:246/255.f blue:246/255.f alpha:1];
        contentTextView.inputAccessoryView = keyView;
        BBButton * sureBtn = [BBButton buttonWithType:UIButtonTypeCustom];
        [sureBtn setFrame:CGRectMake(260, 0, 60, 49)];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [sureBtn setTitleColor:BB_Blake forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(textOkBtn:) forControlEvents:UIControlEventTouchUpInside];
        [keyView addSubview:sureBtn];
        UIView *line = [[[UIView alloc]init]autorelease];
        [line setFrame:CGRectMake(0, 0, WIDTH, 0.5)];
        [line setBackgroundColor:BB_lineColor];
        [keyView addSubview:line];
        BBImgView * image = [[[BBImgView alloc] initWithFrame:CGRectMake(13, 21, WIDTH-26, 148)] autorelease];
        image.tag = 7;
        image.contentMode = UIViewContentModeScaleAspectFill;
        image.clipsToBounds = YES;
        image.userInteractionEnabled = YES;
        [cell.contentView addSubview:image];
        UIImageView * deleteImage = [[[UIImageView alloc] init] autorelease];
        deleteImage.frame = CGRectMake(WIDTH-31, 8.5, 20.5, 20.5);
        deleteImage.image = [UIImage imageNamed:@"发布帖子_删除.png"];
        [cell.contentView addSubview:deleteImage];
        BBButton * deleteBtn = [BBButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setFrame:CGRectMake(WIDTH-40, 0, 40, 50)];
        [deleteBtn setTitleColor:BB_Blake forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteRowWith:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:deleteBtn];
        deleteBtn.tag = 8;
    }
    BWTextView * textView = (BWTextView *)[cell viewWithTag:6];
    textView.delegate = self;
    textView.viewRow = indexPath.row;
    BBImgView * image = (BBImgView *)[cell viewWithTag:7];
    image.imgRow = indexPath.row;
    image.userInteractionEnabled = YES;
    TapGR *temTap = [[[TapGR alloc] initWithTarget:self action:@selector(handlemySingleTap:)]autorelease];
    [image addGestureRecognizer:temTap];
    temTap.numberOfTapsRequired = 1;
    temTap.numberOfTouchesRequired = 1;
    temTap.touchRow = indexPath.row;
    temTap.touchI = indexPath.section;
    temTap.delegate = self;
    BBButton * deleteBtn = (BBButton *)[cell viewWithTag:8];
    deleteBtn.btnRow = indexPath.row;
    NSMutableDictionary * temDict = [dataArray objectAtIndex:indexPath.row-2];
    if ([[temDict objectForKey:@"isPic"] integerValue] == 0)
    {
        [textView setHidden:NO];
        [image setHidden:YES];
        textView.text = [temDict objectForKey:@"content"];
    }
    else
    {
        [textView setHidden:YES];
        [image setHidden:NO];
        if ([[temDict objectForKey:@"isLocal"] integerValue] == 0)
        {
            NSString *downavatar = [temDict objectForKey:@"imgurl"];
            image.image = [UIImage imageNamed:@"商城_默认广告页1.png"];
            if(![XtomFunction xfunc_check_strEmpty:downavatar])
            {
                NSString *document = [NSString stringWithFormat:@"%@/%@",BB_CASH_DOCUMENT,BB_CASH_AVATAR];
                [[XtomCashManager sharedManager] addImgToImgViewFromDocumentORURL:image document:document url:downavatar];
            }
        }
        else
        {
            image.image = [temDict objectForKey:@"image"];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row || 1 == indexPath.row)
    {
        return 47;
    }
    if (2+dataArray.count == indexPath.row)
    {
        return UI_View_Hieght;
    }
    NSMutableDictionary * temDict = [dataArray objectAtIndex:indexPath.row-2];
    if ([[temDict objectForKey:@"isPic"] integerValue] == 0)
    {
        return 142;
    }
    return 172;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row)
    {
//        PublicTypeVC * type = [[[PublicTypeVC alloc] init] autorelease];
//        type.keytype = self.keytype;
//        type.delegate = self;
//        [self.navigationController pushViewController:type animated:YES];
    }
}
- (void)requestPostAdd
{
    NSString *token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token forKey:@"token"];
    if (isEdit)
    {
        [dic setObject:keyid forKey:@"id"];
    }
    [dic setObject:[dataSource objectForKey:@"title"] forKey:@"name"];
    switch (keytype)
    {
        case 2:
        {
            [dic setObject:@"8" forKey:@"blogtype"];
        }
            break;
        case 3:
        {
            [dic setObject:@"3" forKey:@"blogtype"];
        }
            break;
        case 5:
        {
            [dic setObject:@"5" forKey:@"blogtype"];
        }
            break;
        default:
            break;
    }
    [dic setObject:@"无" forKey:@"typeid"];
    [dic setObject:@"无" forKey:@"leftcount"];
    [dic setObject:@"无" forKey:@"price"];
    [dic setObject:@"无" forKey:@"oldprice"];
    [dic setObject:@"无" forKey:@"expressfee"];
    [dic setObject:@"无" forKey:@"expressfeeforfree"];
    [dic setObject:@"无" forKey:@"costcode"];
    [dic setObject:@"无" forKey:@"content"];
    [dic setObject:@"无" forKey:@"startdate"];
    [dic setObject:@"无" forKey:@"enddate"];
    [dic setObject:@"无" forKey:@"district_name"];
    [dic setObject:@"无" forKey:@"from"];
    [dic setObject:@"无" forKey:@"from_website"];
    [dic setObject:[[dataSource objectForKey:@"publicType"] objectForKey:@"id"] forKey:@"public_type"];
    waitMB = [XtomFunction openHUD:@"正在发布" view:self.view];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_BLOG_ADD] target:self selector:@selector(responsePostAdd:) parameter:dic];
}
- (void)responsePostAdd:(NSDictionary *)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        NSMutableArray * contentArray = [[[NSMutableArray alloc] init] autorelease];
        NSString * content = @"";
        if (isEdit)
        {
            for (int i = 0; i < uploadArray.count; i++)
            {
                NSMutableDictionary * temDict = [uploadArray objectAtIndex:i];
                if ([[temDict objectForKey:@"isPic"] integerValue] == 0)
                {
                    [contentArray addObject:[NSString stringWithFormat:@"c%@", [temDict objectForKey:@"content"]]];
                }
                else
                {
                    [contentArray addObject:[NSString stringWithFormat:@"i%@,%@", [temDict objectForKey:@"imgurl"], [temDict objectForKey:@"imgurlbig"]]];
                }
            }
            content = [contentArray componentsJoinedByString:@"|hYmheMA|"];
            NSLog(@"content:%@", content);
            [self requestContent:keyid content:content];
        }
        else
        {
            if(![XtomFunction xfunc_check_strEmpty:[info objectForKey:@"infor"]])
            {
                NSString *str = [[[info objectForKey:@"infor"] objectAtIndex:0] objectForKey:@"blog_id"];
                NSString *blogid = [NSString stringWithFormat:@"%@",str];
                
                for (int i = 0; i < uploadArray.count; i++)
                {
                    NSMutableDictionary * temDict = [uploadArray objectAtIndex:i];
                    if ([[temDict objectForKey:@"isPic"] integerValue] == 0)
                    {
                        [contentArray addObject:[NSString stringWithFormat:@"c%@", [temDict objectForKey:@"content"]]];
                    }
                    else
                    {
                        [contentArray addObject:[NSString stringWithFormat:@"i%@,%@", [temDict objectForKey:@"imgurl"], [temDict objectForKey:@"imgurlbig"]]];
                    }
                }
                content = [contentArray componentsJoinedByString:@"|hYmheMA|"];
                [self requestContent:blogid content:content];
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
- (void)requestContent:(NSString *)blog_id content:(NSString *)content
{
    NSString *token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token forKey:@"token"];
    [dic setObject:blog_id forKey:@"blog_id"];
    [dic setObject:content forKey:@"content"];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_BLOG_CONTENT_SAVE] target:self selector:@selector(responseContentAdd:) parameter:dic];
}
-(void)responseContentAdd:(NSDictionary *)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        [self mypublishOK];
    }
    else
    {
        if([info objectForKey:@"msg"])
        {
            [XtomFunction openIntervalHUD:[info objectForKey:@"msg"] view:self.view];
        }
    }
}
- (void)requestImageAddFromLocal:(NSString*)keytype1 keyid:(NSString*)keyid1 orderby:(NSString*)orderby data:(NSData*)data duration:(NSString *)duration
{
    NSString *token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
//    [dic setObject:token forKey:@"token"];
    [dic setObject:keytype1 forKey:@"keytype"];
    [dic setObject:keyid1 forKey:@"keyid"];
    [dic setObject:orderby forKey:@"orderby"];
    [dic setObject:data forKey:@"temp_file"];
    [dic setObject:@"无" forKey:@"content"];
    [dic setObject:duration forKey:@"duration"];
    waitMB = [XtomFunction openHUD:@"正在上传图片" view:self.view];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_UPLOAD_FILE] target:self selector:@selector(responseImageAddFromLocal:) parameter:dic];
}
- (void)responseImageAddFromLocal:(NSDictionary *)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        [XtomFunction closeHUD:waitMB];
        if(![XtomFunction xfunc_check_strEmpty:[info objectForKey:@"infor"]])
        {
            NSMutableDictionary * temDict = [uploadArray objectAtIndex:operRow-2];
            [temDict setObject:[[[info objectForKey:@"infor"] objectAtIndex:0] objectForKey:@"item1"] forKey:@"imgurl"];
            [temDict setObject:[[[info objectForKey:@"infor"] objectAtIndex:0] objectForKey:@"item2"] forKey:@"imgurlbig"];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
