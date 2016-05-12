//
//  HYMCourseCell.h
//  HYM
//
//  Created by 刘晓雪 on 16/5/5.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYMCourseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UILabel *taskCourse;
@property (weak, nonatomic) IBOutlet UIImageView *editImage;

@property (weak, nonatomic) IBOutlet UIImageView *textImage;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UIView *backView;
- (IBAction)textAct:(UIButton *)sender;
- (IBAction)photoAct:(UIButton *)sender;

@end
