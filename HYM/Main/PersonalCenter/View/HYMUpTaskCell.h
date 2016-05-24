//
//  HYMUpTaskCell.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/10.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYMSegmentView.h"
#import "HYMUpModel.h"
@interface HYMUpTaskCell : UITableViewCell<HYMSegmentViewDelegate>

@property (nonatomic,strong)HYMUpModel *model;
@property (nonatomic,strong)UIImageView *storeImage;
@property (nonatomic,strong)UILabel *connect;//内容
@property (nonatomic,strong)UIButton *editBtn;
@property (nonatomic,strong)UIButton *deleteBtn;
@property (nonatomic,strong)NSIndexPath* indexPath;
@property (nonatomic,strong)HYMSegmentView *segmentView;
@property (nonatomic,strong)UIView *lineView;
@end
