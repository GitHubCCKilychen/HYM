//
//  WebVC.h
//  DDwork
//
//  Created by 平川嘉恒 on 13-12-19.
//  Copyright (c) 2013年 Admin. All rights reserved.
//
//打开网页链接

#import <UIKit/UIKit.h>
#import "Navbar.h"
#import "XtomConst.h"
#import "AllVC.h"

@interface WebVC : AllVC
@property(nonatomic,copy)NSString *urlPath;
@property(nonatomic,copy)NSString *objectTitle;
@property(nonatomic,assign)BOOL isAdgust;
@property(nonatomic,retain)UIWebView *myWebView;
@property(nonatomic,assign)BOOL isPresent;
@end