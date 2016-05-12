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
@interface HYMUploadTask ()

@property (nonatomic,strong)HYMUpHeader *header;
@property (nonatomic,strong)HYMUpTable *tableView;
@end

@implementation HYMUploadTask

- (HYMUpHeader *)header{

    if (_header == nil) {
        
        _header = [[HYMUpHeader alloc] init];
        _header.frame = CGRectMake(0, 0, kScreenWitdth, 110);
    }
    return _header;
}

- (HYMUpTable *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[HYMUpTable alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _tableView.tableHeaderView = self.header;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDefault];
    [self initWithView];
}

- (void)initDefault{

    self.view.backgroundColor= [UIColor whiteColor];
    self.title = @"上传任务";
    [HYMNavigationVC setTitle:[UIColor blackColor] withFontSize:15 withNavi:self.navigationController.navigationBar];
    
}

- (void)initWithView{
    [self.view addSubview:self.tableView];
    
}



@end
