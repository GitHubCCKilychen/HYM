//
//  HYMSearchVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/9.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMSearchVC.h"

@interface HYMSearchVC ()

@end

@implementation HYMSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self searchLoadData];
    [self initDefault];
    [self initWithView];
}

#pragma mark 数据
- (void)loadData{

    //1添加好友 2 删除好友 keyid：好友ID
    NSDictionary *dic = @{@"keyid":@"3",@"oper":@"1",@"token":@"1"};
    
    NSMutableDictionary *nsDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    //网络请求
    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/v300/follow" target:self selector:@selector(infoData:) parameter:nsDic];
}
- (void)infoData:(NSDictionary *)dic{

//    NSLog(@"%@",dic);
}

#pragma mark 搜索好友
- (void)searchLoadData{

    //keywords:用户id或者昵称
    NSDictionary *dic = @{@"keywords":@"3",@"page":@"1",@"token":@"1"};
    
    NSMutableDictionary *nsDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    //网络请求
    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/center/user_search" target:self selector:@selector(searchData:) parameter:nsDic];
    
}

- (void)searchData:(NSDictionary *)dic{
//数据有
    NSLog(@"%@",dic);
}
- (void)initDefault{

    self.title = @"搜索好友";
    self.view.backgroundColor = [UIColor whiteColor];
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
}

- (void)initWithView{

    
}



@end
