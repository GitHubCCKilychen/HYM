//
//  CategoryGoodsCell.m
//  PingChuan
//
//  Created by pengli on 15/9/22.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "CategoryGoodsCell.h"


@implementation CategoryGoodsCell
@synthesize logoImage;
@synthesize hotFlag;
@synthesize goodsName;
@synthesize goodsNowPrice;
@synthesize goodsOldPrice;
@synthesize goodsSellNum;
@synthesize btnRight;
@synthesize imgSelect;
@synthesize leftView;

- (void)dealloc
{
    [logoImage release]; logoImage = nil;
    [hotFlag release]; hotFlag = nil;
    [goodsName release]; goodsName = nil;
    [goodsNowPrice release]; goodsNowPrice = nil;
    [goodsOldPrice release]; goodsOldPrice = nil;
    [goodsSellNum release]; goodsSellNum = nil;
    [btnRight release]; btnRight = nil;
    [imgSelect release]; imgSelect = nil;
    [leftView release]; leftView = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.btnRight = [BBButton buttonWithType:UIButtonTypeCustom];
        btnRight.frame = CGRectMake(0, 0, 69, 84);
        btnRight.backgroundColor = [UIColor clearColor];
        btnRight.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [self.contentView addSubview:btnRight];
        
        self.imgSelect = [[[BBImgView alloc] init] autorelease];
        imgSelect.frame = CGRectMake(20, 31, 22, 22);
        [imgSelect setImage:nil];
        [XtomFunction addbordertoView:imgSelect radius:11.0f width:1.0f color:BB_Graylight];

        [btnRight addSubview:imgSelect];
        
        
        self.leftView = [[[UIView alloc]init]autorelease];
        leftView.frame = CGRectMake(0, 0, WIDTH, 84);
        leftView.backgroundColor = BB_White_Color;
        [self.contentView addSubview:leftView];
        
        
        self.logoImage = [[[UIImageView alloc] init] autorelease];
        logoImage.userInteractionEnabled = YES;
        [XtomFunction addbordertoView:logoImage radius:0 width:0.5 color:BB_lineColor];
        logoImage.frame = CGRectMake(0, 10, 82.5, 65);
        logoImage.contentMode = UIViewContentModeScaleAspectFill;
        [logoImage setClipsToBounds:YES];
        [leftView addSubview:logoImage];
        
        self.hotFlag = [[[UIImageView alloc] init] autorelease];
        hotFlag.userInteractionEnabled = YES;
        hotFlag.image = [UIImage imageNamed:@"商品推荐默认图标.png"];
        hotFlag.frame = CGRectMake(62.5, 3, 22.5, 22.5);
        [leftView addSubview:hotFlag];
        [hotFlag setHidden:YES];
        
        
        self.goodsName = [[[UILabel alloc] init] autorelease];
        goodsName.backgroundColor = [UIColor clearColor];
        goodsName.textAlignment = NSTextAlignmentLeft;
        goodsName.font = [UIFont systemFontOfSize:15];
        goodsName.textColor = BB_Blake;
        [goodsName setFrame:CGRectMake(94, 11, WIDTH-94-15, 25)];
        [leftView addSubview:goodsName];
        
        
        self.goodsNowPrice = [[[UILabel alloc] init] autorelease];
        goodsNowPrice.backgroundColor = [UIColor clearColor];
        goodsNowPrice.textAlignment = NSTextAlignmentLeft;
        goodsNowPrice.font = [UIFont systemFontOfSize:15];
        goodsNowPrice.textColor = BB_Button_Color;
        [goodsNowPrice setFrame:CGRectMake(94, 48, 70, 25)];
        [leftView addSubview:goodsNowPrice];
        
        
        self.goodsOldPrice = [[[UILabel alloc] init] autorelease];
        goodsOldPrice.backgroundColor = [UIColor clearColor];
        goodsOldPrice.textAlignment = NSTextAlignmentLeft;
        goodsOldPrice.font = [UIFont systemFontOfSize:11];
        goodsOldPrice.textColor = BB_Blake;
        [goodsOldPrice setFrame:CGRectMake(94 + 80, 48, 150, 25)];
        [leftView addSubview:goodsOldPrice];
        
         
        self.goodsSellNum = [[[UILabel alloc] init] autorelease];
        goodsSellNum.backgroundColor = [UIColor clearColor];
        goodsSellNum.textAlignment = NSTextAlignmentRight;
        goodsSellNum.font = [UIFont systemFontOfSize:11];
        goodsSellNum.textColor = BB_Blake;
        [goodsSellNum setFrame:CGRectMake(WIDTH-160, 53, 150, 21)];
        [leftView addSubview:goodsSellNum];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
