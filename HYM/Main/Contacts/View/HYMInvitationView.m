//
//  HYMInvitationView.m
//  HYM
//
//  Created by 刘晓雪 on 16/5/6.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMInvitationView.h"

#import "HYMInHeaderView.h"
#import "HYMInLastView.h"
@interface HYMInvitationView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)HYMInHeaderView *headerView;
@property (nonatomic,strong)HYMInLastView *lastView;

@property (nonatomic,strong)UITableView *tableView;
@end
@implementation HYMInvitationView

- (UITableView *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

-(HYMInHeaderView *)headerView{

    if (_headerView == nil) {
        
        _headerView = [[HYMInHeaderView alloc] init];
        }
    return _headerView;
}

-(HYMInLastView *)lastView{

    if (_lastView == nil) {
        
        _lastView = [[HYMInLastView alloc] init];
    }
    return _lastView;
}



#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
     
        [self initWithView];
    }
    return self;
}

#pragma mark 视图-
- (void)initWithView{


//    [self addSubview:self.tableView];
    
    [self addSubview:self.headerView];
    [self addSubview:self.lastView];
    
//    self.headerView.backgroundColor = [UIColor grayColor];
    //此处高度有问题
    self.headerView.sd_layout
    .leftSpaceToView(self,0).rightSpaceToView(self,0)
    .topSpaceToView(self,0).heightIs(204);
    
    self.lastView.backgroundColor = [UIColor whiteColor];
    self.lastView.sd_layout
    .leftSpaceToView(self,0).topSpaceToView(self.headerView,10)
    .rightSpaceToView(self,0).heightIs(310);
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;  
}
@end
