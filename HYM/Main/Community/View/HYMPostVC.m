//
//  HYMPostVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/6.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPostVC.h"
#import "HYMEditPost.h"
#import "HYMPostView.h"
@interface HYMPostVC ()

@property (nonatomic,strong)HYMEditPost *editPost;
@property (nonatomic,strong)HYMPostView *bottomView;
@end

@implementation HYMPostVC

- (HYMEditPost *)editPost{

    if (_editPost == nil) {
        
        _editPost = [[HYMEditPost alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _editPost;
}

- (HYMPostView *)bottomView{

    if (_bottomView == nil) {
        
        _bottomView = [[HYMPostView alloc] init];
        _bottomView.frame = CGRectMake(0, kScreenHeight-44, kScreenWitdth, 44);
    }
    return _bottomView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //默认
    [self initDefalut];
    //
    [self initWithView];
}

#pragma mark 默认
- (void)initDefalut{

    self.title = @"发表帖子";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    
    UIButton *edit = [UIButton buttonWithType:UIButtonTypeCustom];
    edit.frame = CGRectMake(0, 0, 30, 30);
    edit.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [edit setImage:[UIImage imageNamed:@"上传"] forState:UIControlStateNormal];
    [self.navigationController.navigationBar addSubview:edit];
    
    UIButton *release = [UIButton buttonWithType:UIButtonTypeCustom];
    release.frame = CGRectMake(0, 0, 30, 30);
    [release setTitle:@"发布" forState:UIControlStateNormal];
    release.titleLabel.font = [UIFont systemFontOfSize:15];
    [release setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [release addTarget:self action:@selector(releaseAct:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithCustomView:edit];
    
    UIBarButtonItem *releItem = [[UIBarButtonItem alloc] initWithCustomView:release];
    self.navigationItem.rightBarButtonItems = @[releItem,editItem];
}

- (void)initWithView{

    [self.view addSubview:self.editPost];
    
    [self.view addSubview:self.bottomView];
}


- (void)releaseAct:(UIButton *)btn{

    //请求上传
    NSDictionary *dic = @{@"id":@"7786"};
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    //网络请求
    [XTomRequest  requestWithURL:@"http://123.56.237.91//index.php/Webservice/v203/blog_get" target:self selector:@selector(loadData:) parameter:infoDic];
}

- (void)loadData:(NSDictionary *)dic{

    NSLog(@"%@-%@",dic,[dic objectForKey:@"msg"]);
    
}
@end
