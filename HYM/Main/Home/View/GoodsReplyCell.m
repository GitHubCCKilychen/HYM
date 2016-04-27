//
//  GoodsReplyCell.m
//  PingChuan
//
//  Created by pengli on 15/9/24.
//  Copyright (c) 2015年 平川嘉恒. All rights reserved.
//

#import "GoodsReplyCell.h"

@implementation GoodsReplyCell
@synthesize userHeaderImage;
@synthesize userNameLabel;
@synthesize publishTimeLabel;
@synthesize commentDetailLabel;
@synthesize starArray;
@synthesize imageArr;

- (void)dealloc
{
    [userHeaderImage release]; userHeaderImage = nil;
    [userNameLabel release]; userNameLabel = nil;
    [publishTimeLabel release]; publishTimeLabel = nil;
    [commentDetailLabel release]; commentDetailLabel = nil;
    [starArray release]; starArray = nil;
    [imageArr release]; imageArr = nil;
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.userHeaderImage = [[[UIImageView alloc] init] autorelease];
        
        userHeaderImage.frame = CGRectMake(11.5, 11, 33, 33);
        userHeaderImage.contentMode = UIViewContentModeScaleAspectFill;
        [userHeaderImage setClipsToBounds:YES];
        [self.contentView addSubview:userHeaderImage];
        
        
        self.userNameLabel = [[[UILabel alloc] init] autorelease];
        userNameLabel.frame = CGRectMake(53, 11.5, WIDTH-120, 20);
        userNameLabel.textColor = [UIColor blackColor];
        userNameLabel.textAlignment = NSTextAlignmentLeft;
        userNameLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:userNameLabel];
        
        
        self.publishTimeLabel = [[[UILabel alloc] init] autorelease];
        publishTimeLabel.frame = CGRectMake(53, 31.5, WIDTH-120, 15);
        publishTimeLabel.textColor = [UIColor grayColor];
        publishTimeLabel.textAlignment = NSTextAlignmentLeft;
        publishTimeLabel.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:publishTimeLabel];
        
        self.commentDetailLabel = [[[UILabel alloc] init] autorelease];
        commentDetailLabel.frame = CGRectMake(53, 53, WIDTH-63, 24);
        commentDetailLabel.textColor = [UIColor darkGrayColor];
        commentDetailLabel.textAlignment = NSTextAlignmentLeft;
        commentDetailLabel.font = [UIFont systemFontOfSize:16];
        commentDetailLabel.numberOfLines = 0;
        [self.contentView addSubview:commentDetailLabel];
        
        self.starArray = [[[NSMutableArray alloc] init] autorelease];
        for (int i = 0; i < 5; i++)
        {
            UIImageView * star = [[[UIImageView alloc] init] autorelease];
            star.image = [UIImage imageNamed:@"store_replylist_star_nor.png"];
            [self.contentView addSubview:star];
            [self.starArray addObject:star];
        }
        
        
        self.imageArr = [[[NSMutableArray alloc] initWithCapacity:4] autorelease];
        for (int i = 0; i < 4; i++)
        {
            UIImageView *  commentImage = [[[UIImageView alloc] init] autorelease];
            commentImage.backgroundColor = [UIColor clearColor];
            commentImage.contentMode = UIViewContentModeScaleAspectFill;
            [commentImage setClipsToBounds:YES];
            commentImage.frame = CGRectMake(53+(WIDTH-60)/4*i, 82, 62, 62);
            [self.contentView addSubview:commentImage];
            [imageArr addObject:commentImage];
            commentImage.hidden = NO;
        }
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
