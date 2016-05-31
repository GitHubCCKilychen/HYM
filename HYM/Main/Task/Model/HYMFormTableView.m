//
//  HYMFormTableView.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/29.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMFormTableView.h"
#import "HYMPublishVC.h"
@interface HYMFormTableView ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong)NSArray *cellTitle;
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)NSArray *placeholderArr;
@property (nonatomic,strong)UITableViewCell *cell;

@end

@implementation HYMFormTableView

-(NSArray *)cellTitle{

    if (_cellTitle == nil) {
        
        _cellTitle = [NSArray array];
        
        _cellTitle = @[@"姓名*",@"联系电话*",@"微信账号*"];
    }
    return _cellTitle;
}

-(NSArray *)placeholderArr{

    if (_placeholderArr == nil) {
        _placeholderArr = [NSArray array];
        _placeholderArr = @[@"请输入您的姓名",@"请输入您的电话",@"请输入您的微信账号"];
    }
    return _placeholderArr;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
//        self.scrollEnabled = NO;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardBack:)];
        [self addGestureRecognizer:tap];
        
    }
    
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        
        return 3;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    _cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    
    if (_cell == nil) {
        
        _cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    if (indexPath.section == 0) {
        _cell.textLabel.text = self.cellTitle[indexPath.row];
        UITextField *text = [[UITextField alloc] init];
        text.frame = CGRectMake(100, 10, _cell.frame.size.width*0.7, 20);
        text.tag = 2;
        text.font = [UIFont systemFontOfSize:15];
        text.clearButtonMode = UITextFieldViewModeWhileEditing;
        text.delegate = self;
        text.clearsOnBeginEditing = YES;
        [_cell.contentView addSubview:text];
        
    }else if(indexPath.section == 1){
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 80, 20)];
        title.tag = 3;
        [HYMTool initLabel:title withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
        [_cell.contentView addSubview:title];
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(title.frame.size.width+10, 10, kScreenWitdth*0.6, 90);
        button.backgroundColor = [UIColor colorWithRed:234/255.f green:235/255.f blue:236/255.f alpha:1];
        [button setImage:[UIImage imageNamed:@"任务截图"] forState:UIControlStateNormal];
        button.tag = 4;
        [_cell.contentView addSubview:button];
        
        UILabel *beizhu = [[UILabel alloc] init];
        beizhu.frame = CGRectMake(15, 110, 80, 20);
        beizhu.tag = 5;
        [HYMTool initLabel:beizhu withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
        [_cell.contentView addSubview:beizhu];
        
        UIView *editView = [[UIView alloc] init];
        editView.frame = CGRectMake(beizhu.frame.size.width+10, 110, kScreenWitdth*0.6, 90);
        editView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        editView.layer.borderWidth = 0.5;
        [_cell.contentView addSubview:editView];
        
        
        UITextField *textF = [[UITextField alloc] init];
        textF.frame = CGRectMake(27, 0, editView.frame.size.width - 27, editView.frame.size.height);
        textF.tag = 7;
        textF.placeholder = @"请输入备注";
        textF.delegate = self;
        textF.font = [UIFont systemFontOfSize:15];
        [editView addSubview:textF];
        
    }else{
        
        _cell.backgroundColor = [UIColor colorWithRed:234/255.f green:235/255.f blue:236/255.f alpha:1];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 20, kScreenWitdth, 35);
        [btn setTitle:@"提交" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor orangeColor]];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.layer.cornerRadius = 5;
        [btn addTarget:self action:@selector(submitAct:) forControlEvents:UIControlEventTouchUpInside];
        [_cell.contentView  addSubview:btn];
    }
    
    UITextField *textF = (UITextField *)[_cell.contentView viewWithTag:2];
    textF.placeholder = self.placeholderArr[indexPath.row];
    
    UILabel *title = (UILabel *)[_cell.contentView viewWithTag:3];
    title.text = @"截图示范*";
    
    UIButton *btn = (UIButton *)[_cell.contentView viewWithTag:4];
    [btn addTarget:self action:@selector(getPhotoAct:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *beizhu = (UILabel *)[_cell.contentView viewWithTag:5];
    beizhu.text = @"添加备注*";
    return _cell;
}

//位置上移
//--在4上有问题
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    UITextField *text = [self viewWithTag:7];
    CGFloat offset = self.frame.size.height - (text.frame.origin.y + text.frame.size.height+50+216);
    
    if (offset < 0) {
        
        [UIView animateWithDuration:0.35 animations:^{
            
            CGRect frame = self.frame;
            frame.origin.y = offset;
            self.frame = frame;
        }];
    }
    return YES;
}

//恢复原来的位置
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    [UIView animateWithDuration:0.35 animations:^{
        
        CGRect frame = self.frame;
        frame.origin.y = 0.0+100;
        self.frame = frame;
    }];
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [self endEditing:YES];
    return YES;
}

//点击空白处收回键盘
- (void)keyBoardBack:(UITapGestureRecognizer *)tap{

    [self.textField resignFirstResponder];
    
    self.textField.backgroundColor = [UIColor grayColor];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if (indexPath.section == 1) {
        
        return 230;
    }else if (indexPath.section == 2){
    
        return 110;
    }
    
    return 44.0f;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}

#pragma mark 调取相机图片
- (void)getPhotoAct:(UIButton *)getPhoto{

    //读取相册
    
    //拍照
    
    
}

#pragma mark 提交按钮
- (void)submitAct:(UIButton *)btn{
    UITextField *text = [self.cell viewWithTag:2];
    NSLog(@"%@",text.placeholder);

    //判断必填项是否完整
    HYMPublishVC *pulishVC = [[HYMPublishVC alloc] init];
    [self.viewController.navigationController pushViewController:pulishVC animated:YES];
}
@end
