//
//  HYMSettingTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/13.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMSettingTable.h"

@interface HYMSettingTable ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation HYMSettingTable

- (NSArray *)titleArr{

    if (_titleArr == nil) {
        _titleArr = [NSArray array];
        _titleArr = @[@"账户管理",@"软件分享",@"意见反馈",@"关于我们",@"清理缓存",@"联系客服",@"客服电话:",@"客服QQ:",@"客服微信:"];
    }
    return _titleArr;
}

- (NSArray *)imageArr{

    if (_imageArr == nil) {
        
        _imageArr = [NSArray array];
        _imageArr = @[@"a0",@"a1"];
    }
    return _imageArr;
}

- (NSArray *)lastTitleArr{

    if (_lastTitleArr == nil) {
        
        _lastTitleArr = [NSArray array];
        _lastTitleArr = @[@"0531-888888888",@"8800114444",@"haoyangmao"];
    }
    return _lastTitleArr;
}
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 1) {
        return 1;
    }
    
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        if (indexPath.section == 0) {
            
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(50, 10, 80, 20);
            label.tag = 2;
            label.text = self.titleArr[indexPath.row];
            [HYMTool initLabel:label withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
            [cell.contentView addSubview:label];
            if (indexPath.row<6) {
                
                UIImageView *imageView= [[UIImageView alloc] init];
                imageView.frame = CGRectMake(15, 14.5, 15, 15);
                imageView.tag = 1;
                [cell.contentView addSubview:imageView];
                
                switch (indexPath.row) {
                    case 0:imageView.image = [UIImage imageNamed:@"account"];
                        break;
                    case 1: imageView.image= [UIImage imageNamed:@"share"];break;
                    case 2: imageView.image= [UIImage imageNamed:@"yijianfankan"];break;
                    case 3:imageView.image = [UIImage imageNamed:@"guanyuwomen"];
                        break;
                    case 4:imageView.image = [UIImage imageNamed:@"qinglihuancun"];
                        break;
                    case 5:imageView.image = [UIImage imageNamed:@"lianxikefu"];
                        break;
                    default:
                        break;
                }
            }else if(indexPath.row < 9 && indexPath.row >=6){
                
                label.frame = CGRectMake(50, 10, 80, 20);
                
                UILabel *title = [[UILabel alloc] init];
                title.frame = CGRectMake(130, 10, kScreenWitdth/2, 20);
                title.text = self.lastTitleArr[indexPath.row < 9&& indexPath.row > 6];
                [HYMTool initLabel:title withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor lightGrayColor] withTextAlignment:NSTextAlignmentLeft];
                [cell.contentView addSubview:title];
                
            }
        }
        
       
        if (indexPath.section == 1) {
            
            
           UIButton * exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            exitBtn.frame = CGRectMake(15, 25, kScreenWitdth-30, 38);
            [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
            [exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            exitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            exitBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            exitBtn.backgroundColor = [UIColor orangeColor];
            exitBtn.layer.cornerRadius= 5;
            [cell.contentView addSubview:exitBtn];
            cell.backgroundColor = [UIColor colorWithRed:221/256.f green:223/256.f blue:224/256.f alpha:1];
        }
    
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1) {
    
        return 110;
    }
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}
@end
