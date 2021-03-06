//
//  XTomRequest.m
//  MontherAndBabyApp2
//
//  Created by 李朋 on 13-4-21.
//
//

#define REQUEST_BOUNDARY @"AaB03x"
#define Xtom_HOST_NAME @"www.baidu.com"
#define Xtom_NET_FAIL @"网络不给力啊"
#define Xtom_NET_TIMEDURING 30 //网络请求允许的时间


#import "XTomRequest.h"
#import "Reachability.h"
#import "JSONKit.h"
#import "XtomConst.h"

@interface XTomRequest()
{
    BOOL isFile;
    NSURLConnection *connector;
    NSTimer *myTimer;
    BOOL isStringStyle;//返回结题是string类型的
    
    BOOL isGetToken;//是否已经获得新的token
}

@property(nonatomic,copy)NSURL *requestURL;
@property(nonatomic,retain)NSMutableDictionary *requestParameters;
@property(nonatomic,retain)NSMutableData *receiveData;//服务器返回的数据
@property(nonatomic,strong)id backTarget;//获取数据后的响应目标
@property(nonatomic,assign)SEL backSelector;//响应方法
@property(nonatomic,assign)int requestType;//0 是纯文本 1 image/JPEG 2text/plain
@property(nonatomic,assign)BOOL isStringStyle;
@end

@implementation XTomRequest
@synthesize requestURL = _requestURL;
@synthesize requestParameters = _requestParameters;
@synthesize receiveData = _receiveData;
@synthesize backTarget = _backTarget;
@synthesize backSelector = _backSelector;
@synthesize requestType = _requestType;
@synthesize isStringStyle;

- (void)dealloc
{
    //NSLog(@"连接销毁");
    [_requestURL release];_requestURL = nil;
    [_requestParameters release];_requestParameters = nil;
    [_receiveData release];_receiveData = nil;
    [_backTarget release];_backTarget = nil;
    _backSelector = nil;
    connector = nil;
    [super dealloc];
}
+ (XTomRequest*)requestWithURL:(NSString*)url target:(id)aTarget selector:(SEL)aSelector parameter:(NSMutableDictionary*)paramters
{
    XTomRequest *request = [[[XTomRequest alloc] init] autorelease];
    
    [self encodeStrWithURL:url dic:paramters];
    
//    for (NSString * key in paramters.allKeys)
//    {
//        if ([key isEqualToString:@"password"])
//        {
//            NSString * value = paramters[@"password"];
//            value = [XtomFunction encodePassword:value];
//            [paramters setObject:value forKey:key];
//            NSLog(@"value=%@", value);
//        }
//        if ([key isEqualToString:@"paypassword"])
//        {
//            NSString * value = paramters[@"paypassword"];
//            value = [XtomFunction encodePassword:value];
//            [paramters setObject:value forKey:key];
//        }
//    }
    
    [request requestWithURL:url target:aTarget selector:aSelector parameter:paramters];
    return request;
}

+ (NSMutableDictionary *)encodeStrWithURL:(NSString *)url dic:(NSMutableDictionary *)paramters
{
    /*
    增加参数名datetime、sign
    
    datetime为当前时间，每次重新生成如： 2016-03-07 13:23:15
    sign为 DATAKEY、datetime、接口名"|"拼接后的32位小写md5值
    DATAKEY为服务器分配的项目唯一字符串
    
    如：
    DATAKEY=bY3kj9DKBuKsiETx
    datetime=2016-03-07 13:23:15
    接口名=client_get
    sign=md5(bY3kj9DKBuKsiETx|2016-03-07 13:23:15|client_get)=c064ece028b1c33c127b43b1378c8c21
     */
    
    // datetime
    NSString * datetime = [XtomFunction getStringNow];
    [paramters setValue:datetime forKey:@"datetime"];
    
    // DATAKEY
    NSString * datakey = DATAKEY;
    
    // 接口名
    NSArray *myArr = [url componentsSeparatedByString:@"/"];
    [myArr lastObject];
    
    // datekey|datatime|接口名拼接
    NSString * md5Str = [NSString stringWithFormat:@"%@|%@|%@", datakey, datetime, [myArr lastObject]];
    
    // MD5加密
    NSString * sign = [XtomFunction md5:md5Str];
    [paramters setValue:sign forKey:@"sign"];
    
    return paramters;
}

