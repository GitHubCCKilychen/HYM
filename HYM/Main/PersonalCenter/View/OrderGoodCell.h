//
//  OrderGoodCell.h
//  PingChuan
//
//  Created by LarryRodic on 15/3/24.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBImgView.h"
#import "BBButton.h"

@interface OrderGoodCell : UITableViewCell
@property(nonatomic,retain)BBButton *deleteBtn;//右侧删除按钮
@property(nonatomic,retain)UIView *backView;//背景框view
@property(nonatomic,retain)BBImgView *topImgView;//图片
@property(nonatomic,retain)UILabel *nameLable;//商品名称
@property(nonatomic,retain)UILabel *goodsPrice;//商品价格
@property(nonatomic,retain)UILabel *typeLable;//商品属性
@property(nonatomic,retain)UILabel *priceLable;//价格、数量属性
@property(nonatomic,retain)BBButton *rightBtn;//右侧按钮
@property(nonatomic,retain)UIView *line;//右侧状态line
@end
