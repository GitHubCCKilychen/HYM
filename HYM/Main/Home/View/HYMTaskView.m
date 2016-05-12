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
    
    
    NSArray *titleArr = @[@"任务赚钱",@"邀请奖励",@"我的账本"];
    
    for (int i = 0; i < 3; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kScreenWidth/10+(kScreenWidth/3)*i, self.brownView.frame.size.height+10, 45, 45);
        btn.backgroundColor = [UIColor brownColor];
        [btn addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        [self addSubview:btn];
        
 
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(kScreenWidth/10+(kScreenWidth/3)*i, 60+self.brownView.frame.size.height, 50, 20);
        title.text = [NSString stringWithFormat:@"%@",titleArr[i]];
        title.font = [UIFont systemFontOfSize:12];
        [self addSubview:title];
   
    }
  
    NSArray *titleA = @[@"任务返利",@"邀请返利"];
    for (int i = 0; i < 2; i++) {
        
        //此处frame有问题
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((kScreenWidth/2+10), 20+i*20, 50, 20);
        [btn setTitle:titleA[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.brownView addSubview:btn];
        
    }
    
    
    for (int i = 0; i < 2; i++) {
        
        //此处frame有问题
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((kScreenWidth/2+80), 20+i*20
                               , 50, 20);
        [btn setTitle:taskArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.brownView addSubview:btn];
        
    }
}


#pragma mark 数据
- (void)loadData{

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [XTomRequest requestWithURL:@"http://123.56.237.91/index.php/Webservice/?m=Base&a=user_income" target:self selector:@selector(loadData:) parameter:dic];
}


- (void)loadData:(NSDictionary *)infor{

    NSDictionary *dic = [infor objectForKey:@"infor"];
    
    NSString *money = [NSString stringWithFormat:@"%@",[dic objectForKey:@"total"]];
    self.moneyLabel.text = money;
    
    NSArray *arr = @[[dic objectForKey:@"task"],[dic objectForKey:@"invite"]];

    
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
    
    //黄色部分在iPhone4上有问题
    self.brownView.sd_layout
    .leftSpaceToView(self,5).rightSpaceToView(self,5)
    .topSpaceToView(self,5).heightRatioToView(self,0.5);
    
    self.moneyLabel.sd_layout
    .leftSpaceToView(self.brownView,20).topSpaceToView(self.brownView,45)
    .widthRatioToView(self.brownView,0.4).heightIs(28);
    
    self.moneyImage.backgroundColor = [UIColor grayColor];
    self.moneyImage.sd_layout
    .leftEqualToView(self.moneyLabel).topSpaceToView(self.brownView,20)
    .widthEqualToHeight(15);
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.brownView,45).topSpaceToView(self.brownView,20)
    .widthIs(60).heightIs(20);
    
//    self.lineView.backgroundColor = [UIColor grayColor];
    self.lineView.sd_layout
    .leftSpaceToView(self.moneyLabel,10).topSpaceToView(self.brownView,10)
    .bottomSpaceToView(self.brownView,10).widthIs(0.8);
    
    self.horizontalLine.sd_layout
    .leftSpaceToView(self.brownView,5).rightSpaceToView(self.brownView,5)
    .heightIs(1).bottomSpaceToView(self.brownView,0.8);
    
}

#pragma mark 任务邀请账本事件
- (void)btnAct:(UIButton *)btn{

    switch (btn.tag - 100) {
        case 0:
        {
         NSLog(@"0");
        }
            break;
        case 1:
        {
         NSLog(@"1");
        }
            break;
        case 2:
        {
        
            HYMMyBooksVC *myBooks = [[HYMMyBooksVC alloc] init];
            [self.viewController.navigationController pushViewController:myBooks animated:YES];
        }
            break;
        default:
            break;
    }
    
}

@end
