//
//  PullRefreshTableViewController.m
//  Plancast
//
//  Created by Leah Culver on 7/2/10.
//  Copyright (c) 2010 Leah Culver
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import <QuartzCore/QuartzCore.h>
#define REFRESH_HEADER_HEIGHT 52.0f
#define ADDMORE_HEIGHT 30.0f
#define ViewHieght (IS_IPHONE5?505.0f:417.0f)
#import "PullRefreshTVCGrouped.h"

@interface PullRefreshTVCGrouped()
{
    BOOL isForbidMore;
}

@end
@implementation PullRefreshTVCGrouped

@synthesize textPull, textRelease, textLoading, refreshHeaderView, refreshLabel, refreshArrow, refreshSpinner;
@synthesize mytable,noImgView;
@synthesize noDataLab;


- (void)dealloc
{
    [refreshHeaderView release];refreshHeaderView = nil;
    [textPull release];textPull = nil;
    [textRelease release];textRelease = nil;
    [textLoading release];textLoading = nil;
    
    [labelNoData release];labelNoData = nil;
    [noDataLab release]; noDataLab = nil;
    
    //私有属性
    [mytable release];mytable = nil;
    [noImgView release];noImgView = nil;
    //NSLog(@"加载刷新销毁");
    [super dealloc];
}

#pragma mark- 初始化

//新增 重新设置mytable的frame
- (void)reSetTableViewFrame:(CGRect)newFrame
{
    mytable.frame = newFrame;
    footerView.frame = CGRectMake(0, mytable.frame.size.height, 320, 30);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout= UIRectEdgeNone;
    
    self.mytable=[[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, ViewHieght) style:UITableViewStyleGrouped]autorelease];
    mytable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    mytable.delegate=self;
    mytable.dataSource=self;
    mytable.backgroundColor=[UIColor clearColor];
    mytable.showsHorizontalScrollIndicator = NO;
    mytable.showsVerticalScrollIndicator = NO;
    [mytable setBackgroundView:nil];
    [self.view addSubview:mytable];
    
    [self addPullToRefreshHeader];
    [self addPullFooterView];
    [self addNoDataView];
    
}

- (void)setupStrings{
    
    textPull = [[NSString alloc] initWithString:@"下拉可以刷新……"];
    textRelease = [[NSString alloc] initWithString:@"释放就刷新……"];
    textLoading = [[NSString alloc] initWithString:@"Loading..."];
}

- (void)addPullToRefreshHeader
{
    self.refreshHeaderView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0 - REFRESH_HEADER_HEIGHT, 04, REFRESH_HEADER_HEIGHT)]autorelease];
    refreshHeaderView.backgroundColor = [UIColor clearColor];
    
    self.refreshLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 304, REFRESH_HEADER_HEIGHT)]autorelease];
    refreshLabel.backgroundColor = [UIColor clearColor];
    refreshLabel.font = [UIFont boldSystemFontOfSize:12.0];
    refreshLabel.textAlignment = NSTextAlignmentCenter;
    refreshLabel.textColor = [UIColor colorWithRed:122/255.0 green:135/255.0 blue:155/255.0 alpha:1.0f];
    
    refreshTime=[[[UILabel alloc]initWithFrame:CGRectMake(155, 10, 100, REFRESH_HEADER_HEIGHT-20)]autorelease];
    [self getNewDate];
    //[refreshTime setHidden:YES];
    [refreshTime setTextAlignment:NSTextAlignmentLeft];
    refreshTime.backgroundColor=[UIColor clearColor];
    [refreshTime setFont:[UIFont systemFontOfSize:13]];
    [refreshTime setText:@"下拉刷新"];
    
    
    self.refreshArrow = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blueArrow.png"]]autorelease];
    refreshArrow.frame = CGRectMake(121, (floorf(REFRESH_HEADER_HEIGHT - 36) / 2),19.5, 36);
    
    self.refreshSpinner = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]autorelease];
    refreshSpinner.frame = CGRectMake(121, floorf((REFRESH_HEADER_HEIGHT - 20) / 2), 20, 20);
    refreshSpinner.hidesWhenStopped = YES;
    
    [refreshHeaderView addSubview:refreshLabel];
    [refreshHeaderView addSubview:refreshArrow];
    [refreshHeaderView addSubview:refreshSpinner];
    
    [refreshHeaderView addSubview:refreshTime];
    
    [mytable addSubview:refreshHeaderView];
}

