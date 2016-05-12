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
#import "HYMSearchVC.h"
@interface HYMContactsVC ()<HYMSegmentViewDelegate>

@property (nonatomic,strong)HYMSegmentView *segmentView;
@property (nonatomic,strong)HYMInvitationView *invitationView;
@property (nonatomic,strong)HYMFriendsView *friendsView;
@property (nonatomic,strong)HYMWoolletterView *woolView;
@property (nonatomic,weak)UIButton *btn;
@property (nonatomic,weak)UIButton *message;
@property (nonatomic,strong)UIView *addFriend;
@property (nonatomic,strong)UIButton *addFriendBtn;

@end

@implementation HYMContactsVC

- (UIButton *)addFriendBtn{

    if (_addFriendBtn == nil) {
        
        _addFriendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addFriendBtn.frame = CGRectMake(0, 0, 100, 60);
        [_addFriendBtn setTitle:@"添加朋友" forState:UIControlStateNormal];
        [_addFriendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addFriendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_addFriendBtn addTarget:self action:@selector(addFriendBtnAct:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _addFriendBtn;
}

- (UIView *)addFriend{

    if (_addFriend == nil) {
        
        _addFriend = [[UIView alloc] init];
        _addFriend.backgroundColor = [UIColor orangeColor];
        _addFriend.frame = CGRectMake(kScreenWitdth - 150, 64, 100, 60);
        [_addFriend addSubview:self.addFriendBtn];
    }
    return _addFriend;
}

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
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
    self.btn = btn;
    btn.backgroundColor = [UIColor brownColor];
    [self.navigationController.navigationBar addSubview:btn];
    
    UIButton *message = [UIButton buttonWithType:UIButtonTypeCustom];
    message.frame = CGRectMake(0, 0, 30, 30);
    self.message = message;
    message.backgroundColor = [UIColor greenColor];
    [self.navigationController.navigationBar addSubview:message];
    
    
    UIBarButtonItem *messageItem = [[UIBarButtonItem alloc] initWithCustomView:message];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItems = @[messageItem,btnItem];
}

- (void)initWithView{
  
    //顺序问题
    
    //信息
    self.friendsView.hidden = YES;
    [self.view addSubview:self.friendsView];
    //羊毛信
    self.woolView.hidden = YES;
    [self.view addSubview:self.woolView];
    
    
    //邀请
    [self.view addSubview:self.invitationView];

}

#pragma mark 协议方法
-(void)segumentSelectionChange:(NSInteger)selection{
    
    if (selection == 0 ) {
        self.invitationView.hidden = NO;
        self.woolView.hidden = YES;
        self.friendsView.hidden = YES;
        self.btn.backgroundColor = [UIColor brownColor];
        self.message.backgroundColor = [UIColor greenColor];
        self.addFriend.hidden = YES;
        
    }else if (selection == 1){
    
        self.invitationView.hidden = YES;
        self.woolView.hidden = NO;
        self.friendsView.hidden = YES;
        self.btn.backgroundColor = [UIColor redColor];
        self.message.backgroundColor = [UIColor grayColor];
        self.addFriend.hidden = YES;
        
    }else{
    
        self.woolView.hidden = YES;
        self.invitationView.hidden = YES;
        self.friendsView.hidden= NO;
        self.btn.backgroundColor = [UIColor redColor];
        self.message.backgroundColor = [UIColor grayColor];
        self.addFriend.hidden = NO;
        //添加好友
        [self.btn addTarget:self action:@selector(addFriend:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

- (void)addFriend:(UIButton *)btn{

   
    
    if (btn.selected == NO) {
        
        [self.addFriend addSubview:self.addFriendBtn];
        [self.view addSubview:self.addFriend];
        NSLog(@"显示");
        btn.selected = YES;
    }else if (btn.selected == YES){
    
        [self.addFriend removeFromSuperview];
        NSLog(@"隐藏");
        btn.selected = NO;
    }
    
}

#pragma mark 添加好友
- (void)addFriendBtnAct:(UIButton *)btn{
    
    HYMSearchVC *search = [[HYMSearchVC alloc] init];
    [self.navigationController pushViewController:search animated:YES];
    
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
