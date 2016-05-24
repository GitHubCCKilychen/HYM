//
//  HYMStoreCell.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/4.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYMMallModel.h"
@interface HYMStoreCell : UITableViewCell

@property (nonatomic,strong)HYMMallModel *model;
@property (nonatomic,strong)UIImageView *storeImage;
@property (nonatomic,strong)UILabel *storeTitle;
@property (nonatomic,strong)UILabel *storeSubtitle;
@property (nonatomic,strong)UILabel *originalPrice;
@property (nonatomic,strong)UILabel *nowPrice;
@property (nonatomic,strong)UIButton *lookDetail;//查看详情

@end