+ (XTomRequest*)requestWithURL:(NSString*)url target:(id)aTarget selector:(SEL)aSelector parameter:(NSMutableDictionary*)paramters type:(BOOL)_stringStyle
{
    XTomRequest *request = [[[XTomRequest alloc] init] autorelease];
    request.isStringStyle = _stringStyle;
    [request requestWithURL:url target:aTarget selector:aSelector parameter:paramters];
    return request;
}

- (void)requestWithURL:(NSString*)url target:(id)aTarget selector:(SEL)aSelector parameter:(NSMutableDictionary*)paramters
{
    if(!self.requestURL)
        self.requestURL = [NSURL URLWithString:url];
    if(!self.backTarget)
        self.backTarget = aTarget;
    if(!self.backSelector)
        self.backSelector = aSelector;
    if(!self.requestParameters)
        self.requestParameters = paramters;
//    NSLog(@"link:%@ parameter:%@",self.requestURL,self.requestParameters);
    
    if([self canConnectNet])
    {
        self.requestType = [self getRequestType:_requestParameters];
        //self.requestType = 0;
        
        NSMutableURLRequest* theRequest = [[[NSMutableURLRequest alloc] initWithURL:_requestURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:Xtom_NET_TIMEDURING] autorelease];
        if(0 == _requestType)
        {
            [theRequest setHTTPMethod:@"POST"];
            NSData *postData = [self getPostData];
            [theRequest setHTTPBody:postData];
            [theRequest setValue:[NSString stringWithFormat:@"%d",(int)postData.length] forHTTPHeaderField:@"Content-Length"];
        }
        if(1 == _requestType)
        {
            [theRequest setHTTPMethod:@"POST"];
            [theRequest setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", REQUEST_BOUNDARY]forHTTPHeaderField:@"Content-Type"];
            [theRequest setHTTPBody:[self getPostData]];
        }
        [self openConnector:theRequest];
    }
    else
    {
        //断网状态
        NSDictionary *dic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"11",Xtom_NET_FAIL, nil] forKeys:[NSArray arrayWithObjects:@"error_code",@"success",@"msg", nil]];
        [_backTarget performSelector:_backSelector withObject:dic];
        
        NSDictionary *temDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"11", nil] forKeys:[NSArray arrayWithObjects:@"error_code",@"success", nil]];
        [_backTarget performSelector:_backSelector withObject:temDic];
        
        [[XtomFunction xfuncGetAppdelegate] postMessage:@"未找到可用网络"];
    }
    
}

// 音频
+ (XTomRequest*)requestWithAudioURL:(NSString*)url target:(id)aTarget selector:(SEL)aSelector parameter:(NSMutableDictionary*)paramters
{
    XTomRequest *request = [[[XTomRequest alloc] init] autorelease];
    
    [self encodeStrWithURL:url dic:paramters];
    
    [request requestWithAudioURL:url target:aTarget selector:aSelector parameter:paramters];
    return request;
}

