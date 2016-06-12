//
//  HYMLunTanJoinVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMLunTanJoinVC.h"
#import "HYMSegmentView.h"
#import "HYMLunTanTable.h"

@interface HYMLunTanJoinVC ()<HYMSegmentViewDelegate>

@property (nonatomic,strong)HYMSegmentView *segment;
@property (nonatomic,strong)HYMLunTanTable *tableView;


@end

@implementation HYMLunTanJoinVC

- (HYMSegmentView *)segment{

    if (_segment == nil) {
        
        NSArray *titleArr = @[@"发布的",@"参与的"];
        _segment = [HYMSegmentView segmenFrame:CGRectMake(80, 0, kScreenWitdth-150, 44) titleDataSource:titleArr backgroundColor:[UIColor clearColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:15] selectedColor:[UIColor orangeColor] buttonDownColor:[UIColor orangeColor] delegate:self];
    }
    return _segment;
}

- (HYMLunTanTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMLunTanTable alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self initDefault];
    [self initView];
}
#pragma mark 数据
- (void)loadData{

    NSDictionary *money = @{@"page":@"1"};
    
    NSMutableDictionary *nsdic = [NSMutableDictionary dictionaryWithDictionary:money];

    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/center/my_bbs" target:self selector:@selector(loadData:) parameter:nsdic];
}

- (void)loadData:(NSDictionary *)dic{

    
    NSLog(@"%@-%@",dic,[dic objectForKey:@"msg"]);
}

- (void)initDefault{

    
    self.view.backgroundColor = BB_Back_Color_Here;
    UIButton *search = [UIButton buttonWithType:UIButtonTypeCustom];
    search.frame = CGRectMake(0, 0, 20, 20);
    
    search.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"taskSearch"]];
    [self.navigationController.navigationBar addSubview:search];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:search];
    self.navigationItem.rightBarButtonItem = right;
}
- (void)initView{
    [self.view addSubview:self.tableView];
    
}
#pragma mark 参与－发布
-(void)segumentSelectionChange:(NSInteger)selection{
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar addSubview:self.segment];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.segment removeFromSuperview];
}



@end
