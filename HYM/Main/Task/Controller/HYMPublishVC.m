//
//  HYMPublishVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/3.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPublishVC.h"
#import "HYMPublishTableView.h"
#import "HYMPublishView.h"
#import "HYMPublishBottomView.h"
#import "HYMPublishHelp.h"
@interface HYMPublishVC ()

@property (nonatomic,strong)HYMPublishTableView *tableView;
@property (nonatomic,strong)HYMPublishView *publishView;
@property (nonatomic,strong)HYMPublishBottomView *bottomView;
@property (nonatomic,strong)UIView *prompt;//提示
@property (nonatomic,strong)UIImageView *imageView;//提醒
@property (nonatomic,strong)UILabel *topic;//
@end

@implementation HYMPublishVC


-(UIImageView *)imageView{

    if (_imageView == nil) {
        
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(20, 2.5, 25, 25);
        _imageView.backgroundColor = [UIColor grayColor];
    }
    return _imageView;
}

- (UILabel *)topic{

    if (_topic == nil) {
        
        _topic = [[UILabel alloc] init];
        _topic.frame = CGRectMake(55, 5, kScreenWitdth-50, 20);
        _topic.text = @"上传未通过的任务：官方回复：由于您……";
        [HYMTool initLabel:_topic withFont:[UIFont systemFontOfSize:12] withTextColor:[UIColor orangeColor] withTextAlignment:NSTextAlignmentLeft];
    }
    return _topic;
}
- (UIView *)prompt{

    if (_prompt == nil) {
        
        _prompt = [[UIView alloc] init];
        _prompt.frame = CGRectMake(0, 64, kScreenWitdth, 30);
        _prompt.backgroundColor = [UIColor colorWithRed:251/256.f green:228/256.f blue:221/256.f alpha:1];
    }
    return _prompt;
}

-(HYMPublishBottomView *)bottomView{

    if (_bottomView ==nil) {
        
        _bottomView = [[HYMPublishBottomView alloc] init];
        _bottomView.frame = CGRectMake(0, 0, kScreenWitdth, 160);
        
    }
    return _bottomView;
}

-(HYMPublishView *)publishView{
    if (_publishView == nil) {
        
        _publishView = [[HYMPublishView alloc] init];
//        _publishView.backgroundColor = [UIColor grayColor];
        _publishView.frame = CGRectMake(0, 0, kScreenWitdth, 140);
    }
    return _publishView;
}

-(HYMPublishTableView *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMPublishTableView alloc] initWithFrame:CGRectMake(0, 94, kScreenWitdth, kScreenHeight-94) style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = self.publishView;
        _tableView.tableFooterView = self.bottomView;
    }
    
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
    [self initDefault];
    [self initWithView];
    
}

#pragma makr 数据
- (void)loadData{

    
    NSDictionary *dic = @{@"title":@"陆金所",@"brand":@"陆金所单子",@"logo":@"http://www.baidu.com",@"task_number":@"2",@"benjin":@"10000",@"shouyi":@"50",@"fanli":@"2",@"timelimit":@"5",@"start_time":@"2016-5-5",@"end_time":@"2016-5-10",@"must_option":@"name",@"address":@"3242",@"offsale_time":@"2017-1-1",@"is_auto":@"1",@"token":@"1"};
    
    NSMutableDictionary *dics = [NSMutableDictionary dictionaryWithDictionary:dic];
    [XTomRequest requestWithURL:@"http://123.56.237.91/index.php/Webservice/Task/task_add" target:self selector:@selector(loadData:) parameter:dics];
    
}

- (void)loadData:(NSDictionary *)dic{

//    NSLog(@"%@-%@",dic,[dic objectForKey:@"msg"]);
    
    //此处没有返回数据
    
}

#pragma mark 
- (void)initDefault{

    self.title = @"上传任务参数";
   
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    
    UIButton *help = [UIButton buttonWithType:UIButtonTypeCustom];
    [help setImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
    help.frame = CGRectMake(0, 0, 20, 20);
    [help addTarget:self action:@selector(helpAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:help];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:help];
    self.navigationItem.rightBarButtonItem = right;
}

#pragma mark 帮助
- (void)helpAct:(UIButton *)btn{

    HYMPublishHelp *help = [[HYMPublishHelp alloc] init];
    [self.navigationController pushViewController:help animated:YES];
    
}
#pragma mark view
- (void)initWithView{

    [self.prompt addSubview:self.imageView];
    [self.prompt addSubview:self.topic];
    [self.view addSubview:self.prompt];
    [self.view addSubview:self.tableView];
                                                   
    
}
@end
