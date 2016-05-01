//
//  HYMNoticeView.m
//  首页
//
//  Created by 刘晓雪 on 16/4/18.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMNoticeView.h"
#import "ScrollLabel.h"
#import "HYMMessageVC.h"
@interface HYMNoticeView ()<ScrollLabelDelegate>

@property (nonatomic,strong)ScrollLabel *scrollLabel;//公告
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UIImageView *hornImage;
@property (nonatomic,strong)UIButton *messageBtn;//消息按钮
@property (nonatomic,strong)NSArray *titleArr;//公告消息


@end

@implementation HYMNoticeView

#pragma mark 懒加载
- (UILabel *)title{

    if (_title == nil) {
        _title = [[UILabel alloc] init];
        _title.text = @"官方公告:";
        [HYMTool initLabel:_title withFont:[UIFont systemFontOfSize:16] withTextColor:[UIColor whiteColor] withTextAlignment:nil];
    }
    
    return _title;
}

//喇叭图标
-(UIImageView *)hornImage{

    if (_hornImage == nil) {
        
        _hornImage = [[UIImageView  alloc] init];
        _hornImage.backgroundColor = [UIColor brownColor];
    }
    
    return _hornImage;
}

-(UIButton *)messageBtn{

    if (_messageBtn == nil) {
        
        _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
    }
    
    return _messageBtn;
}
- (NSArray *)titleArr{

    if (_titleArr == nil) {
        
        _titleArr = [NSArray array];
        _titleArr = @[@"薅羊毛app2.0更新",@"1.0易经不再用",@"12433546579"];
    }
    
    return _titleArr;
}

-(ScrollLabel *)scrollLabel{

    if (_scrollLabel == nil) {
        
        _scrollLabel = [[ScrollLabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth*0.5, 20) withTitleArr:self.titleArr];
        _scrollLabel.scrollLabelDelegate = self;
        
    }
    
    return _scrollLabel;

}

#pragma mark 初始化
- (id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        //此处颜色值修改
        self.backgroundColor = [UIColor lightGrayColor];
     
        [self initWithView];
        
    }
    
    return self;
}

#pragma mark 
- (void)initWithView{

    [self addSubview:self.title];
    [self addSubview:self.hornImage];
//    [self addSubview:self.colon];
    [self addSubview:self.scrollLabel];
    [self addSubview:self.messageBtn];
    
    self.hornImage.sd_layout
    .leftSpaceToView(self,5).topSpaceToView(self,10)
    .bottomSpaceToView(self,10).widthEqualToHeight(20);
    
//    self.title.backgroundColor = [UIColor redColor];
    self.title.sd_layout
    .leftSpaceToView(self.hornImage,3).topEqualToView(self.hornImage)
    .bottomEqualToView(self.hornImage).widthRatioToView(self,0.22);
    
    self.scrollLabel.sd_layout
    .leftSpaceToView(self.title,0).topEqualToView(self.title)
    .bottomEqualToView(self.title).widthRatioToView(self,0.5);
    
    self.messageBtn.backgroundColor = [UIColor redColor];
    self.messageBtn.sd_layout
    .leftSpaceToView(self.scrollLabel,10).topSpaceToView(self,5)
    .rightSpaceToView(self,15).bottomSpaceToView(self,5);
}

#pragma mark 公告实现方法
- (void)btnClick:(UIButton *)btn{

    self.userInteractionEnabled = YES;
    HYMMessageVC *messageVC = [[HYMMessageVC alloc] init];
    messageVC.view.backgroundColor = [UIColor whiteColor];
    //此时⚠️
    [self.viewController presentViewController:messageVC animated:YES completion:nil];
    if (btn.tag == 1) {
        
        NSLog(@"1");
   
    }else if (btn.tag == 2){
    
        NSLog(@"2");
    }else{
    
        NSLog(@"3");
    }
}
@end
