//
//  HYMTaskView.m
//  首页
//
//  Created by 刘晓雪 on 16/4/18.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMTaskView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define brownBackColor [UIColor colorWithRed:252/256.f green:217/256.f blue:53/256.f alpha:1]

#define kViewWidth kScreenWidth-10
#define kViewHeight  self.brownView.frame.size.height

#import "HYMMyBooksVC.h"
#import "HYMRemindVC.h"

@interface HYMTaskView ()

@property (nonatomic,strong)UIView *brownView;
@property (nonatomic,strong)UILabel *moneyLabel;//收益
@property (nonatomic,strong)UILabel *titleLabel;//累计收益
@property (nonatomic,strong)UIImageView *lineView;
@property (nonatomic,strong)UILabel *invitationLabel;//邀请
@property (nonatomic,strong)UILabel *taskLabel;//任务返利
@property (nonatomic,strong)UIImageView *moneyImage;
@property (nonatomic,strong)UIView *horizontalLine;
@end
@implementation HYMTaskView

#pragma mark 懒加载
-(UIView *)brownView{

    if (_brownView == nil) {
        
        _brownView = [[UIView alloc] init];
//        _brownView.backgroundColor = brownBackColor;
        _brownView.layer.cornerRadius = 5;
        
    }
    
    return _brownView;
}
- (UILabel *)moneyLabel{

    if (_moneyLabel == nil) {
        
        _moneyLabel = [[UILabel alloc] init];
        [HYMTool initLabel:_moneyLabel withFont:[UIFont systemFontOfSize:25] withTextColor:[UIColor redColor] withTextAlignment:NSTextAlignmentLeft];
        
    }
    
    return _moneyLabel;
}
- (UIImageView *)moneyImage{

    if (_moneyImage == nil) {
        
        _moneyImage = [[UIImageView alloc] init];
        _moneyImage.image = [UIImage imageNamed:@"money"];
    }
    return _moneyImage;
}
- (UILabel *)titleLabel{

    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"累计返利";
        [HYMTool initLabel:_titleLabel withFont:[UIFont systemFontOfSize:13] withTextColor:[UIColor redColor] withTextAlignment:NSTextAlignmentLeft];
    }
    
    return _titleLabel;
}

- (UIImageView *)lineView{

    if (_lineView == nil) {
        
        _lineView = [[UIImageView alloc] init];
        _lineView.frame = CGRectMake(kScreenWidth/2-1, 5, 1, 50);
        _lineView.alpha = 0.08;
        _lineView.layer.borderWidth = 0.5;
    }
    return _lineView;
}

- (UIView *)horizontalLine{

    if (_horizontalLine == nil) {
        
        _horizontalLine = [[UIView alloc] init];
        _horizontalLine.alpha = 0.08;
        _horizontalLine.layer.borderWidth = 0.5;
    }
    return _horizontalLine;
}

- (id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        
        self.backgroundColor = [UIColor whiteColor];
        
          [self loadData];
          [self initWithView];
        
      
        
    }
    
    return self;
}
#pragma mark 中间按钮
- (void)initWithButton:(NSArray*)taskArr{
    
    
    NSArray *titleArr = @[@"任务赚钱",@"邀请奖励",@"赎回提醒"];
    
    //－－－适配问题－－－
    CGFloat btnWidth = (kScreenWitdth - 240)/3;
    
    CGFloat labelWidth = kScreenWitdth/3;
    for (int i = 0; i < titleArr.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(40+i*btnWidth+i*80, self.brownView.frame.size.height+25, btnWidth, 30);
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"homeTask%d",i]];
        [btn setImage:image forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:btn];
        
 
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(i*labelWidth, 55+self.brownView.frame.size.height, labelWidth, 20);
        title.text = [NSString stringWithFormat:@"%@",titleArr[i]];
        title.font = [UIFont systemFontOfSize:11];
        title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:title];
   
    }
  
    NSArray *titleA = @[@"任务返利",@"邀请返利"];
    for (int i = 0; i < 2; i++) {
        
        //此处frame有问题
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((kScreenWidth/2+10), 10+i*20, 50, 20);
        [btn setTitle:titleA[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.brownView addSubview:btn];
        
    }
    
    
    for (int i = 0; i < 2; i++) {
        
        //此处frame有问题
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((kScreenWidth/2+80), 10+i*20
                               , 50, 20);
        [btn setTitle:taskArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
//        btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.brownView addSubview:btn];
        
    }
}


#pragma mark 数据
- (void)loadData{

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [XTomRequest requestWithURL:@"http://123.56.237.91/index.php/Webservice/v300/user_income" target:self selector:@selector(loadData:) parameter:dic];
}


- (void)loadData:(NSDictionary *)infor{

//        NSLog(@"-----%@",infor);
    NSDictionary *dic = [infor objectForKey:@"infor"];
    
    NSString *money = [NSString stringWithFormat:@"%@",[dic objectForKey:@"total"]];
//    NSLog(@"%@",money);
    
    self.moneyLabel.text = money;

    NSString *taskStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"task"]];
    NSString *invite = [NSString stringWithFormat:@"%@",[dic objectForKey:@"invite"]];
    NSArray *arr = @[taskStr,invite];
//
    [self initWithButton:arr];

}

#pragma mark 
- (void)initWithView{

    [self initWithLastView];
}

#pragma mark 收益部分
- (void)initWithLastView{

    [self.brownView addSubview:self.moneyLabel];
    [self.brownView addSubview:self.titleLabel];
    [self addSubview:self.brownView];
    [self.brownView addSubview:self.lineView];
    [self.brownView addSubview:self.moneyImage];
    [self.brownView addSubview:self.horizontalLine];
    
//    self.brownView.backgroundColor = [UIColor yellowColor];
    self.brownView.sd_layout
    .leftSpaceToView(self,5).rightSpaceToView(self,5)
    .topSpaceToView(self,5).heightRatioToView(self,0.4);
    
    self.moneyLabel.sd_layout
    .leftSpaceToView(self.brownView,25).topSpaceToView(self.brownView,25)
    .widthRatioToView(self.brownView,0.4).heightIs(28);

    self.moneyImage.sd_layout
    .leftSpaceToView(self.brownView,25).topSpaceToView(self.brownView,13)
    .widthIs(12).heightIs(11);
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.brownView,45).topSpaceToView(self.brownView,10)
    .widthIs(60).heightIs(20);

    
    self.horizontalLine.sd_layout
    .leftSpaceToView(self.brownView,5).rightSpaceToView(self.brownView,5)
    .heightIs(1).topSpaceToView(self.moneyLabel,10);
    
}

#pragma mark 任务邀请账本事件
- (void)btnAct:(UIButton *)btn{

    switch (btn.tag - 100) {
        case 0:
        {
        //跳转到任务做单
            [self.viewController.tabBarController setSelectedIndex:1];
        }
            break;
        case 1:
        {
            [self.viewController.tabBarController setSelectedIndex:3];
            
        }
            break;
        case 2:
        {
        
            HYMMyBooksVC *mybook = [[HYMMyBooksVC alloc] init];
            [self.viewController.navigationController pushViewController:mybook animated:YES ];

        }
            break;
        default:
            break;
    }
    
}

@end
