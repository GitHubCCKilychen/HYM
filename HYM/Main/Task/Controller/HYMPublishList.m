//
//  HYMPublishList.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/11.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPublishList.h"
#import "HYMTaskList.h"
@interface HYMPublishList ()

@property (nonatomic,strong)HYMTaskList *taskList;
@end

@implementation HYMPublishList


- (HYMTaskList *)taskList{

    if (_taskList == nil) {
        
        _taskList = [[HYMTaskList alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdth, kScreenHeight)];
    }
    return _taskList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self initDefault];
    [self initWithView];
}

- (void)loadData{

    NSDictionary *dic = @{@"task_id":@"1",@"token":@"1"};
    NSMutableDictionary *dics = [NSMutableDictionary dictionaryWithDictionary:dic];
    [XTomRequest requestWithURL:@"http://123.56.237.91/index.php/Webservice/center/task_publish" target:self selector:@selector(loadData:) parameter:dics];
}
- (void)loadData:(NSDictionary *)dic{

//    NSLog(@"%@-%@",dic,[dic objectForKey:@"msg"]);
    
    
}

- (void)initDefault{

    self.title = @"发布任务";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *right =[UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, 30, 30);
    right.backgroundColor = [UIColor grayColor];
    [self.navigationController.navigationBar addSubview:right];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)initWithView{

    
    [self.view addSubview:self.taskList];
}



@end
