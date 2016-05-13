//
//  HYMPostedTable.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  HYMPostedTableDelegate <NSObject>

@required
- (void)removeBottomView;

- (void)addBotttomView;
@optional


@end

@interface HYMPostedTable : UITableView

@property (nonatomic,weak)id <HYMPostedTableDelegate>postedTableDelegate;

@end