-(void)addPullFooterView
{
    footerView=[[[UIView alloc]initWithFrame:CGRectMake(0,mytable.frame.size.height, 304, 30)]autorelease];
    footerView.tag=99999;footerView.hidden = NO;
    addmoreSpinner=[[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]autorelease];
    addmoreSpinner.frame=CGRectMake(121, floorf((footerView.frame.size.height - 20)/2), 20, 20);
    addmoreSpinner.hidesWhenStopped=YES;
    [addmoreSpinner startAnimating];
    [footerView addSubview:addmoreSpinner];
    [footerView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:footerView];
    
    addmoreLab = [[[UILabel alloc]initWithFrame:CGRectMake(155,0, 100, footerView.frame.size.height)]autorelease];
    addmoreLab.backgroundColor = [UIColor clearColor];
    addmoreLab.text = @"正在加载";
    addmoreLab.font = [UIFont fontWithName:@"Helvetica" size:13];
    addmoreLab.textColor = [UIColor colorWithRed:122/255.0 green:135/255.0 blue:155/255.0 alpha:1.0f];
    addmoreLab.textAlignment = NSTextAlignmentLeft;
    [footerView addSubview:addmoreLab];
}

//添加无数据view
-(void)addNoDataView
{
    noDataView = [[UIView alloc] initWithFrame:CGRectZero];
    [mytable insertSubview:noDataView belowSubview:refreshHeaderView];
    [noDataView release];
    
    self.noImgView = [[[UIImageView alloc]init]autorelease];
    [noImgView setImage:[UIImage imageNamed:@"暂无商品.png"]];
    [noImgView setFrame:CGRectMake(127, 71, 66, 66)];
    [noDataView addSubview:noImgView];
    
    self.noDataLab = [[UILabel alloc] init];
    noDataLab.numberOfLines = 0;
    noDataLab.backgroundColor = [UIColor clearColor];
    [noDataView addSubview:noDataLab];
    noDataLab.textAlignment = NSTextAlignmentCenter;
    noDataLab.textColor = BB_Gray;
    [noDataLab release];
    noDataView.hidden = YES;
    
}

