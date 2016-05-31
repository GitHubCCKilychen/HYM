//
//  HYMPersonalVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMPersonalVC.h"
#import "HYMPersonTable.h"
#import "HYMPersonHeader.h"
#import "HYMSystemSetting.h"
@interface HYMPersonalVC ()

@property (nonatomic,strong)HYMPersonTable *tableView;
@property (nonatomic,strong)HYMPersonHeader *header;
@end

@implementation HYMPersonalVC


-(HYMPersonHeader *)header{

    if (_header == nil) {
        
        _header = [[HYMPersonHeader alloc] init];
        _header.frame = CGRectMake(0, 0, kScreenWitdth, 150);
    }
    return _header;
}

- (HYMPersonTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMPersonTable alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = self.header;
    
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self initDefault];
    [self initWithView];
}

- (void)loadData{

    NSDictionary *dic = @{@"token":@"1"};
    
    NSMutableDictionary *nsdic = [NSMutableDictionary dictionaryWithDictionary:dic];

    [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/center/client_center_info" target:self selector:@selector(loadData:) parameter:nsdic];
    
}

- (void)loadData:(NSDictionary *)dic{

    NSDictionary *infor = [dic objectForKey:@"infor"];
    self.header.dic = infor;

    NSLog(@"%@",infor);
    NSString *status = [NSString stringWithFormat:@"%@",[infor objectForKey:@"apply_status"]];
    self.tableView.apply_status = [status intValue];
 
}
- (void)initDefault{

    self.title = @"个人中心";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    
    UIButton *setting = [UIButton buttonWithType:UIButtonTypeCustom];
    setting.frame = CGRectMake(0, 0, 20, 20);
    setting.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"personSet"]];
    [setting addTarget:self action:@selector(settingAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:setting];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:setting];
    self.navigationItem.rightBarButtonItem = right;
    
}

- (void)initWithView{

    [self.view addSubview:self.tableView];
    
}
- (void)settingAct:(UIButton *)setting{

    HYMSystemSetting *setVC = [[HYMSystemSetting alloc] init];
    [self.navigationController pushViewController:setVC animated:YES];
}

@end
