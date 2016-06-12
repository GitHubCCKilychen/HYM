//
//  HYMPostedCaseVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPostedCaseVC.h"
#import "HYMPostedView.h"
#import "HYMPostedTable.h"
#import "HYMChangeTask.h"
@interface HYMPostedCaseVC ()<HYMPostedTableDelegate>
@property (nonatomic,strong)HYMPostedView *bottomView;
@property (nonatomic,strong)HYMPostedTable *tableView;
@property (nonatomic,strong)HYMChangeTask *changeTask;
@property (nonatomic,strong)NSMutableArray *datalist;

@end

@implementation HYMPostedCaseVC

// 此页面有两个问题，1.cell个数改变，2.bottom的展示与隐藏
- (HYMChangeTask *)changeTask{

    if (_changeTask == nil) {
        
        _changeTask = [[HYMChangeTask alloc] init];
        _changeTask.frame = CGRectMake(0, kScreenHeight-85, kScreenWitdth, 85);
    }
    return _changeTask;
}

-(HYMPostedView *)bottomView{

    if (_bottomView == nil) {
        
        _bottomView = [[HYMPostedView alloc] init];
        _bottomView.frame = CGRectMake(0, kScreenHeight-85, kScreenWitdth, 85);
    }
    return _bottomView;
}

-(HYMPostedTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMPostedTable alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.postedTableDelegate = self;
        _tableView.tableFooterView = self.bottomView;
    
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDefault];
    [self initWithView];
}


- (void)setIndex:(int)index{

    _index = index;
    
    [self loadData:_index];
}
#pragma mark 数据
- (void)loadData:(int )index{

    self.datalist = [NSMutableArray array];
    
    NSString *indexStr = [NSString stringWithFormat:@"%d",index];
    

    NSDictionary *dic = @{@"task_id":indexStr,@"token":@"1"};
    NSMutableDictionary *dics = [NSMutableDictionary dictionaryWithDictionary:dic];
    [XTomRequest requestWithURL:@"http://123.56.237.91/index.php/Webservice/center/task_publish" target:self selector:@selector(taskData:) parameter:dics];
}

- (void)taskData:(NSDictionary *)dic{

    
    NSLog(@"%@-%@",dic,[dic objectForKey:@"msg"]);
    
}
- (void)initDefault{
    
    self.title = @"发布情况";
    self.view.backgroundColor = [UIColor whiteColor];
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    
}
- (void)initWithView{

    [self.view addSubview:self.tableView];
    
}

- (void)removeBottomView{

   
    self.tableView.tableFooterView.hidden = YES;
    self.tableView.tableFooterView = self.changeTask;
}

- (void)addBotttomView{

    //此处转化有问题
    self.tableView.tableFooterView.hidden = NO;
//    self.tableView.tableFooterView = self.bottomView;
}

@end
