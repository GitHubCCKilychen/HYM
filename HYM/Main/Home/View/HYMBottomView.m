//
//  HYMBottomView.m
//  资讯
//
//  Created by 刘晓雪 on 16/4/21.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMBottomView.h"
#import "UIView+SDAutoLayout.h"
#import "HYMCommentVC.h"
#import "UIView+UIViewController.h"
#import "ShareView.h"
@interface HYMBottomView ()

@property (nonatomic,strong)UIImageView *comment;//评论
@property (nonatomic,strong)UIButton *messageBtn;//消息
@property (nonatomic,strong)UIButton *Collectionbtn;//收藏
@property (nonatomic,strong)UIButton *shareBtn;//分享
@property (nonatomic,strong)UILabel *title;

@end
@implementation HYMBottomView

#pragma mark 懒加载

-(UILabel *)title{

    if (_title == nil) {
        
        _title = [[UILabel alloc] init];
        _title.frame = self.comment.frame;
        _title.text = @"23435";
        _title.textColor = [UIColor greenColor];
    }
    return _title;
}
- (UIImageView *)comment{

    if (_comment == nil) {
        
        _comment = [[UIImageView alloc] init];

    }
    return _comment;
}

- (UIButton *)messageBtn{

    if (_messageBtn == nil) {
        
        _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    return _messageBtn;
}

-(UIButton *)Collectionbtn{

    if (_Collectionbtn == nil) {
        
        _Collectionbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_Collectionbtn addTarget:self action:@selector(collectionBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _Collectionbtn;
}

- (UIButton *)shareBtn{

    if (_shareBtn == nil) {
        
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn addTarget:self action:@selector(shareBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _shareBtn;
}


#pragma mark 初始化
- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        self.userInteractionEnabled = YES;
        [self initWithView];
        
    }
    
    return self;;
}


#pragma mark view
- (void)initWithView{

   
    [self addSubview:self.comment];
    [self.comment addSubview:self.title];

    
    [self addSubview:self.messageBtn];
    [self addSubview:self.shareBtn];
    [self addSubview:self.Collectionbtn];
    
    
    self.comment.backgroundColor = [UIColor redColor];
    
    self.comment.sd_layout
    .leftSpaceToView(self,10).topSpaceToView(self,5)
    .bottomSpaceToView(self,5).heightIs(39).widthRatioToView(self,0.5);
    
    
//    self.title.backgroundColor = [UIColor blueColor];
//    self.title.sd_layout
//    .leftEqualToView(self.comment).topEqualToView(self.comment)
//    .bottomEqualToView(self.comment).heightEqualToWidth(self.comment);
    
    
    self.messageBtn.backgroundColor = [UIColor brownColor];
    self.messageBtn.sd_layout
    .leftSpaceToView(self.comment,10).topSpaceToView(self,10)
    .bottomSpaceToView(self,10).widthIs(30);
    
    
    self.Collectionbtn.backgroundColor = [UIColor whiteColor];
    self.Collectionbtn.sd_layout
    .leftSpaceToView(self.messageBtn,20).topSpaceToView(self,10)
    .bottomSpaceToView(self,10).widthIs(30);
    
    self.shareBtn.backgroundColor = [UIColor greenColor];
    self.shareBtn.sd_layout
    .leftSpaceToView(self.Collectionbtn,10).rightSpaceToView(self,10)
    .bottomSpaceToView(self,10).widthIs(30).topSpaceToView(self,10);
    
}



#pragma mark 分享事件
- (void)shareBtnAct:(UIButton *)btn{

    
    //分享
    
//    
//    ShareView *shareV = [ShareView shareViewWithPresentedViewController:self items:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToWechatSession,UMShareToWechatFavorite,UMShareToWechatTimeline] title:@"分享练习自定义UI" image:[UIImage imageNamed:@"icon.png"] urlResource:@"http://www.baidu.com"];
    
//    [[UIApplication sharedApplication].keyWindow addSubview:shareV];
}

#pragma makr 收藏成功
- (void)collectionBtn:(UIButton *)btn{

    if (btn.selected == NO) {
        
        btn.backgroundColor = [UIColor redColor];
        btn.selected = YES;
    }else if (btn.selected == YES){
    
        btn.backgroundColor = [UIColor grayColor];
        btn.selected = NO;
    }

}
@end
