//
//  HYMStore2Cell.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/4.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMStore2Cell.h"

@implementation HYMStore2Cell

- (void)setModel:(HYMMallModel *)model{
    
    _model = model;
    
    [self initWithView:_model];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
    }
    return self;
}

- (void)initWithView:(HYMMallModel *)model{

    for (int i = 0 ; i < 2; i++) {
        
        UILabel *storeTitle = [[UILabel alloc] init];
        storeTitle.frame = CGRectMake(10+i*80+i*kScreenWitdth/4, 15, 80, 20);
        storeTitle.text = @"瓦特啤酒";
        [HYMTool initLabel:storeTitle withFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:storeTitle];
        
        storeTitle.text = _model.name;
        
        UILabel *nowPrice = [[UILabel alloc] init];
        nowPrice.frame = CGRectMake(10+i*80+i*kScreenWitdth/4, 40, 50, 20);
        nowPrice.text = @"¥123";
        [HYMTool initLabel:nowPrice withFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:nowPrice];
        
        
        nowPrice.text = _model.price;
        
        UIImageView *storeImage = [[UIImageView alloc] init];
        storeImage.frame = CGRectMake(55+i*80+i*kScreenWitdth/4, 45, 100, 90);
        storeImage.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:storeImage];
        
        [storeImage sd_setImageWithURL:[NSURL URLWithString:_model.imgurl0]];
    }
    
}
@end
