//
//  HYMEditCell.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/13.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYMEditCell : UITableViewCell

@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UIView *connectLine;
@property (nonatomic,strong)UITextField *title;
@property (nonatomic,strong)UITextView *connectView;
@property (nonatomic,strong)UIImageView *textTopic;
@property (nonatomic,strong)UILabel *textTopicImage;
@property (nonatomic,strong)UIView *centerLine;
@property (nonatomic,strong)UIImageView *photoTopic;
@property (nonatomic,strong)UIButton *photoBtm;
@end
