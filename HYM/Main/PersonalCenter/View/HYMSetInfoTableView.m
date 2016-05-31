//
//  HYMSetInfoTableView.m
//  注册
//
//  Created by 刘晓雪 on 16/4/19.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMSetInfoTableView.h"
#import "UIView+UIViewController.h"
#import "HYMSecionView.h"
#import "PhotoView.h"
@interface HYMSetInfoTableView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSArray *titleArr;
@end

@implementation HYMSetInfoTableView

-(NSArray *)titleArr{

    if (_titleArr == nil) {
        
        _titleArr = [NSArray array];
        _titleArr = @[@"昵称",@"性别",@"手机号"];
    }
    return _titleArr;
}
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self = [super initWithFrame:frame style:style]) {
        
        
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}


#pragma mark DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        
        return 2;
    }else if(section == 2){
    
        return 1;
    }

    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone; 
        if (indexPath.section == 0) {
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = self.titleArr[indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.textLabel.textColor = [UIColor grayColor];
            if (indexPath.row == 0) {
                
                UITextField *name = [[UITextField alloc] init];
                name.frame = CGRectMake(kScreenWitdth/2, 10, kScreenWitdth/1.5, 20);
                name.placeholder = @"请输入昵称(不能超过五个字符)";
                name.font = [UIFont systemFontOfSize:13];
                [cell.contentView addSubview:name];
            }else if(indexPath.row == 1){
                
                UISegmentedControl *sex = [[UISegmentedControl alloc] initWithItems:@[@"男",@"女"]];
                sex.frame = CGRectMake(kScreenWitdth-70, 10, 60, 20);
                sex.selectedSegmentIndex = 1;
                sex.tintColor = [UIColor orangeColor];
                [cell.contentView addSubview:sex];
            }else if (indexPath.row == 2){
                
        
                UITextField *name = [[UITextField alloc] init];
                name.frame = CGRectMake(kScreenWitdth/2,10,kScreenWitdth/1.5, 20);
                name.placeholder = @"请输入您常用的手机号)";
                name.font = [UIFont systemFontOfSize:13];
                [cell.contentView addSubview:name];
            }
        }
        
        else if (indexPath.section == 1){
        
            if (indexPath.row == 1) {
                
                cell.backgroundColor = [UIColor colorWithRed:234/256.f  green:234/256.f blue:234/256.f alpha:1];
                cell.textLabel.textColor = [UIColor lightGrayColor];
                cell.textLabel.text = @"注：个人信息不能修改，若有变化请联系官方客服";
                cell.textLabel.font = [UIFont systemFontOfSize:12];
                NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor orangeColor]};
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:cell.textLabel.text];
                [string addAttributes:dic range:NSMakeRange(0, 2)];
                cell.textLabel.attributedText = string;
            }else if(indexPath.row ==0){
         
                HYMSecionView *view = [[HYMSecionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth, 220)];
                [cell.contentView addSubview:view];
            }
        }
        
        
        else if (indexPath.section == 2){
        
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
            [submit setTitle:@"提交" forState:UIControlStateNormal];
            [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            submit.titleLabel.font = [UIFont systemFontOfSize:15];
            submit.titleLabel.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:submit];
        }
        
    }
    
    
    
    return cell;
}

#pragma mark  选择年龄
- (void)ageAct:(UIButton *)btn{

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 2) {
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 1) {
        
        return 15;
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
            return 220;
        }
    }else if (indexPath.section == 2){
    
        return 230;
    }
    
    return 44.f;
}

#pragma mark 相册选择
- (void)selectedPhoto:(UIButton *)btn{

    
    UIView *aView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    aView.backgroundColor = [UIColor colorWithRed:157/255.f green:158/255.f blue:159/255.f alpha:1];
    
    PhotoView *photoView  = [[PhotoView alloc] initWithFrame:CGRectMake(15,105,kScreenWitdth-30,kScreenHeight-200)];
    photoView.backgroundColor = [UIColor whiteColor];
    [aView addSubview:photoView];
    // 当前顶层窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    // 添加到窗口
    [window addSubview:aView];
}
@end
