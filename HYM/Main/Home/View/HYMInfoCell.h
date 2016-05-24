//
//  HYMInfoCell.h
//  今日资讯
//
//  Created by 刘晓雪 on 16/4/20.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYMTodayInfoModel.h"
@interface HYMInfoCell : UITableViewCell

/**
 *  参数
 */
@property (nonatomic,strong)HYMTodayInfoModel *model;
@property (nonatomic,strong)UIImageView *messageImage;
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UILabel *commont;//评论
@property (nonatomic,strong)UILabel *time;//时间
@end
