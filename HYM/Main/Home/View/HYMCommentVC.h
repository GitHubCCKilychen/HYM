//
//  HYMCommentVC.h
//  资讯
//
//  Created by 刘晓雪 on 16/4/21.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  HYMCommentDelagete<NSObject>

- (void)comment:(NSString *)text with:(int)indexCount;

@end
@interface HYMCommentVC : UIViewController

@property (nonatomic,copy)NSString *commont;//评论内容

@property (nonatomic,weak)id<HYMCommentDelagete>commentDelegate;
@end
