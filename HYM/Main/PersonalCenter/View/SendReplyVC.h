//
//  SendReplyVC.h
//  DDwork
//
//  Created by 平川嘉恒 on 13-12-17.
//  Copyright (c) 2013年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllVC.h"
#import "BWTextView.h"

typedef enum
{
    ContentTypeReply = 0,
    ContentTypeReport,
    ContentTypeInfor,
    ContentTypeVIP,
}ContentType;

@protocol SendReplyDelegate;
@interface SendReplyVC : AllVC<UITextViewDelegate,UIAlertViewDelegate>
@property(nonatomic,assign)NSObject<SendReplyDelegate>* delegate;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)ContentType sendType;
@property(nonatomic,copy)NSString *blogid;
@property(nonatomic,copy)NSString *authorId;
@property(nonatomic,copy)NSString *cliendId;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *publishContent;
@property(nonatomic,copy)NSString *keytype;

@property(nonatomic,retain)BWTextView *mytextView;
@property(nonatomic,retain)UILabel *countLabel;
@end

@protocol SendReplyDelegate <NSObject>
@required

@optional

-(void)sendReplyOK:(ContentType)sendType content:(NSString*)content;
@end
