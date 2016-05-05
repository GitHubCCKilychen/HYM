//
//  HYMFormTableView.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/29.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMFormTableView.h"

@interface HYMFormTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSArray *cellTitle;
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)NSArray *placeholderArr;

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
        self.scrollEnabled = NO;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }

    [HYMTool initLabel:cell.textLabel withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = self.cellTitle[indexPath.row];
        _textField = [[UITextField alloc] init];
        _textField.frame = CGRectMake(100, 10, 200, 20);
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.placeholder = self.placeholderArr[indexPath.row];
        [cell.contentView addSubview:_textField];
        
    }else{
    
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 80, 20)];
        title.text = @"截图示范*";
        [HYMTool initLabel:title withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
        [cell.contentView addSubview:title];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(title.frame.size.width+10, 10, kScreenWitdth*0.6, 90);
        button.backgroundColor = [UIColor grayColor];
        [button addTarget:self action:@selector(getPhotoAct:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
    }
    
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if (indexPath.section == 1) {
        
        return 220.f;
    }
    
    return 44.0f;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

#pragma mark 调取相机图片
- (void)getPhotoAct:(UIButton *)getPhoto{

    //读取相册
    
}

@end
