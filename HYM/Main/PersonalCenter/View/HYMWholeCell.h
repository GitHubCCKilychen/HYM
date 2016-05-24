//
//  HYMWholeCell.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/13.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HYMWholeCellDelegate <NSObject>

@required
- (void)reloadCellCount;

@end

@interface HYMWholeCell : UITableViewCell

@property (nonatomic,strong)UIImageView *iconImage;
@property (nonatomic,strong)UILabel *storeName;
@property (nonatomic,strong)UIView *backView;//背景
@property (nonatomic,strong)UIImageView *storeImage;
@property (nonatomic,strong)UILabel *storeTitle;
@property (nonatomic,strong)UILabel *stats;//交易状态
@property (nonatomic,strong)UIButton *deleteOrder;//删除订单
@property (nonatomic,strong)UIButton *comment;//评价
@property (nonatomic,strong)UILabel *total;//商品总计
@property (nonatomic,strong)UILabel *price;//价格
@property (nonatomic,weak)id<HYMWholeCellDelegate>cellDelgate;
@end
