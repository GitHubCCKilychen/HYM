//
//  HYMStoreCell.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/4.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMStoreCell.h"

@implementation HYMStoreCell
-(UIImageView *)storeImage{
    
    if (_storeImage == nil) {
        
        _storeImage = [[UIImageView alloc] init];
    }
    return _storeImage;
}

- (UILabel *)storeTitle{
    
    if (_storeTitle == nil) {
        
        _storeTitle = [[UILabel alloc] init];
        _storeTitle.text = @"给秀发喝的奇异果汁";
        [HYMTool initLabel:_storeTitle withFont:[UIFont boldSystemFontOfSize:15] withTextColor:[UIColor blackColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _storeTitle;
}

- (UILabel *)storeSubtitle{
    
    if (_storeSubtitle == nil) {
        
        _storeSubtitle = [[UILabel alloc] init];
        _storeSubtitle.text = @"日本奇异果洗发水300ml";
        [HYMTool initLabel:_storeSubtitle withFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor lightGrayColor] withTextAlignment:NSTextAlignmentRight];
    }
    return _storeSubtitle;
}

-(UILabel *)originalPrice{
    
    if (_originalPrice == nil) {
        
        _originalPrice = [[UILabel alloc] init];
        _originalPrice.text = @"原价¥125";
        [HYMTool initLabel:_originalPrice withFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor grayColor] withTextAlignment:NSTextAlignmentRight];
        //中画线－－－－－
        NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:_originalPrice.text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor grayColor],NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),NSStrikethroughColorAttributeName:[UIColor grayColor]}];
        self.originalPrice.attributedText = attStr;

    }
    return _originalPrice;
}

- (UILabel *)nowPrice{
    
    if (_nowPrice == nil) {
        _nowPrice = [[UILabel alloc] init];
        _nowPrice.text = @"好货价¥89";
        [HYMTool initLabel:_nowPrice withFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentRight];
        //设置字体大小不同－－
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:_nowPrice.text ];
        [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(3, 3)];
        
        _nowPrice.attributedText = attStr;
    }
    return _nowPrice;
}

-(UIButton *)lookDetail{

    if (_lookDetail == nil) {
        
        _lookDetail = [UIButton buttonWithType:UIButtonTypeCustom];
        _lookDetail.backgroundColor = [UIColor orangeColor];
        _lookDetail.layer.cornerRadius = 3;
        [_lookDetail setTitle:@"查看详情" forState:UIControlStateNormal];
        [_lookDetail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _lookDetail.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _lookDetail;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        [self initWithView];
    }
    return  self;
}

#pragma mark view
- (void)initWithView{
    
    [self.contentView addSubview:self.storeImage];
    [self.contentView addSubview:self.storeTitle];
    [self.contentView addSubview:self.storeSubtitle];
    [self.contentView addSubview:self.originalPrice];
    [self.contentView addSubview:self.nowPrice];
    [self.contentView addSubview:self.lookDetail];
    
    self.storeImage.backgroundColor = [UIColor grayColor];
    self.storeImage.sd_layout
    .leftSpaceToView(self.contentView,10).topSpaceToView(self.contentView,10)
    .bottomSpaceToView(self.contentView,0).widthRatioToView(self.contentView,0.48);
    
    self.storeTitle.sd_layout
    .leftSpaceToView(self.storeImage,10).topSpaceToView(self.contentView,5)
    .rightSpaceToView(self.contentView,5).heightIs(30);
    
    self.storeSubtitle.sd_layout
    .leftSpaceToView(self.storeImage,12).rightEqualToView(self.storeTitle)
    .topSpaceToView(self.storeTitle,0).heightIs(20);
    
    self.originalPrice.sd_layout
    .rightSpaceToView(self.contentView,5).topSpaceToView(self.storeSubtitle,5)
    .widthIs(80).heightIs(20);
 
    self.nowPrice.sd_layout
    .rightSpaceToView(self.contentView,5).topSpaceToView(self.originalPrice,2)
    .heightIs(20).widthIs(80);
    
    self.lookDetail.sd_layout
    .rightSpaceToView(self.contentView,5).topSpaceToView(self.nowPrice,5)
    .widthIs(80).heightIs(25);
    
    
}
@end
