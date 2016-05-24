//
//  HYMRecordCell.h
//  HYM
//
//  Created by 刘晓雪 on 16/4/27.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYMMyBookModel.h"
@interface HYMRecordCell : UITableViewCell

@property (nonatomic,strong)HYMMyBookModel *model;
@property (nonatomic,strong)UIImageView *taskImage;
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UIButton *timeBtn;
@end
