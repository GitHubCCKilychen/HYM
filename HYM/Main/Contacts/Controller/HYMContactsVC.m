//
//  HYMContactsVC.m
//  HYM
//
//  Created by 刘晓雪 on 16/4/12.
//  Copyright © 2016年 haokewangluo. All rights reserved.
//

#import "HYMContactsVC.h"
#import "HYMSegmentView.h"
#import "HYMInvitationView.h"
#import "HYMFriendsView.h"
#import "HYMWoolletterView.h"
@interface HYMContactsVC ()<HYMSegmentViewDelegate>

@property (nonatomic,strong)HYMSegmentView *segmentView;
@property (nonatomic,strong)HYMInvitationView *invitationView;
@property (nonatomic,strong)HYMFriendsView *friendsView;
@property (nonatomic,strong)HYMWoolletterView *woolView;

@end

@implementation HYMContactsVC

- (HYMWoolletterView *)woolView{

    if (_woolView == nil) {
        
        _woolView =[[HYMWoolletterView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _woolView;
}
- (HYMInvitationView *)invitationView{

    if (_invitationView == nil) {
        
        _invitationView = [[HYMInvitationView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _invitationView;
}

- (HYMFriendsView *)friendsView{

    if (_friendsView == nil) {
        
        _friendsView = [[HYMFriendsView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _friendsView;
}

-(HYMSegmentView *)segmentView{

    if (_segmentView == nil) {
        
        NSArray *titleArr = @[@"邀请",@"羊毛信",@"通讯录"];
        _segmentView = [HYMSegmentView segmenFrame:CGRectMake(0, 0, kScreenWitdth-100, 44) titleDataSource:titleArr backgroundColor:[UIColor clearColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:15] selectedColor:[UIColor orangeColor] buttonDownColor:[UIColor orangeColor] delegate:self];
    }
    return _segmentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDefault];
    [self initWithView];

}


- (void)initDefault{

    self.view.backgroundColor = [UIColor colorWithRed:235/256.f green:235/256.f blue:241/256.f alpha:1];
    
//    NSLog(@"%f",self.view.frame.size.height);
}

- (void)initWithView{

    //顺序问题
    
    self.friendsView.hidden = YES;
    [self.view addSubview:self.friendsView];
    self.woolView.hidden = YES;
    [self.view addSubview:self.woolView];
    [self.view addSubview:self.invitationView];

}

#pragma mark 协议方法
-(void)segumentSelectionChange:(NSInteger)selection{
    
    if (selection == 0 ) {
        self.invitationView.hidden = NO;
        self.woolView.hidden = YES;
        self.friendsView.hidden = YES;
        
    }else if (selection == 1){
    
        self.invitationView.hidden = YES;
        self.woolView.hidden = NO;
        self.friendsView.hidden = YES;
        
    }else{
    
        self.woolView.hidden = YES;
        self.invitationView.hidden = YES;
        self.friendsView.hidden= NO;
        
        
    }
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar addSubview:self.segmentView];
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [self.segmentView removeFromSuperview];
}
@end
