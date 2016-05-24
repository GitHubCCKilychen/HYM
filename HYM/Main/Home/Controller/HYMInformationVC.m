//
//  HYMInformationVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/20.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMInformationVC.h"
#import "HYMInfoTableView.h"
#import "HYMTodayInfoModel.h"
#import "HYMSegmentView.h"
@interface HYMInformationVC ()<HYMSegmentViewDelegate>
@property (nonatomic,strong)HYMInfoTableView *infoTable;
@property (nonatomic,strong)NSMutableArray *infoArr;
@property (nonatomic,strong)HYMSegmentView *segment;
@property (nonatomic,strong)NSMutableArray *bankArr;


@end

@implementation HYMInformationVC

- (NSMutableArray *)infoArr{

    if (_infoArr == nil) {
        _infoArr = [NSMutableArray array];
    }
    return _infoArr;
}

- (NSMutableArray *)bankArr{

    if (_bankArr == nil) {
        
        _bankArr = [NSMutableArray array];
    }
    return _bankArr;
}
- (HYMSegmentView *)segment{

    if (_segment == nil) {
        
        NSArray *arr = @[@"网贷资讯",@"银行咨询"];
        _segment = [HYMSegmentView segmenFrame:CGRectMake(80, 0, kScreenWitdth-80, 44) titleDataSource:arr backgroundColor:[UIColor clearColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:15] selectedColor:[UIColor blackColor ] buttonDownColor:[UIColor redColor] delegate:self];
    }
    return _segment;
}
- (HYMInfoTableView *)infoTable{

    if (_infoTable == nil) {
        
        _infoTable = [[HYMInfoTableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _infoTable;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self initWithView];
   
}


#pragma nark 表格
- (void)initWithView{
    
    
    [self segumentSelectionChange:0];
    [self.view addSubview:self.infoTable];

    

}

#pragma mark 选择－－此处有问题－－数据累积
-(void)segumentSelectionChange:(NSInteger)selection{
    self.infoTable.buttonIndex = selection;
    
    if (selection == 1) {
        
    
        NSDictionary *dic = @{@"sellerid":@"无",@"keyid":@"0",@"client_id":@"1",@"ordertype":@"desc",@"keytype":@"13",@"page":@"0",@"orderby":@"2"};
        
        NSMutableDictionary *infoDic = [NSMutableDictionary dictionaryWithDictionary:dic ];
        //网络请求
        [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/v203/blog_list" target:self selector:@selector(bankData:) parameter:infoDic];
        
    
        
    }
    else if (selection == 0){
    
        
        NSDictionary *dic = @{@"sellerid":@"无",@"keyid":@"0",@"client_id":@"1",@"ordertype":@"desc",@"keytype":@"12",@"page":@"0",@"orderby":@"2"};
        
        NSMutableDictionary *infoDic = [NSMutableDictionary dictionaryWithDictionary:dic ];
        //网络请求
        [XTomRequest  requestWithURL:@"http://123.56.237.91/index.php/Webservice/v203/blog_list" target:self selector:@selector(infoData:) parameter:infoDic];
        
        
    }
}

- (void)bankData:(NSDictionary *)infoDic{

    [self.infoArr removeAllObjects];
       ;
    if (1 == [[infoDic objectForKey:@"success"] intValue]) {

        NSDictionary *infor = [infoDic objectForKey:@"infor"];
        //
        NSArray *listItems = [infor objectForKey:@"listItems"];
        //
        
        for (NSDictionary *dic in listItems) {
  
            HYMTodayInfoModel *model = [[HYMTodayInfoModel alloc] initWithDictionary:dic];
            
            [self.bankArr addObject:model];
            
            self.infoTable.bankArr = self.bankArr;

        }
        
          }else{
        
        NSLog(@"错误");
        //
    }
}

- (void)infoData:(NSDictionary *)infoDic{
    
    NSLog(@"%@",infoDic);
    [self.bankArr removeAllObjects];
    if (1 == [[infoDic objectForKey:@"success"] intValue]) {
        //
        NSDictionary *infor = [infoDic objectForKey:@"infor"];
        //
        NSArray *listItems = [infor objectForKey:@"listItems"];
        //
        
        for (NSDictionary *dic in listItems) {
            //
            //              NSLog(@"%@",dic);
            HYMTodayInfoModel *model = [[HYMTodayInfoModel alloc] initWithDictionary:dic];
            [self.infoArr addObject:model];
            
            self.infoTable.infoArr = self.infoArr;

        }
        
    }else{
        
        NSLog(@"错误");
        //
    }
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
