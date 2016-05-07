//
//  HYMFriendsView.m
//  HYM
//
//  Created by 11、 on 16/5/7.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMFriendsView.h"

@interface HYMFriendsView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSArray *sectionTitle;
@end
@implementation HYMFriendsView

- (NSArray *)sectionTitle{

    if (_sectionTitle == nil) {
        
        _sectionTitle = [NSArray array];
        _sectionTitle = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    }
    return _sectionTitle;
}
-(UITableView *)talbeView{

    if (_talbeView == nil) {
        _talbeView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _talbeView.dataSource = self;
        _talbeView.delegate = self;
        _talbeView.showsVerticalScrollIndicator =NO;
        //更改索引颜色值
        _talbeView.sectionIndexColor = [UIColor orangeColor];
    }
    return _talbeView;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self initWithView];
        
        
    }
    return self;
}

- (void)initWithView{

    [self addSubview:self.talbeView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }

    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell ) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else{
    
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    
    UIImageView *iconImage = [[UIImageView alloc] init];
   
    iconImage.frame = CGRectMake(15, 10, 37.5, 37.5);
    iconImage.image = [UIImage imageNamed:@"aaa"];
    [cell.contentView addSubview:iconImage];
    
    UILabel *userName = [[UILabel alloc] init];
    
   
        userName.frame = CGRectMake(iconImage.frame.size.width+30, 15, kScreenWitdth/4, 20);
        
        [HYMTool initLabel:userName withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
        [cell.contentView addSubview:userName];
    
    //此处复用问题
    UILabel *userID = [[UILabel alloc] init];
    
    
    userID.frame = CGRectMake(kScreenWitdth/2, 15, kScreenWitdth/4, 20);
    
   
    [cell.contentView addSubview:userID];


    if (indexPath.section == 0) {
        
        iconImage.image = [UIImage imageNamed:@"bbb"];
        userName.text = @"我的私人客服";
        userName.textColor = [UIColor orangeColor];
        userName.frame = CGRectMake(iconImage.frame.size.width+30, 15, kScreenWitdth/3, 20);
        userID.text = @"工号:98765432f1";
        userName.font = [UIFont systemFontOfSize:16];
        userID.frame = CGRectMake(kScreenWitdth/2+20, 15, kScreenWitdth/3, 20);
        userID.font = [UIFont systemFontOfSize:12];
        userID.textColor = [UIColor lightGrayColor];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:userID.text];
        [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 3)];
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
        userID.attributedText = attStr;
        
       
    }else{
        
        iconImage.image = [UIImage imageNamed:@"aaa"];
        userName.text = @"青春的小草";
        userID.text = @"ID:12345678";
        userID.font = [UIFont systemFontOfSize:12];
        userID.textColor = [UIColor lightGrayColor];
        
        //ID：黑色其余灰色
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:userID.text];
        [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 3)];
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
        userID.attributedText = attStr;
    }
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.sectionTitle.count+1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        
        return nil;
    }else{
    
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, kScreenWitdth, 15);
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(15, 0, 15, 15);
        title.text = self.sectionTitle[section-1];
        
        title.font = [UIFont systemFontOfSize:13];
        title.textColor = [UIColor grayColor];
       
        
        
        [view addSubview:title];
        return view;
    }
    
}

//索引
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    return self.sectionTitle;
    
}
//索引单击
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{

//    NSLog(@"%d",(int)index);
    
    //单击返回到第一个的位置
    if (index == 0) {
        
        [tableView setContentOffset:CGPointZero animated:YES];
        return 1;
    }else{
    
        return index+1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        
        return 0.001;
    }
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 57.5;
}
@end