#pragma mark- UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"scrollview.Y:%f",scrollView.contentOffset.y);
    if (isLoading)
    {
        if (scrollView.contentOffset.y > 0)
            mytable.contentInset = UIEdgeInsetsZero;
        else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
            mytable.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (isDragging && scrollView.contentOffset.y < 0)
    {
        [UIView animateWithDuration:0.25 animations:^{
            if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT)
            {
                [refreshTime setText:@"松开刷新"];
                refreshLabel.text = self.textRelease;
                [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            } else
            {
                [refreshTime setText:@"下拉刷新"];
                refreshLabel.text = self.textPull;
                [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
            }
        }];
    }
    else
    {
        if(isForbidMore)
        {
            return;
        }
        if (mytable.contentSize.height<mytable.frame.size.height)
        {
            if (scrollView.contentOffset.y>ADDMORE_HEIGHT)
            {
                
                if (!isMore)
                {
                    isMore=YES;
                    [self startAddMore];
                }
            }
        }
        else
        {
            if (mytable.contentSize.height-scrollView.contentOffset.y<=mytable.frame.size.height-ADDMORE_HEIGHT) {
                if (!isMore) {
                    isMore=YES;
                    [self startAddMore];
                }
            }
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (isLoading) return;
    isDragging = YES;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (isLoading) return;
    isDragging = NO;
    if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT)
    {
        [self startLoading];
    }
}

#pragma mark- 上拉加载更多

- (void)forbidAddMore
{
    isForbidMore = YES;
}

- (void)canAddMore
{
    isForbidMore = NO;
}

-(void)startAddMore
{
    footerView.hidden = NO;
    [addmoreLab setFrame:CGRectMake(155, 0, 100, footerView.frame.size.height)];
    [UIView animateWithDuration:0.3 animations:^{
        mytable.contentInset = UIEdgeInsetsMake(0, 0, footerView.frame.size.height, 0);
        footerView.frame=CGRectOffset(footerView.frame, 0, -footerView.frame.size.height);
        [addmoreSpinner startAnimating];
        [addmoreLab setTextAlignment:NSTextAlignmentLeft];
        addmoreLab.text = @"正在加载";
    }];
    [self addMore];
}

-(void)addMore
{
    //开始请求加载更多数据，子类重写
}


-(void)stopAddMore
{
        [UIView animateWithDuration:2.0 animations:^{
            footerView.frame=CGRectOffset(footerView.frame, 0, footerView.frame.size.height);
            mytable.contentInset=UIEdgeInsetsZero;
            isMore=NO;
        }];
    
    [UIView animateWithDuration:0.7 animations:^{
        footerView.frame=CGRectOffset(footerView.frame, 0, footerView.frame.size.height);
        mytable.contentInset=UIEdgeInsetsZero;
        isMore=NO;
    } completion:^(BOOL finished){
        footerView.hidden = YES;
    }];
}

#pragma mark- 刷新数据
//开始刷新数据
- (void)startLoading
{
    isLoading = YES;
    [UIView animateWithDuration:0.3 animations:^{
        mytable.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
        refreshLabel.text = self.textLoading;
        refreshArrow.hidden = YES;
        [refreshTime setText:@"正在刷新"];
        [refreshSpinner startAnimating];
    }];
    [self refresh];
}

//刷新数据
- (void)refresh {
    // This is just a demo. Override this method with your custom reload action.
    // Don't forget to call stopLoading at the end.
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:0];
}
//获取更新日期
-(void)getNewDate
{
    //NSDate *date=[NSDate date];
    NSDateFormatter *formattar=[[NSDateFormatter alloc]init];
    [formattar setDateFormat:@"MM-dd HH:mm:ss"];
    //refreshTime.text = [NSString stringWithFormat:@"上次更新:%@",[formattar stringFromDate:date]];
    refreshTime.textColor = [UIColor colorWithRed:122/255.0 green:135/255.0 blue:155/255.0 alpha:1.0f];
    [formattar release];
}
- (void)stopLoading
{
    [self getNewDate];
    isLoading = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        mytable.contentInset = UIEdgeInsetsZero;
        [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    }
                     completion:^(BOOL finished) {
                         [self performSelector:@selector(stopLoadingComplete)];
                     }];
}

- (void)stopLoadingComplete
{
    refreshLabel.text = self.textPull;
    refreshArrow.hidden = NO;
    [refreshTime setText:@"下拉刷新"];
    [refreshSpinner stopAnimating];
}

#pragma mark- 返回数据情况
-(void)getNoMoreData
{
    [addmoreSpinner stopAnimating];
    [addmoreLab setFrame:CGRectMake(0, 0, footerView.frame.size.width, footerView.frame.size.height)];
    [addmoreLab setTextAlignment:NSTextAlignmentCenter];
    addmoreLab.text = @"无更多数据";
}

//隐藏无数据view
-(void)hideNoDataView
{
    noDataView.hidden = YES;
}
//显示无数据view
-(void)showNoDataView:(NSString*)str
{
    noDataView.hidden = NO;
    noDataLab.text = str;
    UIFont *font = [UIFont systemFontOfSize:14];
    noDataLab.font = font;
    noDataLab.frame = CGRectMake(0, 200, WIDTH, 16);
    noDataLab.textAlignment = NSTextAlignmentCenter;
//    
////    if ([XtomFunction canConnectNet])
////    {
//        noDataLab.text = str;
//        [self showNoDataImg:@"暂无数据"];
//        [self.noImgView setFrame:CGRectMake((WIDTH-114)/2, 80, 114, 93)];
//    }else
//    {
//        noDataLab.text = @"网络不给力，请到有网的条件下浏览";
//        [self showNoDataImg:@"无网图标"];
//        [self.noImgView setFrame:CGRectMake(115, 71, 90, 65)];
//    }
}

-(void)showNoDataImg:(NSString*)str
{
    noDataView.hidden = NO;
    
//    if ([XtomFunction canConnectNet])
//    {
//        [noImgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",str]]];
//        [self.noImgView setFrame:CGRectMake((WIDTH-114)/2, 80, 114, 93)];
//    }else
//    {
//        [noImgView setImage:[UIImage imageNamed:@"无网图标"]];
//        [self.noImgView setFrame:CGRectMake(115, 71, 90, 65)];
//    }
}


@end
