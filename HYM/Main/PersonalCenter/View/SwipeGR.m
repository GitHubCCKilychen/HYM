//
//  SwipeGR.m
//  DDwork
//
//  Created by 平川嘉恒 on 13-11-8.
//  Copyright (c) 2013年 Admin. All rights reserved.
//

#import "SwipeGR.h"

@implementation SwipeGR
@synthesize touchRow;
@synthesize touchRowNum;
@synthesize myRow;
@synthesize mySection;
@synthesize myNumber;

-(void)dealloc
{
    [touchRow release];touchRow = nil;
    [touchRowNum release];touchRowNum = nil;
    [super dealloc];
}
@end
