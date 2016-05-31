//
//  HYMTaskListCell.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/11.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTaskListCell.h"
#import "HYMPostedCaseVC.h"
#import "HYMTaskDetailsVC.h"
@implementation HYMTaskListCell

- (UIImageView *)storeImage{

    if (_storeImage == nil) {
        
        _storeImage = [[UIImageView alloc] init];
    }
    return _storeImage;
}

- (UILabel *)title{

    if (_title == nil) {
        
        _title = [[UILabel alloc] init];
    }
    return _title;
}

- (UIButton *)seeTask{

    if (_seeTask == nil) {
        
        _seeTask = [UIButton buttonWithType:UIButtonTypeCustom];
        _seeTask.backgroundColor = [UIColor colorWithRed:44/256.f green:150/256.f blue:253/256.f alpha:1];
//        [_seeTask setImage:[UIImage imageNamed:@"预览"] forState:UIControlStateNormal];
        [_seeTask addTarget:self action:@selector(seeTask:) forControlEvents:UIControlEventTouchUpInside];
        [_seeTask setTitle:@"预览" forState:UIControlStateNormal];
        _seeTask.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _seeTask;
}

- (UIButton *)publish{

    if (_publish == nil) {
        _publish = [UIButton buttonWithType:UIButtonTypeCustom];
        [_publish setTitle:@"发布" forState:UIControlStateNormal];
//        [_publish setImage:[UIImage imageNamed:@"发布"] forState:UIControlStateNormal];
        _publish.titleLabel.font = [UIFont systemFontOfSize:14];
        _publish.backgroundColor = [UIColor colorWithRed:25/255.f green:185/255.f blue:78/255.f alpha:1];
        [_publish addTarget:self action:@selector(publishAct:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publish;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
//        [self initWithView];
    }
    return self;
}

- (void)setIndexPath:(NSIndexPath *)indexPath{

    _indexPath = indexPath;
    
    if (_indexPath.row == 0) {
        UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(15, 5, 1, 20);
        lineView.backgroundColor = [UIColor orangeColor];
        [self addSubview:lineView];
        
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(20, 5, kScreenWitdth-30, 20);
        [HYMTool initLabel:title withFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
        title.tag = 1;
        title.text = @"待发布（上传发布成功的任务）";
        [self addSubview:title];
    }else{
    
        [self initWithView];
    }
}
- (void)initWithView{

    [self addSubview:self.storeImage];
    [self addSubview:self.title];
    [self addSubview:self.seeTask];
    [self addSubview:self.publish];
 
    
    self.storeImage.backgroundColor = [UIColor grayColor];
    self.storeImage.sd_layout
    .leftSpaceToView(self,15).topSpaceToView(self,10)
    .bottomSpaceToView(self,10).widthIs(60);
    
    self.title.backgroundColor = [UIColor grayColor];
    self.title.sd_layout
    .leftSpaceToView(self.storeImage,10).bottomSpaceToView(self,20)
    .widthRatioToView(self,0.5).topEqualToView(self.storeImage);

    self.seeTask.sd_layout
    .rightSpaceToView(self,15).topEqualToView(self.storeImage)
    .heightIs(25).widthIs(50);
    

    self.publish.sd_layout
    .rightSpaceToView(self,15).topSpaceToView(self.seeTask,10)
    .bottomSpaceToView(self,15).heightIs(25).widthIs(50);
}


#pragma mark 发布
- (void)publishAct:(UIButton *)btn{

//发布情况

    HYMPostedCaseVC *postedVC = [[HYMPostedCaseVC alloc] init];
    postedVC.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:postedVC animated:YES];
    
}

#pragma mark 预览情况
- (void)seeTask:(UIButton *)task{

    HYMTaskDetailsVC *taskVC = [[HYMTaskDetailsVC alloc] init];
    [self.viewController.navigationController pushViewController:taskVC animated:YES];
}

@end
