//
//  HYMFormListTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/17.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMFormListTable.h"
#import "HYMInfoSectionView.h"
#import "HYMExampleView.h"
#import "HYMInfoBottom.h"
#import "PhotoView.h"

@interface HYMFormListTable ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property (nonatomic,strong)NSArray *titleArr;
@property (nonatomic,strong)NSArray *textFiledArr;
@property (nonatomic,strong)NSMutableArray *textMs;
@property (nonatomic,weak)UIButton *btn;
@end
@implementation HYMFormListTable

- (NSArray *)titleArr{

    if (_titleArr == nil) {
        
        _titleArr = [NSArray array];
        _titleArr =@[@"真实姓名*",@"身份证号*",@"支付宝账号*",@"银行卡号",@"开户行*",@"常用邮箱*",@"常用QQ*",@"紧急电话*"];
    }
    return _titleArr;
}

- (NSArray *)textFiledArr{
    
    if (_textFiledArr == nil) {
        
        _textFiledArr = [NSArray array];
        _textFiledArr = @[@"请输入您的真实姓名",@"请输入您的身份证号",@"请输入您的支付宝密码",@"请输入银行卡号",@"开户行",@"请输入您的常用邮箱",@"请输入您的常用QQ",@"紧急电话"];
    }
    return _textFiledArr;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.textMs = [NSMutableArray array];
        
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        if (indexPath.section == 1) {
            
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(15, 15, 23, 21.5);
            imageView.image = [UIImage imageNamed:@"ID"];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            
            [cell.contentView addSubview:imageView];
            
            UILabel *title = [[UILabel alloc] init];
            title.frame = CGRectMake(40, 15, kScreenWitdth-25, 20);
            title.textColor = [UIColor orangeColor];
            title.text = @"上传证件照片（身份证正面，反面，手持）";
            title.font = [UIFont systemFontOfSize:13];
            
            NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor orangeColor],NSFontAttributeName:[UIFont systemFontOfSize:15]};
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:title.text];
            [string addAttributes:dic range:NSMakeRange(0, 6)];
            title.attributedText = string;
            [cell.contentView addSubview:title];
            
            CGFloat btnWidth = (kScreenWitdth-40)/3;
            
            for (int i = 0; i < 3; i++) {
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(15+i*btnWidth+i*5, 45, btnWidth, 95);
                btn.backgroundColor = [UIColor grayColor];
                btn.tag = i;
                [btn addTarget:self action:@selector(selectedPhoto:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:btn];
                
//                self.btn = btn;
            }
            
            CGFloat y = 45+ 30+95;
            UIButton *submit = [UIButton buttonWithType:UIButtonTypeCustom];
            submit.frame = CGRectMake(15, y, kScreenWitdth-30, 35);
            submit.backgroundColor = [UIColor orangeColor];
            submit.layer.cornerRadius = 3;
            [submit setTitle:@"提交申请" forState:UIControlStateNormal];
            [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [submit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
            submit.titleLabel.font = [UIFont systemFontOfSize:15];
            submit.titleLabel.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:submit];
        }
        if (indexPath.section == 0) {
            
            
            for (int i = 0; i < self.titleArr.count; i++) {
                
                UIView *lineView = [[UIView alloc] init];
                lineView.frame = CGRectMake(15, 8 +i*38+i*5, kScreenWitdth-30, 30);
                lineView.layer.borderColor = [UIColor lightGrayColor].CGColor;
                lineView.layer.borderWidth = 0.5;
                lineView.layer.cornerRadius = 3;
                lineView.userInteractionEnabled = YES;
                [self addSubview:lineView];
                
                UILabel *title = [[UILabel alloc] init];
                title.frame = CGRectMake(0, 5, 72, 20);
                title.text = self.titleArr[i];
                title.tag = 100;
                title.font = [UIFont systemFontOfSize:13];
                title.textAlignment = NSTextAlignmentCenter;
                [lineView addSubview:title];
                
                UITextField *textF = [[UITextField alloc] init];
                textF.frame = CGRectMake(80, 5, lineView.frame.size.width-75, 20);
                textF.placeholder = self.textFiledArr[i];
                textF.font = [UIFont systemFontOfSize:13];
                textF.delegate = self;
                textF.tag = 200+i;
                [textF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
                [lineView addSubview:textF];
                
                [cell.contentView addSubview:lineView];
            }

        
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        
        return 75;
    }
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 350;
    }
    
    return 245;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0) {
     
        HYMInfoSectionView *view = [[HYMInfoSectionView alloc] init];
        view.frame = CGRectMake(0, 0, kScreenWitdth, 0);
        return view;

    }
    return nil;
}

- (void)selectedPhoto:(UIButton *)photos{

    self.btn = photos ;
    [self photoIndex:photos.tag];
    
    switch (photos.tag) {
        case 0:
            
        {
        
            //获取图片
            NSString *fullPath = [[NSHomeDirectory() stringByAppendingString:@"Documents"] stringByAppendingString:@"avatar.png"];
            self.photo1 = fullPath;
        }
            break;
        case 1:{
        
            //获取图片
            NSString *fullPath = [[NSHomeDirectory() stringByAppendingString:@"Documents"] stringByAppendingString:@"avatar.png"];
            self.photo2 = fullPath;
        }
            break;
        case 2:{
        
            //获取图片
            NSString *fullPath = [[NSHomeDirectory() stringByAppendingString:@"Documents"] stringByAppendingString:@"avatar.png"];
            self.photo3 = fullPath;
        }
            break;
        default:
            break;
    }
  
 
  
}

