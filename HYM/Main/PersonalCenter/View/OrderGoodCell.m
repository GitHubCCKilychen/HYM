//
//  OrderGoodCell.m
//  PingChuan
//
//  Created by LarryRodic on 15/3/24.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "OrderGoodCell.h"

@implementation OrderGoodCell
@synthesize deleteBtn;
@synthesize backView;
@synthesize topImgView;
@synthesize nameLable;
@synthesize goodsPrice;
@synthesize typeLable;
@synthesize priceLable;
@synthesize rightBtn;
@synthesize line;

-(void)dealloc
{
    [deleteBtn release];deleteBtn = nil;
    [backView release];backView = nil;
    [topImgView release];topImgView = nil;
    [nameLable release];nameLable = nil;
    [goodsPrice release];goodsPrice = nil;
    [typeLable release];typeLable = nil;
    [priceLable release];priceLable = nil;
    [rightBtn release];rightBtn = nil;
    [line release];line = nil;
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //右侧按钮
        self.deleteBtn = [BBButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setFrame:CGRectMake(236, 0, 84, 95)];
        [deleteBtn setBackgroundColor:BB_Red_Color];
        [self.contentView addSubview:deleteBtn];
        
        //右侧删除
        UILabel *labDelete = [[[UILabel alloc]init]autorelease];
        labDelete.backgroundColor = [UIColor clearColor];
        labDelete.textColor = BB_White_Color;
        labDelete.textAlignment = NSTextAlignmentCenter;
        labDelete.font = [UIFont boldSystemFontOfSize:17];
        labDelete.frame = CGRectMake(0, 0, 84, 96);
        labDelete.text = @"删除";
        [deleteBtn addSubview:labDelete];
        
        //背景
        self.backView = [[[UIView alloc]init]autorelease];
        backView.frame = CGRectMake(0, 0, 320, 95);
        [backView setBackgroundColor:BB_White_Color];
        [self.contentView addSubview:backView];
        
        //图片
        self.topImgView = [[[BBImgView alloc]init]autorelease];
        [topImgView setFrame:CGRectMake(14, 14, 67, 67)];
        topImgView.contentMode = UIViewContentModeScaleAspectFill;
        [XtomFunction addbordertoView:topImgView radius:5.0f width:0.5f color:BB_lineColor];
        [topImgView setClipsToBounds:YES];
        [backView addSubview:topImgView];
        
        //标题
        self.nameLable = [[[UILabel alloc]init]autorelease];
        nameLable.backgroundColor = [UIColor clearColor];
        nameLable.textColor = BB_Blake;
        nameLable.textAlignment = NSTextAlignmentLeft;
        nameLable.font = [UIFont systemFontOfSize:16];
        nameLable.frame = CGRectMake(93, 18, 217, 16);
        [backView addSubview:nameLable];
        
        //商品属性
        self.typeLable = [[[UILabel alloc]init]autorelease];
        typeLable.backgroundColor = [UIColor clearColor];
        typeLable.textColor = BB_NGray_Color;
        typeLable.textAlignment = NSTextAlignmentLeft;
        typeLable.font = [UIFont systemFontOfSize:13];
        typeLable.frame = CGRectMake(93, 38, 217, 15);
        [backView addSubview:typeLable];
        
        //价格
        self.goodsPrice = [[[UILabel alloc]init]autorelease];
        goodsPrice.backgroundColor = [UIColor clearColor];
        priceLable.textColor = BB_Gray;
        goodsPrice.textAlignment = NSTextAlignmentLeft;
        goodsPrice.font = [UIFont systemFontOfSize:13];
        goodsPrice.frame = CGRectMake(93, 63, 100, 15);
        [backView addSubview:goodsPrice];
        
        //数量属性
        self.priceLable = [[[UILabel alloc]init]autorelease];
        priceLable.backgroundColor = [UIColor clearColor];
        priceLable.textColor = BB_Gray;
        priceLable.textAlignment = NSTextAlignmentRight;
        priceLable.font = [UIFont systemFontOfSize:13];
        priceLable.frame = CGRectMake(WIDTH-110, 63, 100, 15);
        [backView addSubview:priceLable];
        
        //右侧按钮
        self.rightBtn = [BBButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(245, 57, 60, 27);
        [XtomFunction addbordertoView:rightBtn radius:4.0f width:0.5f color:BB_NPurple_Color];
        [rightBtn setBackgroundColor:[UIColor clearColor]];
        rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        rightBtn.titleLabel.textColor = BB_NPurple_Color;
        [rightBtn setTitle:@"评价" forState:UIControlStateNormal];
        [rightBtn setTitleColor:BB_NPurple_Color forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [backView addSubview:rightBtn];
        
        //竖线
        self.line = [[[UIView alloc]init]autorelease];
        [line setFrame:CGRectMake(246, 65, 1, 12)];
        [line setBackgroundColor:BB_Gray];
        [backView addSubview:line];
        
        [rightBtn setHidden:YES];
        [line setHidden:YES];
    }
    return self;
}
@end