+ (XTomRequest*)requestWithAudioURL:(NSString*)url target:(id)aTarget selector:(SEL)aSelector parameter:(NSMutableDictionary*)paramters type:(BOOL)_stringStyle
{
    XTomRequest *request = [[[XTomRequest alloc] init] autorelease];
    request.isStringStyle = _stringStyle;
    [request requestWithAudioURL:url target:aTarget selector:aSelector parameter:paramters];
    return request;
}
- (void)requestWithAudioURL:(NSString*)url target:(id)aTarget selector:(SEL)aSelector parameter:(NSMutableDictionary*)paramters
{
    
    if(!self.requestURL)
        self.requestURL = [NSURL URLWithString:url];
    if(!self.backTarget)
        self.backTarget = aTarget;
    if(!self.backSelector)
        self.backSelector = aSelector;
    if(!self.requestParameters)
        self.requestParameters = paramters;
    //NSLog(@"mylink:%@ parameter:%@",self.requestURL,self.requestParameters);
    
    if([self canConnectNet])
    {
        NSMutableURLRequest* theRequest = [[[NSMutableURLRequest alloc] initWithURL:_requestURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:Xtom_NET_TIMEDURING] autorelease];
        [theRequest setHTTPMethod:@"POST"];
        [theRequest setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", REQUEST_BOUNDARY]forHTTPHeaderField:@"Content-Type"];
        [theRequest setHTTPBody:[self getAudioPostData]];
        [self openConnector:theRequest];
    }
    else
    {
        //断网状态
        NSDictionary *dic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"11",Xtom_NET_FAIL, nil] forKeys:[NSArray arrayWithObjects:@"error_code",@"success",@"msg", nil]];
        [_backTarget performSelector:_backSelector withObject:dic];
    }
}

//视频
+ (XTomRequest*)requestWithVideoURL:(NSString*)url target:(id)aTarget selector:(SEL)aSelector parameter:(NSMutableDictionary*)paramters
{
    XTomRequest *request = [[[XTomRequest alloc] init] autorelease];
    
    [self encodeStrWithURL:url dic:paramters];
    
    [request requestWithVideoURL:url target:aTarget selector:aSelector parameter:paramters];
    return request;
}
+ (XTomRequest*)requestWithVideoURL:(NSString*)url target:(id)aTarget selector:(SEL)aSelector parameter:(NSMutableDictionary*)paramters type:(BOOL)_stringStyle
{
    XTomRequest *request = [[[XTomRequest alloc] init] autorelease];
    request.isStringStyle = _stringStyle;
    [request requestWithVideoURL:url target:aTarget selector:aSelector parameter:paramters];
    return request;
}
- (void)requestWithVideoURL:(NSString*)url target:(id)aTarget selector:(SEL)aSelector parameter:(NSMutableDictionary*)paramters
{
    
    if(!self.requestURL)
        self.requestURL = [NSURL URLWithString:url];
    if(!self.backTarget)
        self.backTarget = aTarget;
    if(!self.backSelector)
        self.backSelector = aSelector;
    if(!self.requestParameters)
        self.requestParameters = paramters;
    //NSLog(@"视频%@ parameter:%@",self.requestURL,self.requestParameters);
    
    if([self canConnectNet])
    {
        NSMutableURLRequest* theRequest = [[[NSMutableURLRequest alloc] initWithURL:_requestURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:Xtom_NET_TIMEDURING] autorelease];
        [theRequest setHTTPMethod:@"POST"];
        [theRequest setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", REQUEST_BOUNDARY]forHTTPHeaderField:@"Content-Type"];
        [theRequest setHTTPBody:[self getVideoPostData]];
        [self openConnector:theRequest];
    }
    else
    {
        //断网状态
        NSDictionary *dic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"11",Xtom_NET_FAIL, nil] forKeys:[NSArray arrayWithObjects:@"error_code",@"success",@"msg", nil]];
        [_backTarget performSelector:_backSelector withObject:dic];
    }
}

//手动关闭连接
- (void)closeConnect
{
    if(connector)
    {
        [connector cancel];connector = nil;
    }
    if(myTimer)
    {
        [myTimer invalidate];myTimer = nil;
    } 
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

//打开连接请求
- (void)openConnector:(NSMutableURLRequest*)request
{
    //"正在连接"状态打开
    connector = [NSURLConnection connectionWithRequest:request delegate:self];
    if (connector)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //_receiveData = [[NSMutableData alloc] init];
        self.receiveData = [[[NSMutableData alloc] init] autorelease];
        //myTimer = [NSTimer scheduledTimerWithTimeInterval:Xtom_NET_TIMEDURING target:self selector:@selector(checkData:) userInfo:nil repeats:NO];
    }
    else
    {
        NSDictionary *dic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"11",Xtom_NET_FAIL, nil] forKeys:[NSArray arrayWithObjects:@"error_code",@"success",@"msg", nil]];
        [_backTarget performSelector:_backSelector withObject:dic];
        [self closeConnect];
    }
}

