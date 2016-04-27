//
//  GoodsReplyCell.h
//  PingChuan
//
//  Created by pengli on 15/9/24.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsReplyCell : UITableViewCell

@property (nonatomic, retain) UIImageView * userHeaderImage;
@property (nonatomic, retain) UILabel * userNameLabel;
@property (nonatomic, retain) UILabel * publishTimeLabel;
@property (nonatomic, retain) UILabel * commentDetailLabel;
@property (nonatomic, retain) NSMutableArray * starArray;
@property (nonatomic, retain) NSMutableArray * imageArr; 

@end
