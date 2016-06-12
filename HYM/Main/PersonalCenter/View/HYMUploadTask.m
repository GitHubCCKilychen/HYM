//
//  HYMUploadTask.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/10.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMUploadTask.h"
#import "HYMUpHeader.h"
#import "HYMUpTable.h"
#import "HYMUpModel.h"
#import "HYMSegmentView.h"
#import "HYMUpHelp.h"
@interface HYMUploadTask ()<HYMSegmentViewDelegate>
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UIView *line2View;
@property (nonatomic,strong)HYMUpHeader *header;
@property (nonatomic,strong)HYMUpTable *tableView;
@property (nonatomic,strong)NSMutableArray *datalist;
@property (nonatomic,strong)HYMSegmentView *segmentView;
@end

@implementation HYMUploadTask

- (HYMSegmentView *)segmentView{
    
    if (_segmentView == nil) {
        
        NSArray *titieArr = @[@"上传未通过的任务",@"草稿未上线的项目"];
        _segmentView = [HYMSegmentView segmenFrame:CGRectMake(0,120+64 , kScreenWitdth, 35) titleDataSource:titieArr backgroundColor:[UIColor whiteColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:14] selectedColor:[UIColor orangeColor] buttonDownColor:[UIColor orangeColor] delegate:self];
    }
    return _segmentView;
}
- (UIView *)lineView{

    if (_lineView == nil) {
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWitdth/2-0.5, 10, 1, 15)];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}
- (HYMUpHeader *)header{

    if (_header == nil) {
        
        _header = [[HYMUpHeader alloc] init];
        _header.frame = CGRectMake(0, 64, kScreenWitdth, 120);
    }
    return _header;
}

- (UIView *)line2View{

    if (_line2View == nil) {
        
        _line2View = [[UIView alloc] initWithFrame:CGRectMake(0, 34, kScreenWitdth, 0.5)];
        _line2View.backgroundColor = [UIColor lightGrayColor];
    }
    return _line2View;
}

- (HYMUpTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMUpTable alloc] initWithFrame:CGRectMake(0, 155+64, kScreenWitdth, kScreenHeight-155-64)];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self initDefault];
    [self initWithView];
}

- (void)initDefault{

    self.view.backgroundColor= [UIColor whiteColor];
    self.title = @"上传任务";
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

    //跳转到帮助页面
    HYMUpHelp *help = [[HYMUpHelp alloc] init];
    [self.navigationController pushViewController:help animated:YES];
}

#pragma mark view
- (void)initWithView{
    
    [self.view addSubview:self.header];
    [self.view addSubview:self.segmentView];
    [self.segmentView addSubview:self.lineView];
    [self.segmentView addSubview:self.line2View];
    [self.view addSubview:self.tableView];
    
    
}

#pragma mark 数据
- (void)loadData{

    
    self.datalist = [NSMutableArray array];
    [self segumentSelectionChange:0];
    
}

- (void)loadData:(NSDictionary *)infor{

    [self.datalist removeAllObjects];
    NSDictionary *dic = [infor objectForKey:@"infor"];
    
    NSArray *listItems = [dic objectForKey:@"listItems"];
    
    for (NSDictionary *dic in listItems) {
        
        HYMUpModel *model = [[HYMUpModel alloc] initWithDictionary:dic];
        
        [self.datalist addObject:model];
        self.tableView.datalist = self.datalist;
        [self.tableView reloadData];

    }
}
-(void)segumentSelectionChange:(NSInteger)selection{

    if (selection ==0) {
        
     
        NSDictionary *dic = @{@"audit_status":@"0",@"page":@"1",@"token":@"1"};
        NSMutableDictionary *nsdic = [NSMutableDictionary dictionaryWithDictionary:dic];
        [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/center/task_list_forward" target:self selector:@selector(loadData:) parameter:nsdic];
    }else if(selection == 1){
    
       
        NSDictionary *dic = @{@"audit_status":@"1",@"page":@"1",@"token":@"1"};
        NSMutableDictionary *nsdic = [NSMutableDictionary dictionaryWithDictionary:dic];
        [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/center/task_list_forward" target:self selector:@selector(loadData2:) parameter:nsdic];
        
    }
    
}

- (void)loadData2:(NSDictionary *)infor{

    
    NSDictionary *dic = [infor objectForKey:@"infor"];
    [self.datalist removeAllObjects];
    NSArray *listItems = [dic objectForKey:@"listItems"];
    
    for (NSDictionary *dic in listItems) {
        
        HYMUpModel *model = [[HYMUpModel alloc] initWithDictionary:dic];
        
        [self.datalist addObject:model];
        self.tableView.datalist = self.datalist;
        [self.tableView reloadData];
        
    }
}


@end
