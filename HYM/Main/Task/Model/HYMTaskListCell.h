//
//  HYMTaskListCell.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/11.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYMPubListModel.h"
@interface HYMTaskListCell : UITableViewCell

@property (nonatomic,strong)HYMPubListModel *model;
@property (nonatomic,strong)UIImageView *storeImage;
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UIButton *seeTask;
@property (nonatomic,strong)UIButton *publish;
@property (nonatomic,assign)NSIndexPath *indexPath;
@end
