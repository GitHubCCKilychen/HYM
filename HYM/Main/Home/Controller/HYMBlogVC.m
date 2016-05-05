//
//  HYMBlogVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/21.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMBlogVC.h"
#import "HYMTaskBottom.h"
@interface HYMBlogVC ()
@property (nonatomic,strong)HYMTaskBottom *bottom;
@end

@implementation HYMBlogVC

- (HYMTaskBottom *)bottom{

    if (_bottom == nil) {
        
        _bottom = [[[NSBundle mainBundle]loadNibNamed:@"HYMTaskBottom" owner:self options:nil] lastObject];
        _bottom.frame = CGRectMake(0, kScreenHeight-49, kScreenWitdth, 49);
    }
    return _bottom;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWithView];
}

- (void)initWithView{
 
    [self.view addSubview:self.bottom];
}



@end
