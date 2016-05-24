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
@interface HYMFormListTable ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong)NSArray *titleArr;
@property (nonatomic,strong)NSArray *textFiledArr;
@property (nonatomic,strong)NSMutableArray *textMs;
@end
@implementation HYMFormListTable

- (NSArray *)titleArr{

    if (_titleArr == nil) {
        
        _titleArr = [NSArray array];
        _titleArr =@[@"真实姓名*",@"身份证号*",@"支付宝账号*",@"常用邮箱*",@"常用QQ*",@"紧急电话*"];
    }
    return _titleArr;
}

- (NSArray *)textFiledArr{
    
    if (_textFiledArr == nil) {
        
        _textFiledArr = [NSArray array];
        _textFiledArr = @[@"请输入您的真实姓名",@"请输入您的身份证号",@"请输入您的支付宝密码",@"请输入您的常用邮箱",@"请输入您的常用QQ",@"请输入您的紧急电话"];
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
                [btn addTarget:self action:@selector(selectedPhoto:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:btn];
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
                textF.keyboardType = UIKeyboardTypeNumberPad;
                [lineView addSubview:textF];
                
                [cell.contentView addSubview:lineView];
            }

        
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (int i = 0; i < self.textFiledArr.count; i++) {
        
        UITextField *textF = [cell.contentView viewWithTag:200+i];
        //此处有问题－－
    }
    
//    NSLog(@"%@",self.textMs);
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
        return 260;
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

- (void)selectedPhoto:(UIButton *)photo{

    //1.获取当前的控制器
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    keyWindow.backgroundColor = [UIColor lightGrayColor];
    keyWindow.alpha = 0.8;
    [keyWindow makeKeyWindow];
    
    //添加view
//    HYMExampleView *view = [[HYMExampleView alloc] init];
//    view.frame = CGRectMake(15, 100, kScreenWitdth-30, 350);
//    
//    [keyWindow addSubview:view];

}

#pragma mark 提交申请
- (void)submit:(UIButton *)btn{

    //1.判断照片是否选择
    
    [self loadData];
    
    
}

#pragma mark 数据
- (void)loadData{
    
    //暂时只是调用
    NSDictionary *dic = @{@"true_name":@"张三",@"qq":@"1300925306",@"alipay":@"1300925306@qq.com",@"bank_card":@"123456789",@"bank":@"山东聊城关系被告",@"email":@"1300925306@qq.com",@"id_card":@"371525199208167249",@"id_card_face":@"http://photocdn.sohu.com/20160520/Img450569241.jpg",@"id_card_back":@"http://photocdn.sohu.com/20160520/Img450569241.jpg",@"id_card_hand":@"http://photocdn.sohu.com/20160520/Img450569241.jpg",@"token":@"1"};
    
    NSMutableDictionary *dics = [NSMutableDictionary dictionaryWithDictionary:dic];
    [XTomRequest requestWithURL:@"http://123.56.237.91/index.php/Webservice/center/apply_center" target:self selector:@selector(loadData:) parameter:dics];
    
    
}

- (void)loadData:(NSDictionary *)dic{
    
//    NSLog(@"%@--%@",dic,[dic objectForKey:@"msg"]);
}

@end