//判断是否接收到了数据，如果没有，关闭连接
-(void)checkData:(id)sender
{
    if (0 == _receiveData.length)
    {
        if (connector)
        {
            [connector cancel];connector = nil;
        }
        
        //如果不是超时状态 弹出超时错误 打开超时状态
        
        NSDictionary *dic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"13", nil] forKeys:[NSArray arrayWithObjects:@"success", nil]];
        if([_backTarget respondsToSelector:_backSelector])
        {
            [_backTarget performSelector:_backSelector withObject:dic];
        }
    }
}

//检测网络状态
- (BOOL)canConnectNet
{
    Reachability *reache=[Reachability reachabilityWithHostName:Xtom_HOST_NAME];
    
    switch ([reache currentReachabilityStatus])
    {
        case NotReachable://无网络
            return NO;
        case ReachableViaWiFi://wifi网络
            return YES;
        case ReachableViaWWAN://wwlan网络
            return YES;
        default:
            break;
    }
    return NO;
}

//获取请求类型
- (int)getRequestType:(NSDictionary*)para
{
    for(NSObject *object in para.allValues)
    {
        if([object isKindOfClass:[NSData class]])//检索是不是含有文件
        {
            return 1;
        }
    }
    return 0;
}
//设置请求音频数据
- (NSData*)getAudioPostData
{
    NSData *returnData = nil;
    NSMutableData *temMutableData = [[[NSMutableData alloc] init] autorelease];
    NSString *boundary = REQUEST_BOUNDARY;
    for(NSString *key in _requestParameters.allKeys)
    {
        if([[_requestParameters objectForKey:key] isKindOfClass:[NSString class]])
        {
            NSString *temStr = [NSString stringWithFormat:@"--%@\r\nContent-Disposition:form-data;name=\"%@\"\r\n\r\n%@\r\n",boundary,key,[_requestParameters objectForKey:key]];
            [temMutableData appendData:[temStr dataUsingEncoding:NSUTF8StringEncoding]];
        }
        else
        {
            NSString *temStr = [NSString stringWithFormat:@"--%@\r\nContent-Disposition:form-data;name=\"%@\";filename=ab.mp3\r\n Content-Type:audio/mpeg\r\n\r\n",boundary,key];
            [temMutableData appendData:[temStr dataUsingEncoding:NSUTF8StringEncoding]];
            [temMutableData appendData:[_requestParameters objectForKey:key]];
            [temMutableData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    NSString *endStr = [NSString stringWithFormat:@"--%@--\r\n",boundary];
    [temMutableData appendData:[endStr dataUsingEncoding:NSUTF8StringEncoding]];
    returnData = temMutableData;
    return returnData;
}
//设置请求视频数据
- (NSData*)getVideoPostData
{
    NSData *returnData = nil;
    NSMutableData *temMutableData = [[[NSMutableData alloc] init] autorelease];
    NSString *boundary = REQUEST_BOUNDARY;
    for(NSString *key in _requestParameters.allKeys)
    {
        if([[_requestParameters objectForKey:key] isKindOfClass:[NSString class]])
        {
            NSString *temStr = [NSString stringWithFormat:@"--%@\r\nContent-Disposition:form-data;name=\"%@\"\r\n\r\n%@\r\n",boundary,key,[_requestParameters objectForKey:key]];
            [temMutableData appendData:[temStr dataUsingEncoding:NSUTF8StringEncoding]];
        }
        else
        {
            NSString *temStr = [NSString stringWithFormat:@"--%@\r\nContent-Disposition:form-data;name=\"%@\";filename=ab.mp4\r\n Content-Type:video/mp4\r\n\r\n",boundary,key];
            [temMutableData appendData:[temStr dataUsingEncoding:NSUTF8StringEncoding]];
            [temMutableData appendData:[_requestParameters objectForKey:key]];
            [temMutableData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    NSString *endStr = [NSString stringWithFormat:@"--%@--\r\n",boundary];
    [temMutableData appendData:[endStr dataUsingEncoding:NSUTF8StringEncoding]];
    returnData = temMutableData;
    return returnData;
}
//设置请求数据
- (NSData*)getPostData
{
    NSData *returnData = nil;
    if(0 == _requestType)
    {
        NSMutableString *temMutableString = [NSMutableString stringWithString:@""];
        for(NSString *key in _requestParameters.allKeys)
        {
            NSString *temStr = [NSString stringWithFormat:@"%@",[_requestParameters objectForKey:key]];
            
//            NSLog(@"qingqiu:%@",temStr);
            
            temStr = [temStr stringByReplacingOccurrencesOfString:@"&" withString:[NSString stringWithFormat:@"%@26",@"%"]];
            
            [temMutableString appendFormat:@"&%@=%@",key,temStr];
        }
        returnData = [temMutableString dataUsingEncoding:NSUTF8StringEncoding];
    }
    if(1 == _requestType)
    {
        NSMutableData *temMutableData = [[[NSMutableData alloc] init] autorelease];
        NSString *boundary = REQUEST_BOUNDARY;
        //rfc1867协议样式
        //        --AaB03x\r\n Content-Disposition:form-data;name="title"\r\n \r\n value\r\n
        //        --AaB03x\r\n Content-Disposition:form-data;name="imagetitle";filename="ab.jpg"\r\n Content-Type:image/JPEG\r\n \r\n datavalue\r\n
        //        --AaB03x--\r\n
        for(NSString *key in _requestParameters.allKeys)
        {
            if([[_requestParameters objectForKey:key] isKindOfClass:[NSString class]])
            {
                NSString *temStr = [NSString stringWithFormat:@"--%@\r\nContent-Disposition:form-data;name=\"%@\"\r\n\r\n%@\r\n",boundary,key,[_requestParameters objectForKey:key]];
                [temMutableData appendData:[temStr dataUsingEncoding:NSUTF8StringEncoding]];
            }
            else
            {
                NSString *temStr = [NSString stringWithFormat:@"--%@\r\nContent-Disposition:form-data;name=\"%@\";filename=ab.jpg\r\n Content-Type:image/JPEG\r\n\r\n",boundary,key];
                [temMutableData appendData:[temStr dataUsingEncoding:NSUTF8StringEncoding]];
                [temMutableData appendData:[_requestParameters objectForKey:key]];
                [temMutableData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
        }
        NSString *endStr = [NSString stringWithFormat:@"--%@--\r\n",boundary];
        [temMutableData appendData:[endStr dataUsingEncoding:NSUTF8StringEncoding]];
        returnData = temMutableData;
    }
    return returnData;
}
#pragma mark- NSUrlConnection Delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //可以获取数据的长度
    //NSLog(@"response:%@",response);
    //NSLog(@"length:%lld",response.expectedContentLength);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receiveData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if(isStringStyle)//如果返回是字符串形式
    {
        NSString *backStr = [[[NSString alloc] initWithData:_receiveData encoding:NSUTF8StringEncoding]autorelease];
        if(_backTarget && _backSelector)
        {
            if([_backTarget respondsToSelector:_backSelector])
            {
                [_backTarget performSelector:_backSelector withObject:backStr];
            }
        }
    }
    else 
    {
        //解析json数据
        NSDictionary *resultDictionary = [_receiveData objectFromJSONData];
//#warning //NSLog
        NSString *str=[[NSMutableString alloc] initWithData:_receiveData encoding:NSUTF8StringEncoding];
        str=[str stringByReplacingOccurrencesOfString:@"," withString:@",\n"];
        str=[str stringByReplacingOccurrencesOfString:@"{" withString:@"{\n"];
        str=[str stringByReplacingOccurrencesOfString:@"}" withString:@"\n}"];
        //NSLog(@"%@",str);
//        NSLog(@"response info:%@",resultDictionary);
//        NSLog(@"请求的数据原始版:%@",str);
        NSString *status = [resultDictionary objectForKey:@"success"];
        //如果token有误请重新连接 否则把数据发到请求方
        if(0 == [status intValue]&&200 ==[[resultDictionary objectForKey:@"error_code"] intValue])
        {
            //NSLog(@"error msg:%@",[resultDictionary objectForKey:@"msg"]);
            //[self requestWithURL:self.requestURL target:self.backTarget selector:self.backSelector parameter:self.requestParameters];
            
            if (![XtomFunction xfunc_check_strEmpty:[[NSUserDefaults standardUserDefaults] objectForKey:BB_XCONST_LOCAL_PLATTYPE]])
            {
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:BB_XCONST_LOCAL_PLATTYPE]integerValue] == 0)
                {
                    [self loginInBackground];
                }else
                {
                    //第三方登录
                    if ([[[NSUserDefaults standardUserDefaults] objectForKey:BB_XCONST_LOCAL_PLATTYPE]integerValue] == 1)
                    {
                        [self wechatLogin:nil];
                    }
                    if ([[[NSUserDefaults standardUserDefaults] objectForKey:BB_XCONST_LOCAL_PLATTYPE]integerValue] == 2)
                    {
                        [self qqLogin:nil];
                    }
                    if ([[[NSUserDefaults standardUserDefaults] objectForKey:BB_XCONST_LOCAL_PLATTYPE]integerValue] == 3)
                    {
                        [self sinaLogin:nil];
                    }
                }
            }else
            {
                if (isGetToken)
                {
                    return;
                }
                isGetToken = YES;
                [self loginInBackground];
            }
        }
        else
        {
            //返回数据
            if(_backTarget && _backSelector)
            {
                if([_backTarget respondsToSelector:_backSelector])
                {
                    [_backTarget performSelector:_backSelector withObject:resultDictionary];
                }
            }
        }
        
    }
    
    [self closeConnect];
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //    //关闭时钟
    //    if(myTimer)
    //    {
    //        [myTimer invalidate];
    //        myTimer = nil;
    //    }
    NSString *msg = [NSString stringWithFormat:@"%@",[error localizedDescription]];//NSLog(@"error msg:%@",msg);
    NSDictionary *dic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"12",msg, nil] forKeys:[NSArray arrayWithObjects:@"success",@"msg", nil]];
    if([_backTarget respondsToSelector:_backSelector])
    {
        [_backTarget performSelector:_backSelector withObject:dic];
    }
    [self closeConnect];
}

#pragma mark 登录
- (void)loginInBackground
{
    //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //NSString *deviceID = [userDefaults objectForKey:@"deviceid"];//设备硬件标识,用于推送
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDictionary objectForKey:@"CFBundleVersion"];//客户端软件当前版本
    NSString *temUsername = [[NSUserDefaults standardUserDefaults] objectForKey:BB_XCONST_LOCAL_LOGINNAME];
    NSString *temPawssword = [[NSUserDefaults standardUserDefaults] objectForKey:BB_XCONST_LOCAL_PASSWORD];
    
    if ([XtomFunction xfunc_check_strEmpty:temUsername])
    {
        return;
    }
    if ([XtomFunction xfunc_check_strEmpty:temPawssword])
    {
        return;
    }
    
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:temUsername forKey:@"username"];
    [dic setObject:temPawssword forKey:@"password"];
    [dic setObject:[XtomFunction xfuncGetAppdelegate].mydeviceid?[XtomFunction xfuncGetAppdelegate].mydeviceid:@"无" forKey:@"deviceid"];
    [dic setObject:@"1" forKey:@"devicetype"];
    [dic setObject:currentVersion forKey:@"lastloginversion"];
    
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_LOGIN_LINK] target:self selector:@selector(responseLogin:) parameter:dic];
}
- (void)responseLogin:(NSDictionary*)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        //保存信息
        NSArray *temArray = [info objectForKey:@"infor"];
        NSDictionary *dic = [temArray objectAtIndex:0];
        NSMutableDictionary *temDic = [[[NSMutableDictionary alloc] init] autorelease];
        for(NSString * key in dic.allKeys)
        {
            if(![XtomFunction xfunc_check_strEmpty:[dic objectForKey:key]])
            {
                NSString*value = [dic objectForKey:key];
                [temDic setValue:value forKey:key];
            }
        }
        XtomManager *myManager = [XtomManager sharedManager];
        myManager.motherInfor = temDic;
        myManager.userID = [dic objectForKey:@"id"];
        myManager.userToken = [dic objectForKey:@"token"];
        
        [XtomFunction xfuncGetAppdelegate].isLogin = YES;
        
        //重新连接服务器请求数据
        [self.requestParameters setObject:myManager.userToken forKey:@"token"];
        [self requestWithURL:nil target:nil selector:nil parameter:nil];
        
        //10分钟后处理token
        [self performSelector:@selector(changeGetToken) withObject:nil afterDelay:600];
    }else
    {
        
    }
}
#pragma mark - 第三方登录
//微信登录
-(void)wechatLogin:(id)sender
{
    [self requestPlatformLogin:nil plattype:@"1"];
}
//QQ登录
-(void)qqLogin:(id)sender
{
    [self requestPlatformLogin:nil plattype:@"2"];
}
//微博登录
-(void)sinaLogin:(id)sender
{
    [self requestPlatformLogin:nil plattype:@"3"];
}
#pragma mark 第三方登录
- (void)requestPlatformLogin:(NSMutableDictionary*)temDic plattype:(NSString*)plattype
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDictionary objectForKey:@"CFBundleVersion"];//客户端软件当前版本
    
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:plattype forKey:@"plattype"];
    
    [dic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:BB_XCONST_LOCAL_UID] forKey:@"uid"];
    [dic setObject:@"1" forKey:@"devicetype"];
    [dic setObject:currentVersion forKey:@"lastloginversion"];
    
    [dic setObject:@"无" forKey:@"avatar"];
    [dic setObject:@"无" forKey:@"nickname"];
    [dic setObject:@"无" forKey:@"sex"];
    [dic setObject:@"无" forKey:@"age"];
    
    [XTomRequest requestWithURL:[NSString stringWithFormat:@"%@%@",REQUEST_MAINLINK,REQUEST_PLATFORM_SAVE] target:self selector:@selector(responsePlatformLogin:) parameter:dic];
}
- (void)responsePlatformLogin:(NSDictionary*)info
{
    if(1 == [[info objectForKey:@"success"] intValue])
    {
        //保存信息
        NSArray *temArray = [info objectForKey:@"infor"];
        NSDictionary *dic = [temArray objectAtIndex:0];
        NSMutableDictionary *temDic = [[[NSMutableDictionary alloc] init] autorelease];
        for(NSString * key in dic.allKeys)
        {
            if(![XtomFunction xfunc_check_strEmpty:[dic objectForKey:key]])
            {
                NSString*value = [dic objectForKey:key];
                [temDic setValue:value forKey:key];
            }
        }
        XtomManager *myManager = [XtomManager sharedManager];
        myManager.motherInfor = temDic;
        myManager.userID = [dic objectForKey:@"id"];
        myManager.userToken = [dic objectForKey:@"token"];
        
        [XtomFunction xfuncGetAppdelegate].isLogin = YES;
        
        //重新连接服务器请求数据
        [self.requestParameters setObject:myManager.userToken forKey:@"token"];
        [self requestWithURL:nil target:nil selector:nil parameter:nil];
        
        //10分钟后处理token
        [self performSelector:@selector(changeGetToken) withObject:nil afterDelay:600];
    }else
    {
        
    }
}
-(void)changeGetToken
{
    isGetToken = NO;
}
@end
