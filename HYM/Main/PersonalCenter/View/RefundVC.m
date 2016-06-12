//
//  RefundVC.m
//  PingChuan
//
//  Created by pengli on 15/11/10.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "RefundVC.h"
#import "OrderGoodCell.h"
#import "BWTextView.h"
#import "BWTextView.h"
#import "CTAssetsPickerController.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "StoreDetailVC.h"
#import "RealityDetailVC.h"

@interface RefundVC ()<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, UIActionSheetDelegate, CTAssetsPickerControllerDelegate, UIImagePickerControllerDelegate>
{
    NSInteger uploadNum;
    MBProgressHUD * waitMB;
}
@property (nonatomic, retain) UITableView * myTableView;
@property (nonatomic, retain) BWTextView * mytextView;
@property (nonatomic, retain) UILabel * countLabel;
@property (nonatomic, retain) UIScrollView * picScroll;
@property (nonatomic, retain) BBButton * addBtn;
@property (nonatomic, retain) NSMutableArray * listArray;
@property (nonatomic, copy) NSString * publishId;

@end

@implementation RefundVC
@synthesize myTableView;
@synthesize mytextView;
@synthesize countLabel;
@synthesize picScroll;
@synthesize addBtn;
@synthesize listArray;
@synthesize publishId;
@synthesize dataSource;
@synthesize isSend;

- (void)dealloc
{
    [myTableView release]; myTableView = nil;
    [mytextView release]; mytextView = nil;
    [countLabel release]; countLabel = nil;
    [picScroll release]; picScroll = nil;
    [addBtn release]; addBtn = nil;
    [listArray release]; listArray = nil;
    [publishId release]; publishId = nil;
    [dataSource release]; dataSource = nil;
    
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
    [self.navigationItem setNewTitle:@"申请退款"];
    [self.navigationItem setLeftItemWithTarget:self action:@selector(leftBtnPressed) image:@"common_return.png" imageH:@"common_return.png"];
    [self.view setBackgroundColor:BB_Back_Color_Here];
    
    self.myTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UI_View_Hieght-49) style:UITableViewStyleGrouped]autorelease];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    [myTableView setBackgroundView:nil];
    [myTableView setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 0)];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myTableView];
    
    
    UIView * view3 = [[[UIView alloc] init] autorelease];
    view3.backgroundColor = [UIColor whiteColor];
    view3.frame = CGRectMake(0, UI_View_Hieght-49, WIDTH, 49);
    [self.view addSubview:view3];
    
    UIButton * replyBtn = [[[UIButton alloc] init] autorelease];
    replyBtn.frame = CGRectMake(WIDTH-71, 9.5, 59, 30);
    [replyBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    replyBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [replyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view3 addSubview:replyBtn];
    [replyBtn setHighlighted:NO];
    [replyBtn addTarget:self action:@selector(publishReply:) forControlEvents:UIControlEventTouchUpInside];
    [XtomFunction addbordertoView:replyBtn radius:4 width:0.5 color:[UIColor blackColor]];
    [replyBtn setBackgroundColor:[UIColor whiteColor]];

}

- (void)loadData
{
    uploadNum = 0;
    self.listArray = [[[NSMutableArray alloc] init] autorelease];
}

- (void)leftBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
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
        temImgView.tag = i+100;
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
        photo.srcImageView = (UIImageView*)[self.view viewWithTag:i+100];
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
    [XtomFunction openIntervalHUDOK:@"申请退货成功" view:nil];
   
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}


