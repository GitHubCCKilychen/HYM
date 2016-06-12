//
//  HYMInfoTable.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/16.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMInforTable.h"
#import "HYMInfoSectionView.h"
#import "HYMInfoBottom.h"
#import "HYMInforModel.h"
#import "ChooseCityVC.h"
@interface HYMInforTable  ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong)NSArray *titleArr;
@property (nonatomic,weak)UITextField *texF;
@end
@implementation HYMInforTable


-(NSArray *)titleArr{
    
    if (_titleArr == nil) {
        
        _titleArr = [NSArray array];
        _titleArr = @[@"昵称",@"性别",@"所在地区"];
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

#pragma mark 数据
- (void)setDatalist:(NSMutableArray *)datalist{

    _datalist = datalist;

    [self reloadData];
}

#pragma mark DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        
        HYMInfoBottom *view = [[HYMInfoBottom alloc] init];
        view.frame = CGRectMake(0, 0, kScreenWitdth, 260);
        view.tag = 10;
        [cell.contentView addSubview:view];
        HYMInforModel *model = self.datalist[indexPath.section];
        view.model = model;
        
    }
 
    
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
        
        HYMInforModel *model = self.datalist[indexPath.row];
        
        NSArray *imgArr = @[model.id_card_face,model.id_card_back,model.id_card_hand];
        
        for (int i = 0; i < 3; i++) {
            
            UIImageView  *image = [[UIImageView alloc] init];
            image.frame = CGRectMake(15+i*btnWidth+i*5, 45, btnWidth, 95);
    
            [image sd_setImageWithURL:[NSURL URLWithString:imgArr[i]]];
            [cell.contentView addSubview:image];
        }
    }
    
    return cell;
}

#pragma mark  选择年龄
- (void)ageAct:(UIButton *)btn{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

 
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        
        return 260;
    }
    return 175;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    
    return  0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0.0001;
    }

    return 15;
}

@end
