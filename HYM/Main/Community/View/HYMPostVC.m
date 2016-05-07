//
//  HYMPostVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/6.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPostVC.h"
#import "HYMEditPost.h"
@interface HYMPostVC ()

@property (nonatomic,strong)HYMEditPost *editPost;
@end

@implementation HYMPostVC

- (HYMEditPost *)editPost{

    if (_editPost == nil) {
        
        _editPost = [[HYMEditPost alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _editPost;
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
    edit.frame = CGRectMake(0, 0, 40, 40);
    edit.backgroundColor = [UIColor brownColor];
    [self.navigationController.navigationBar addSubview:edit];
    
    UIButton *release = [UIButton buttonWithType:UIButtonTypeCustom];
    release.frame = CGRectMake(0, 0, 40, 40);
    [release setTitle:@"发布" forState:UIControlStateNormal];
    [release setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithCustomView:edit];
    
    UIBarButtonItem *releItem = [[UIBarButtonItem alloc] initWithCustomView:release];
    self.navigationItem.rightBarButtonItems = @[releItem,editItem];
}

- (void)initWithView{

    [self.view addSubview:self.editPost];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
