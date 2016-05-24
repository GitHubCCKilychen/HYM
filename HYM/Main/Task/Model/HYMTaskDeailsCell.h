//
//  HYMTaskDeailsCell.h
//  HYM
//
//  Created by 刘晓雪 on 16/4/29.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYMTaskCellModel.h"
@interface HYMTaskDeailsCell : UITableViewCell

@property (nonatomic,strong)HYMTaskCellModel *model;
@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UILabel *name;
@property (nonatomic,strong)UILabel *comment;
@property (nonatomic,strong)UILabel *time;
@property (nonatomic,assign)NSInteger index;

@property (nonatomic,strong)UIButton *deleteBtn;
@property (nonatomic,strong)UIButton *chatBtn;
@end