- (void)photoIndex:(NSInteger )index{

    //调用相机
    
    if (IOS8) {
        
        UIAlertController *alertVC= [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIAlertAction *photo = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
            }];
            
            [alertVC addAction:photo];
        }
        
        
        UIAlertAction *pic = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //进入相册选择图片
            UIImagePickerController *imagePic = [[UIImagePickerController alloc] init];
            imagePic.delegate = self;
            imagePic.allowsEditing = YES;
            imagePic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self.viewController presentViewController:imagePic animated:YES completion:nil];
        }];
        
        
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        
        [alertVC addAction:pic];
        
        [alertVC addAction:cancle];
        
        
        [self.viewController presentViewController:alertVC animated:YES completion:nil];
    }else{
        
        UIActionSheet *sheet;
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            sheet = [[UIActionSheet alloc] initWithTitle:@"相册" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照从相册中选择" otherButtonTitles:nil, nil];
        }else{
            
            sheet = [[UIActionSheet alloc] initWithTitle:@"相册" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照从相册中选择" otherButtonTitles:nil, nil];
            
        }
        
        [sheet showInView:self];
        
    }
}
#pragma mark ios 7
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    NSUInteger soureType = 0;
    
    
}
#pragma mark 保存到本地沙河
- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName{

    NSData *imageData = UIImageJPEGRepresentation(currentImage, 1);
    NSString *fullPath = [NSHomeDirectory() stringByAppendingString:@"Documents"];
    [imageData writeToFile:fullPath atomically:NO];

}
#pragma mark 获取缓存图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    
    switch (self.btn.tag) {
        case 0:
            //设置图片显示
        {
        
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            
            [self saveImage:image withName:@"photo1.png"];
            NSString *fullPath = [NSHomeDirectory() stringByAppendingString:@"Documents"];
            UIImage *saveImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
            [self.btn setImage:saveImage forState:UIControlStateNormal];
        }
            
            break;
        case 1:
            //设置图片显示
        {
            
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            
            [self saveImage:image withName:@"photo3.png"];
            NSString *fullPath = [NSHomeDirectory() stringByAppendingString:@"Documents"];
            UIImage *saveImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
            [self.btn setImage:saveImage forState:UIControlStateNormal];
        }
            break;
        case 2:
            //设置图片显示
        {
        
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            
            [self saveImage:image withName:@"photo3.png"];
            NSString *fullPath = [NSHomeDirectory() stringByAppendingString:@"Documents"];
            UIImage *saveImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
            [self.btn setImage:saveImage forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
    
}
- (void)textFieldDidChange:(UITextField *)textField{

    switch (textField.tag-200) {
        case 0:
            self.name = textField.text;
            break;
        case 1:
            self.cardNum = textField.text;
            break;
        case 2:
            
            self.apply = textField.text;
            break;
        case 3:
            self.bandNum = textField.text;
            break;
        case 4:
            self.cardAddress = textField.text;
            break;
        case 5:
            self.qqEmails = textField.text;
            break;
        case 6:
            self.qq = textField.text;
        case 7:
            self.phoneNum = textField.text;
            break;
        default:
            break;
    }
}
#pragma mark 提交申请
- (void)submit:(UIButton *)btn{
    
    //1.判断照片是否选择
    
    if (self.name == nil || self.name == NULL || self.cardNum ==nil || self.cardNum == NULL || self.apply == nil || self.apply == NULL ||
        self.qqEmails == nil || self.qqEmails == NULL || self.bandNum ==nil ||self.bandNum == NULL||self.cardAddress == nil || self.cardAddress == NULL || self.qq == nil || self.qq == NULL || self.phoneNum == nil || self.phoneNum == NULL) {
       
        NSLog(@"请重新输入");
    }else{
    
     
        [self loadData:self.name cardNum:self.cardNum apply:self.apply qqEmails:self.qqEmails qq:self.qq bandNum:self.bandNum cardAddress:self.cardAddress phone:self.phoneNum photoOne:self.photo1 photoTwo:self.photo2 photoThree:self.photo3];
    }
    
}
//
#pragma mark 数据
- (void)loadData:(NSString *)name cardNum:(NSString *)cardNum apply:(NSString *)apply qqEmails:(NSString *)qqEmails qq:(NSString *)qq bandNum:(NSString *)bandNum cardAddress:(NSString *)cardAddress phone:(NSString *)phoneNum photoOne:(NSString *)photo1 photoTwo:(NSString *)photo2 photoThree:(NSString *)photo3{
    
    //
    //暂时只是调用
    NSDictionary *dic = @{@"true_name":name,@"qq":qq,@"alipay":apply,@"bank_card":bandNum,@"bank":self.cardAddress,@"email":qqEmails,@"id_card":@"371525199208167249",@"emergcall":phoneNum ,@"id_card_face":photo1,@"id_card_back":photo2,@"id_card_hand":photo3,@"token":@"1"};
    
    NSMutableDictionary *dics = [NSMutableDictionary dictionaryWithDictionary:dic];
    [XTomRequest requestWithURL:@"http://123.56.237.91/index.php/Webservice/center/apply_center" target:self selector:@selector(loadData:) parameter:dics];
}

- (void)loadData:(NSDictionary *)dic{
    
   
    NSLog(@"%@－%@",dic,[dic objectForKey:@"msg"]);
    //提示
  
}
@end
