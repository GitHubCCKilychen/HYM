//
//  CategoryGoodsCell.h
//  PingChuan
//
//  Created by pengli on 15/9/22.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBButton.h"
#import "BBImgView.h"

@interface CategoryGoodsCell : UITableViewCell

@property (nonatomic, retain) BBButton * btnRight;
@property (nonatomic, retain) BBImgView * imgSelect;
@property (nonatomic, retain) UIView * leftView;

@property (nonatomic, retain) UIImageView * logoImage;
@property (nonatomic, retain) UIImageView * hotFlag;
@property (nonatomic, retain) UILabel * goodsName;
@property (nonatomic, retain) UILabel * goodsNowPrice;
@property (nonatomic, retain) UILabel * goodsOldPrice;
@property (nonatomic, retain) UILabel * goodsSellNum;

@end
