//
//  HYMTieziTable.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/14.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYMTieziTableDelegate <NSObject>

- (void)getTitle:(NSString *)title;

@end
@interface HYMTieziTable : UITableView

@property (nonatomic,weak)id<HYMTieziTableDelegate>titleDelegate;
@end
