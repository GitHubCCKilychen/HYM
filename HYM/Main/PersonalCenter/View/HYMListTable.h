//
//  HYMListTable.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYMListModel.h"
@interface HYMListTable : UITableView
@property (nonatomic,assign)NSInteger selection;
@property (nonatomic,strong)NSMutableArray *datalistl;
@end
