//
//  HYMWholeCell.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/13.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMWholeCell.h"

@implementation HYMWholeCell

- (UIImageView *)iconImage{

    if (_iconImage == nil) {
        
        _iconImage = [[UIImageView alloc] init];
    }
    return _iconImage;
}

- (UILabel *)storeName{

    if (_storeName == nil) {
        
        _storeName = [[UILabel alloc] init];
    }
    return _storeName;
}

- (UILabel *)stats{

    if (_stats == nil) {
        
        _stats = [[UILabel alloc] init];
    }
    return _stats;
}

- (UIImageView *)storeImage{

    if (_storeImage == nil) {
        
        _storeImage = [[UIImageView alloc] init];
    }
    return _storeImage;
}

- (UILabel *)storeTitle{

    if (_storeTitle == nil) {
        
        _storeTitle = [[UILabel alloc] init];
        _storeTitle.numberOfLines = 0;
    }
    return _storeTitle;
}

- (UILabel *)price{

    if (_price == nil) {
        
        _price = [[UILabel alloc] init];
    }
    return _price;
}

- (UILabel *)total{

    if (_total == nil) {
        
        _total = [[UILabel alloc] init];
    }
    return _total;
}

- (UIButton *)deleteOrder{

    if (_deleteOrder == nil) {
        
        _deleteOrder = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
    }
    return _deleteOrder;
}

- (UIButton *)comment{

    if (_comment == nil) {
        
        _comment = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _comment;
}

- (UIView *)backView{

    if (_backView == nil) {
        
        _backView = [[UIView alloc] init];
    }
    return _backView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        
        [self initView];
    }
    return self;
}

- (void)initView{

    [self.contentView addSubview:self.iconImage];
    [self.contentView addSubview:self.storeName];
    [self.contentView addSubview:self.stats];
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.storeImage];
    [self.backView addSubview:self.storeTitle];
    [self.backView addSubview:self.price];
    
    [self.contentView addSubview:self.total];
    [self.contentView addSubview:self.deleteOrder];
    [self.contentView addSubview:self.comment];
    
    
    self.iconImage.backgroundColor = [UIColor grayColor];
    self.iconImage.sd_layout
    .leftSpaceToView(self.contentView,15).topSpaceToView(self.contentView,8)
    .widthIs(15).heightIs(15);
    
    self.storeName.text = @"E+官方旗舰商城";
    self.storeName.font = [UIFont systemFontOfSize:14];
    self.storeName.font = [UIFont systemFontOfSize:14];
    self.storeName.sd_layout
    .leftSpaceToView(self.iconImage,10).topEqualToView(self.iconImage)
    .widthRatioToView(self.contentView,0.4).heightIs(15);
    
    self.stats.text = @"交易状态";
    self.stats.textColor = [UIColor orangeColor];
    self.stats.textAlignment = NSTextAlignmentRight;
    self.stats.font = [UIFont  systemFontOfSize:14];
    self.stats.sd_layout
    .rightSpaceToView(self.contentView,15).topEqualToView(self.iconImage)
    .widthRatioToView(self.contentView,0.3).heightIs(15);
    
    self.backView.backgroundColor = [UIColor colorWithRed:241/256.f green:242/256.f blue:244/256.f alpha:1];
    self.backView.sd_layout
    .leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0)
    .topSpaceToView(self.iconImage,8).heightIs(67.5);
    
    self.storeImage.image = [UIImage imageNamed:@"bbb"];
    self.storeImage.sd_layout
    .leftSpaceToView(self.backView,10).topSpaceToView(self.backView,5)
    .widthIs(57).bottomSpaceToView(self.backView,5);
    
    self.storeTitle.text = @"夏季新款男士韩版牛仔裤做旧日系的复古小脚潮流";
    self.storeTitle.font = [UIFont systemFontOfSize:12.5];
    self.storeTitle.sd_layout
    .leftSpaceToView(self.storeImage,5).topSpaceToView(self.backView,5)
    .widthRatioToView(self.backView,0.6).heightRatioToView(self.backView,0.5);
    
    
    self.price.text = @"¥49.00";
    self.price.font = [UIFont systemFontOfSize:13];
    self.price.textAlignment = NSTextAlignmentRight;
    self.price.sd_layout
    .rightSpaceToView(self.backView,10).topSpaceToView(self.backView,5)
    .heightIs(20).leftSpaceToView(self.storeTitle,2);
    
    self.total.text = @"共1件商品 合计：¥49.90（含运费0.0元）";
    self.total.font = [UIFont systemFontOfSize:13];
    self.total.textAlignment = NSTextAlignmentRight;
    self.total.sd_layout
    .rightSpaceToView(self.contentView,10).topSpaceToView(self.backView,5)
    .widthRatioToView(self.contentView,0.9).heightIs(20);
    
    self.comment.backgroundColor = [UIColor orangeColor];
    [self.comment setTitle:@"评价" forState:UIControlStateNormal];
    [self.comment setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.comment.layer.cornerRadius= 2;
    self.comment.titleLabel.font = [UIFont systemFontOfSize:13];
    self.comment.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.comment.sd_layout
    .rightSpaceToView(self.contentView,10).topSpaceToView(self.total,5)
    .bottomSpaceToView(self.contentView,5).widthIs(50);
    
    
    [self.deleteOrder setTitle:@"删除订单" forState:UIControlStateNormal];
    [self.deleteOrder setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.deleteOrder addTarget:self action:@selector(deleteAct:) forControlEvents:UIControlEventTouchUpInside];
    self.deleteOrder.titleLabel.font = [UIFont systemFontOfSize:13];
    self.deleteOrder.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.deleteOrder.layer.borderWidth = 0.5;
    self.deleteOrder.layer.cornerRadius = 2;
    self.deleteOrder.sd_layout
    .rightSpaceToView(self.comment,10).topEqualToView(self.comment)
    .bottomEqualToView(self.comment).widthIs(60);
    
    
}

#pragma mark 删除订单
- (void)deleteAct:(UIButton *)btn{

    if ([self.cellDelgate respondsToSelector:@selector(reloadCellCount)]) {
    
        [self.cellDelgate reloadCellCount];
    }
    
    
}
@end
