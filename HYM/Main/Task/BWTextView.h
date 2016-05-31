//
//  YYTextView.h
//  YYZZB
//
//  Created by 李朋 on 13-4-29.
//  Copyright (c) 2013年 北京平川嘉恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BWTextView : UITextView

@property(nonatomic,retain)UILabel *placeHolderLabel;
@property(nonatomic,copy)NSString *placeholder;
@property(nonatomic,retain)UIColor *placeholderColor;
@property(nonatomic,assign)NSInteger viewRow;
@end
