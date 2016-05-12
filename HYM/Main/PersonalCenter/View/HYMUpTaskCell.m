//
//  HYMUpTaskCell.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/10.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMUpTaskCell.h"

@implementation HYMUpTaskCell

- (UIView *)lineView{

    if (_lineView == nil) {
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor grayColor];
        _lineView.frame = CGRectMake(kScreenWitdth/2-0.5, 10, 1, 15);
    }
    return _lineView;
}

- (UIImageView *)storeImage{

    if (_storeImage == nil) {
        
        _storeImage = [[UIImageView alloc] init];
    }
    return _storeImage;
}

- (UILabel *)connect{

    if (_connect == nil) {
        
        _connect = [[UILabel alloc] init];
    }
    return _connect;
}

- (UIButton *)editBtn{

    if (_editBtn == nil) {
        
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
        return _editBtn;
}

- (UIButton *)deleteBtn{

    if (_deleteBtn == nil) {
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _deleteBtn;
}

- (HYMSegmentView *)segmentView{

    if (_segmentView == nil) {
        
        NSArray *titieArr = @[@"上传未通过的任务",@"草稿未上线的项目"];
        _segmentView = [HYMSegmentView segmenFrame:CGRectMake(0, 0, kScreenWitdth, 35) titleDataSource:titieArr backgroundColor:[UIColor whiteColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:8] selectedColor:[UIColor orangeColor] buttonDownColor:[UIColor orangeColor] delegate:self];
    }
    return _segmentView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
    }
    return self;
}

- (void)setIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        
        [self.segmentView addSubview:self.lineView];
        [self.contentView addSubview:self.segmentView];

    }else{
    
        [self initWithView];
    }
}

#pragma mark 

-(void)segumentSelectionChange:(NSInteger)selection{

}
- (void)initWithView{
    
    
    
    [self.contentView addSubview:self.storeImage];
    [self.contentView addSubview:self.connect];
    [self.contentView addSubview:self.editBtn];
    [self.contentView addSubview:self.deleteBtn];
    
    self.storeImage.backgroundColor = [UIColor grayColor];
    self.storeImage.sd_layout
    .leftSpaceToView(self.contentView,15).topSpaceToView(self.contentView,10)
    .bottomSpaceToView(self.contentView,10).widthIs(60);
    
    self.connect.backgroundColor = [UIColor brownColor];
    self.connect.sd_layout
    .leftSpaceToView(self.storeImage,10).topEqualToView(self.storeImage)
    .widthRatioToView(self.contentView,0.5).heightIs(50);
    
    self.editBtn.backgroundColor = [UIColor grayColor];
    self.editBtn.sd_layout
    .leftSpaceToView(self.connect,10).topEqualToView(self.storeImage)
    .rightSpaceToView(self.contentView,10).heightIs(25);
    
    self.deleteBtn.backgroundColor = [UIColor brownColor];
    self.deleteBtn.sd_layout
    .leftEqualToView(self.editBtn).rightEqualToView(self.editBtn)
    .topSpaceToView(self.editBtn,8).heightIs(25);
}
@end
