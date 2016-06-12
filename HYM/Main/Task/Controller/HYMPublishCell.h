//
//  HYMPublishCell.h
//  HYM
//
//  Created by 刘晓雪 on 16/6/1.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYMPublishCell : UITableViewCell

@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UILabel *activity;
@property (nonatomic,strong)UILabel *activityContent;//活动内容
@property (nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,strong)UIButton *btn;
@end