-(void)keyboardWillShow:(NSNotification *)notification
{
   
    CGFloat animationTime = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:animationTime animations:^{
        CGRect keyBoardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        
        [myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }];
}
-(void)keyboardWillHide:(NSNotification *)notification
{
    [myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section)
    {
        return 3;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        
        if (0 == indexPath.row)
        {
            static NSString *CellIdentifier = @"RefundCell00";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if(cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = BB_White_Color;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                
                UILabel * shopName = [[[UILabel alloc]init]autorelease];
                shopName.backgroundColor = [UIColor clearColor];
                shopName.textAlignment = NSTextAlignmentLeft;
                shopName.font = [UIFont systemFontOfSize:14];
                shopName.textColor = BB_Blake;
                [shopName setFrame:CGRectMake(15, 0, WIDTH-45, 34)];
                shopName.tag = 10;
                [cell.contentView addSubview:shopName];
            }
            
            UILabel * shopName = (UILabel *)[cell viewWithTag:10];
            shopName.text = [dataSource  objectForKey:@"shop_name"];
            
            return cell;
        }
        
        if (2 == indexPath.row)
        {
            static NSString *CellIdentifier = @"RefundCell01";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if(cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.separatorInset = UIEdgeInsetsMake(0, 14, 0, 0);
                cell.backgroundColor = BB_White_Color;
            }else
            {
                for(UIView *view in cell.contentView.subviews)
                {
                    [view removeFromSuperview];
                }
            }
            
            UILabel * shopName = [[[UILabel alloc]init]autorelease];
            shopName.backgroundColor = [UIColor clearColor];
            shopName.textAlignment = NSTextAlignmentLeft;
            shopName.font = [UIFont systemFontOfSize:14];
            shopName.textColor = BB_Blake;
            [shopName setFrame:CGRectMake(15, 0, WIDTH-45, 34)];
            shopName.tag = 10;
            [cell.contentView addSubview:shopName];
            [shopName setText:[NSString stringWithFormat:@"数量：%@", [dataSource objectForKey:@"buycount"]]];
            
            UILabel *labLeft = [[[UILabel alloc]init]autorelease];
            labLeft.backgroundColor = [UIColor clearColor];
            labLeft.textAlignment = NSTextAlignmentRight;
            [labLeft setFrame:CGRectMake(100, 0, 204, 40)];
            [cell.contentView addSubview:labLeft];
            
            NSString *temStr = @"";
            if (!isSend)
            {
               temStr = [NSString stringWithFormat:@"合计：￥%.2f",[[dataSource objectForKey:@"price"] floatValue]*[[dataSource objectForKey:@"buycount"] intValue] + [[dataSource objectForKey:@"shipping_fee"] floatValue]];
            }
            else
            {
                temStr = [NSString stringWithFormat:@"合计：￥%.2f",[[dataSource objectForKey:@"price"] floatValue]*[[dataSource objectForKey:@"buycount"] intValue]];
            }
            
            NSMutableAttributedString *str = [[[NSMutableAttributedString alloc] initWithString:temStr]autorelease];
            
            [str addAttribute:NSForegroundColorAttributeName value:BB_Gray range:NSMakeRange(0,3)];
            [str addAttribute:NSForegroundColorAttributeName value:BB_Blake range:NSMakeRange(3,[str length]-3)];
            
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0,3)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(3,[str length]-3)];
            
            [labLeft setAttributedText:str];
            
            return cell;
        }
        
        static NSString *CellIdentifier = @"RefundCell02";
        OrderGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell == nil)
        {
            cell = [[[OrderGoodCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = BB_White_Color;
        }
        NSString * fileName = [dataSource objectForKey:@"imgurl"];
        [cell.topImgView setImage:[UIImage imageNamed:@"商城_默认广告页3.png"]];
        if(![XtomFunction xfunc_check_strEmpty:fileName])
        {
            NSString *document = [NSString stringWithFormat:@"%@/%@",BB_CASH_DOCUMENT,BB_CASH_AVATAR];
            [[XtomCashManager sharedManager] addImgToImgViewFromDocumentORURL:cell.topImgView document:document url:fileName];
        }
        
        [cell.nameLable setText:[dataSource objectForKey:@"name"]];
        
        cell.goodsPrice.text = [NSString stringWithFormat:@"%.2f元",[[dataSource objectForKey:@"price"] floatValue]];
        cell.priceLable.text = [NSString stringWithFormat:@"X%@", [dataSource objectForKey:@"buycount"]];
        
        return cell;
    }
    if (0 == indexPath.row)
    {
        static NSString *CellIdentifier = @"RefundCell03";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = BB_White_Color;
            
            
            UILabel * shopName = [[[UILabel alloc]init]autorelease];
            shopName.backgroundColor = [UIColor clearColor];
            shopName.textAlignment = NSTextAlignmentLeft;
            shopName.font = [UIFont systemFontOfSize:18];
            shopName.textColor = BB_Blake;
            shopName.text = @"退款总额";
            [shopName setFrame:CGRectMake(15, 0, WIDTH-45, 50)];
            shopName.tag = 10;
            [cell.contentView addSubview:shopName];
        }
        return cell;
    }
    static NSString *CellIdentifier = @"RefundCell04";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = BB_White_Color;
        
        
        UILabel * shopName = [[[UILabel alloc]init]autorelease];
        shopName.backgroundColor = [UIColor clearColor];
        shopName.textAlignment = NSTextAlignmentLeft;
        shopName.font = [UIFont systemFontOfSize:17];
        shopName.textColor = BB_Blake;
        shopName.text = @"退款原因";
        [shopName setFrame:CGRectMake(15, 0, WIDTH-45, 30)];
        shopName.tag = 10;
        [cell.contentView addSubview:shopName];
        
        
        self.mytextView = [[[BWTextView alloc]init]autorelease];
        mytextView.frame = CGRectMake(5, 30, WIDTH-10, 108);
        mytextView.font = [UIFont systemFontOfSize:14];
        mytextView.backgroundColor = [UIColor clearColor];
        mytextView.textAlignment = NSTextAlignmentLeft;
        mytextView.textColor = [UIColor grayColor];
        mytextView.delegate = self;
        mytextView.placeholder = @"请填写退款原因，200字以内";
        mytextView.returnKeyType = UIReturnKeyDefault;
        [cell.contentView addSubview:mytextView];
        
        
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
        
       
        self.countLabel = [[[UILabel alloc] initWithFrame:CGRectMake(5, 138, WIDTH-10, 15)]autorelease];
        countLabel.backgroundColor = [UIColor clearColor];
        countLabel.textColor = [UIColor grayColor];
        countLabel.textAlignment = NSTextAlignmentRight;
        countLabel.font = [UIFont systemFontOfSize:13];
        countLabel.text = [NSString stringWithFormat:@"%d/200",(int)mytextView.text.length];
        [cell.contentView addSubview:countLabel];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footView = [[[UIView alloc] init] autorelease];
    if (1 == section)
    {
        
        self.picScroll = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 100)]autorelease];
        [footView addSubview:picScroll];
        
        self.addBtn = [BBButton buttonWithType:UIButtonTypeCustom];
        [addBtn setFrame:CGRectMake(13, 10, 139/2, 139/2)];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"上传图片默认图.png"] forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(gotoAdd:) forControlEvents:UIControlEventTouchUpInside];
        [picScroll addSubview:addBtn];
        
    }
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (0 == section)
    {
        return 5;
    }
    return 300;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            return 34;
        }
        if (2 == indexPath.row)
        {
            return 40;
        }
        return 95;
    }
    if (0 == indexPath.row)
    {
        return 50;
    }
    return 163;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section && 0 == indexPath.row)
    {
        StoreDetailVC * detail = [[[StoreDetailVC alloc] init] autorelease];
        detail.keyid = [dataSource objectForKey:@"shop_id"];
        [self.navigationController pushViewController:detail animated:YES];
    }
    if (0 == indexPath.section && 1 == indexPath.row)
    {
        RealityDetailVC * detail = [[[RealityDetailVC alloc] init] autorelease];
        NSString * blog_id = [dataSource  objectForKey:@"blog_id"];
        if ([XtomFunction xfunc_check_strEmpty:blog_id])
        {
            return;
        }
        detail.keyid = [dataSource objectForKey:@"blog_id"];
        detail.keytype = @"1";
        [self.navigationController pushViewController:detail animated:YES];
    }
}


- (void)requestReplyAdd
{
    NSString *token = [[XtomManager sharedManager] userToken];
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:token forKey:@"token"];
    [dic setObject:[dataSource objectForKey:@"id"] forKey:@"keyid"];
    [dic setObject:@"3" forKey:@"keytype"];
    [dic setObject:mytextView.text forKey:@"reason"];
    [dic setObject:@"无" forKey:@"description"];
    [dic setObject:@"无" forKey:@"shipping_name"];
    [dic setObject:@"无" forKey:@"shipping_num"];
    waitMB = [XtomFunction openHUD:@"正在申请" view:self.view];
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_BILL_SAVEOPERATE] target:self selector:@selector(responseReplyAdd:) parameter:dic];
}

- (void)responseReplyAdd:(NSDictionary *)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        NSString *str = [[[info objectForKey:@"infor"] objectAtIndex:0] objectForKey:@"goods_id"];
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
                [self requestPublishFile:@"19" keyid:blogid orderby:[NSString stringWithFormat:@"%d",i] data:temData];
            }
        }

    }
    else
    {
        if([info objectForKey:@"msg"])
        {
            [XtomFunction closeHUD:waitMB];
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
