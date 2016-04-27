
#import "XtomFunction.h"
#import "XTomRequest.h"
#import "XtomRequestSingle.h"
#import "XtomManager.h"
#import "XtomCashManager.h"
//#import "Navbar.h"
//#import "MLNavigationController.h"
//#import "UINavViewController.h"
#define HM_ISIPHONE6PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define HM_ISIPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define HM_ISIPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define HM_ISIOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
#define HM_ISIOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
#define HM_UI_ViewHeight (HM_ISIPHONE6PLUS?736.0f:(HM_ISIPHONE6?603.0f:(HM_ISIPHONE5?504.0f:416.0f)))
#define HM_UI_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define TitleFont 20
#define NavigationColor BB_White_Color
#define TitleColor [UIColor colorWithRed:134/255.0 green:141/255.0 blue:145/255.0 alpha:1]
#define BackItemOffset UIEdgeInsetsMake(0, 5, 0, 0)
#define ItemLeftMargin 0
#define ItemWidth 48
#define ItemHeight 30
#define ItemTextFont 16
#define ItemTextNormalColot [UIColor colorWithRed:255/255.0 green:24/255.0 blue:0/255.0 alpha:1]
#define ItemTextSelectedColot [UIColor lightGrayColor]
#define ItemTextSelectedColotDisabled [UIColor lightGrayColor]
#define UINavigationBarButton_Color_Red 239/255.0
#define UINavigationBarButton_Color_Green 239/255.0
#define UINavigationBarButton_Color_Blue 239/255.0
#define UINavigationBarButton_Color_ALPHA 1
#define BB_Color_NavigationBar [UIColor colorWithRed:UINavigationBarButton_Color_Red green:UINavigationBarButton_Color_Green blue:UINavigationBarButton_Color_Blue alpha:UINavigationBarButton_Color_ALPHA]
#define UIViewBack_Color_Red 230/255.0
#define UIViewBack_Color_Green 230/255.0
#define UIViewBack_Color_Blue 230/255.0
#define UIViewBack_Color_Alpha 1.0
#define BB_Color_BackGround ([UIColor colorWithRed:UIViewBack_Color_Red green:UIViewBack_Color_Green blue:UIViewBack_Color_Blue alpha:UIViewBack_Color_Alpha])
#define BB_Back_Color_Here_Bar [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0f]
#define UIBorder_Color_Red 199/255.0
#define UIBorder_Color_Green 199/255.0
#define UIBorder_Color_Blue 199/255.0
#define UIBorder_Color_Alpha 1.0
#define RGB_UI_COLOR(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define BB_Blake [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1]
#define BB_BorderOne_Color [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1]
#define BB_TitleColor [UIColor colorWithRed:240/255.0 green:122/255.0 blue:22/255.0 alpha:1]
#define BB_RED_HERE [UIColor colorWithRed:238/255.0f green:86/255.0f blue:92/255.0f alpha:1.0f]
#define BB_shadow_color [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0f]
#define BB_Green_Color [UIColor colorWithRed:59/255.0 green:121/255.0 blue:178/255.0 alpha:1]
#define BB_Green11_Color [UIColor colorWithRed:0/255.0 green:210/255.0 blue:77/255.0 alpha:1]
#define BB_NewGreenlight_Color [UIColor colorWithRed:94/255.0 green:117/255.0 blue:143/255.0 alpha:1]
#define BB_NewGreen_Color [UIColor colorWithRed:52/255.0 green:77/255.0 blue:105/255.0 alpha:1]
#define BB_New_StyleColor [UIColor colorWithRed:58/255.0 green:198/255.0 blue:227/255.0 alpha:1]
#define BB_Back_Color_Here [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0f]
#define BB_Red_Color [UIColor colorWithRed:236/255.0 green:17/255.0 blue:26/255.0 alpha:1]
#define BB_White_Color [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]
#define BB_Border_Color [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1]
#define BB_lineColor [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1]
#define BB_Orange_Color [UIColor colorWithRed:251/255.0 green:84/255.0 blue:54/255.0 alpha:1]
#define BB_Blue_Color [UIColor colorWithRed:48/255.0 green:164/255.0 blue:160/255.0 alpha:1]
#define BB_Gray [UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0f]
#define BB_Graylight [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1.0f]
#define BB_Graydark [UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:1.0f]
#define BB_Gray_Color [UIColor colorWithRed:168/255.0 green:168/255.0 blue:168/255.0 alpha:1]
#define BB_BlueOne_Color [UIColor colorWithRed:175/255.0 green:239/255.0 blue:236/255.0 alpha:1]
#define BB_NBlack_Color [UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1]
#define BB_NGray_Color [UIColor colorWithRed:182/255.0 green:182/255.0 blue:182/255.0 alpha:1]
#define BB_NPurple_Color BB_Red_Color
#define BB_NPink_Color [UIColor colorWithRed:217/255.0 green:154/255.0 blue:224/255.0 alpha:1]
#define BB_NPinkDark_Color [UIColor colorWithRed:222/255.0 green:123/255.0 blue:235/255.0 alpha:1]
#define BB_NBlue_Color [UIColor colorWithRed:131/255.0 green:131/255.0 blue:242/255.0 alpha:1]
#define BB_NGrayLight_Color [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1]
#define BB_NGreen_Color [UIColor colorWithRed:142/255.0 green:176/255.0 blue:156/255.0 alpha:1]
#define BB_NYellowLight_Color [UIColor colorWithRed:244/255.0 green:252/255.0 blue:233/255.0 alpha:1]
#define BB_NYellow_Color [UIColor colorWithRed:234/255.0 green:185/255.0 blue:50/255.0 alpha:1]
#define BB_NRedLight_Color [UIColor colorWithRed:253/255.0 green:117/255.0 blue:155/255.0 alpha:1]
#define BB_NBlackLight_Color [UIColor colorWithRed:217/255.0 green:216/255.0 blue:225/255.0 alpha:1]
#define BB_BordLine_Color [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1]
#define BB_Button_Color [UIColor colorWithRed:255/255.0 green:66/255.0 blue:0/255.0 alpha:1]
#define CoLocation CLLocationCoordinate2DMake(36.678573, 117.121612)
#define UI_View_Hieght (IS_IPHONE5?504.0f:416.0f)
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define HM_ISIPHONE6PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define HM_ISIPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define HM_ISIPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define HM_ISIPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define HM_ISIOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
#define HM_ISIOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
#define HM_ISIOS9 [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0
#define UI_View_Height ([UIScreen mainScreen].bounds.size.height-44-[UIApplication sharedApplication].statusBarFrame.size.height)
#define UI_View_Width [UIScreen mainScreen].bounds.size.width
#define UI_Width_Scale ((HM_ISIPHONE6)?(375.0f/320.0f):((HM_ISIPHONE6PLUS)?(414.0f/320.0f):1.0f))
#define UI_Height_Scale ((HM_ISIPHONE6)?(1334.0f/1136.0f):((HM_ISIPHONE6PLUS)?(736.0f/568.0f):1.0f))
#define NOTIFICATION_OUT_NOTE @"outNote"
#define BB_XCONST_PAGE_SIZE  10
#define BB_TIME_CODE @"60"
#define BB_TIME_RECORD 90
#define BB_Time_ACTIVE 0.5f
#define BB_TabBar_Height 44
#define BB_XCONST_IS_DRAGING @"isDrag"
#define BB_XCONST_IS_PAY @"isPay"
#define BB_XCONST_IS_YLCeshi @"00"
#define BB_XCONST_FONT_MAIN_SIZE 14.0f
#define BB_XCONST_FONT_CONTENT 16.0f
#define ConFont 20
#define BB_XCONST_TIME_FAMAT @"yy-MM-dd HH:mm +0800"
#define BB_XCONST_INTERVAL 0.8f
#define BB_XCONST_KEFUTEL @"400-880-1234"
#define BB_UMENG_APPKEY @"552f8068fd98c59352001e6f"
#define BB_CASH_DOCUMENT @"baowencash"
#define BB_CASH_AVATAR @"avatar"
#define BB_CASH_BLOG @"blog"
#define BB_CASH_AUDIO @"audio"
#define BB_CASH_VIDEO @"video"
#define BB_CASH_TALK @"talk"
#define BB_CASH_DATABASE @"chatDatabase.db"
#define BB_DB_DISTRICT @"sys_cascade_district"
#define BB_NOTIFICATION_GET_MESSAGE @"getMessage"
#define BB_NOTIFICATION_SEND_MESSAGE @"sendMessage"
#define BB_NOTIFICATION_START_LOCATION @"startLocation"
#define BB_XCONST_LOCAL_MESSAGE @"localMessage"
#define BB_NOTIFICATION_MeSSAGE @"messageNotice"
#define BB_BOTIFICATION_PAY @"paymoney"
#define BB_NOTIFICATION_SELECT @"selectbar"
#define BB_NOTIFICATION_Progress @"myProgress"
#define BB_NOTIFICATION_CheRefresh @"cherefresh"
#define BB_NOTIFICATION_CheRefreshShu @"cherefreshshu"
#define BB_NOTIFICATION_OrderRefresh @"orderfreshshu"
#define BB_NOTIFICATION_OrderOK @"orderOK"
#define BB_NOTIFICATION_OrderFail @"orderFail"
#define BB_XCONST_LOCAL_PLATTYPE @"plattype"
#define BB_XCONST_LOCAL_UID @"plattypeuid"
#define BB_XCONST_ISAUTO_LOGIN @"isAutoLogin"
#define BB_XCONST_LOGIN_INFOR @"login_infor"
#define BB_XCONST_LOGIN_System @"login_System"
#define BB_XCONST_LOGIN_TOKEN @"login_token"
#define BB_XCONST_LOCAL_PASSWORD @"localPWD"
#define BB_XCONST_LOCAL_LOGINNAME @"loginname"
#define BB_XCONST_LOCAL_ID @"localID"
#define BB_XCONST_LOCAL_TELNUMBER @"localTelNumber"
#define BB_XCONST_LAST_VERSION @"lastversion"
#define BB_XCONST_NO_UPDATE @"versionupdate"
#define GDownLoad @"gdownload"
#define HouDownLoad @"houdownload"
#define MyClock @"myclock"
#define SaveSearchWord @"SaveSearchWord"
#define SaveLastCityArr @"SaveLastCityArr"
#define CityName @"CityName"
#define CityId @"CityId"
#define DownName @"DownName"
#define DownId @"DownId"
#define LocalCityName @"LocalCityName"
#define LocalCityId @"LocalCityId"
#define SendAddress @"SendAddress"
#define REQUEST_MAINLINK_INIT @"http://101.200.84.33/"
#define REQUEST_MAINLINK_ROOT @"http://115.28.235.141/"
#define REQUEST_CHAT_INIT @"192.168.2.146"
#define REQUEST_CHAT_PORT @"5222"
#define REQUEST_MAINLINK [XtomFunction getRootPath]
#define REQUEST_HOST [XtomFunction getChatPath]
#define REQUEST_CHATPUSH_ADD @"chatpush_add"
#define BB_NOTIFICATION_NOSEND_MESSAGE @"nosendMessage"
#define DATAKEY @"TCDjndrLdUwMXGO"
#define REQUEST_CODE_GET @"code_get"
#define REQUEST_CODE_VERIFY @"code_verify"
#define REQUEST_LOGIN_LINK @"client_login"
#define REQUEST_ACCESS_HISTORY_CLEAR @"access_history_clear"
#define REQUEST_ACCESS_HISTORY_LIST @"access_history_list"
#define REQUEST_TRADE_HISTORY_LIST @"trade_history_list"
#define REQUEST_AUTH_SAVE @"auth_save"
#define REQUEST_AUTH_PROGESS_LIST @"auth_progress_list"
#define REQUEST_SHOP_GET @"shop_get"
#define REQUEST_SHOP_SAVE @"shop_save"
#define REQUEST_CONTACT_LIST @"contact_list"
#define REQUEST_INVITE_ADD @"invite_add"
#define REQUEST_CLEAR_BADGE @"clear_badge"
#define REQUEST_FILE_UPLOAD @"file_upload"
#define REQUEST_UPLOAD_MATERIAL @"upload_material"
#define REQUEST_UPLOAD_COPYIMAGE @"upload_copyimage"
#define REQUEST_NOTICE_LIST @"notice_list"
#define REQUEST_NOTICE_SAVEOPERATE @"notice_saveoperate"
#define REQUEST_NEW_NOTICE_COUNT @"new_notice_count"
#define REQUEST_INDEXAD_LIST @"indexad_list"
#define REQUEST_SHOWCASEAD_LIST @"showcasead_list"
#define REQUEST_TYPE_LIST @"type_list"
#define REQUEST_TYPE_PARAM_LIST @"type_param_list"
#define REQUEST_HOT_LIST @"hot_list"
#define REQUEST_HOT_CITY_LIST @"hot_city_list"
#define REQUEST_OFFICIAL_TYPE_LIST @"official_type_list"
#define REQUEST_PUBLIC_TYPE_LIST @"public_type_list"
#define REQUEST_FROM_BANK_LIST @"from_bank_list"
#define REQUEST_MATERIAL_LIST @"material_list"
#define REQUEST_REPLY_ADD @"reply_add"
#define REQUEST_REPLY_LIST @"reply_list"
#define REQUEST_REPLY_REMOVE @"reply_remove"
#define REQUEST_GOODS_REPLY_ADD @"goods_reply_add"
#define REQUEST_BLOG_ADD @"blog_add"
#define REQUEST_BLOG_CONTENT_ADD @"blog_content_add"
#define REQUEST_BLOG_CONTENT_SAVE @"blog_content_save"
#define REQUEST_BLOG_CONTENT_REMOVE @"blog_content_remove"
#define REQUEST_BLOG_LIST @"blog_list"
#define REQUEST_INDEX_BLOG_LIST @"index_blog_list"
#define REQUEST_BLOG_GET @"blog_get"
#define REQUEST_BLOG_SAVEOPERATE @"blog_saveoperate"
#define REQUEST_FOLLOW_COLLECT_LIST @"follow_collect_list"
#define REQUEST_FOLLOW_COLLECT_OPERATOR @"follow_collect_operator"
#define REQUEST_BLOG_PARAM_SAVE @"blog_param_save"
#define REQUEST_CART_ADD @"cart_add"
#define REQUEST_CART_SAVEOPERATE @"cart_saveoperate"
#define SHiWuInfo @"shiWuInfo"
#define REQUEST_FEEACCOUNT_REMOVE @"feeaccount_remove"
#define REQUEST_SCORE_REMOVE @"score_remove"
#define REQUEST_BILL_LIST @"bill_list"
#define REQUEST_SHOP_BILL_LIST @"shop_bill_list"
#define REQUEST_BILL_GOODS_LIST @"bill_goods_list"
#define REQUEST_BILL_GET @"bill_get"
#define REQUEST_BILL_SAVEOPERATE @"bill_saveoperate"
#define REQUEST_TRADETYPE_COUNT_GET @"tradetype_count_get"
#define REQUEST_SCORE_LIST @"score_list"
#define REQUEST_SCORE_OPERATOR @"score_operator"
#define REQUEST_SCORE_TOP_LIST @"score_top_list"
#define REQUEST_GAME_COUNT @"game_count"
#define REQUEST_BANK_SAVE @"bank_save"
#define REQUEST_ALIPAY_SAVE @"alipay_save"
#define REQUEST_WEIXIN_SAVE @"weixin_save"
#define REQUEST_CASH_ADD @"cash_add"
#define REQUEST_ADDRESS_LIST @"address_list"
#define REQUEST_ADDRESS_SAVE @"address_save"
#define REQUEST_ADDRESS_REMOVE @"address_remove"
#define NO_READ_INFO @"no_read_info"
#define ALL_READ_INFO @"all_read_info"
#define PUBLISH_BLOG_SUCCEED @"publish_blog_succeed"
#define DELETE_BLOG_SUCCEED @"delete_blog_succeed"
#define MY_XN_STORE_ORDER_CHANGE @"my_xn_store_order_change"
#define CHANGE_GOODS_SUCCESS @"change_goods_success"
#define CHANGE_SWGOODS_SUCCESS @"change_swgoods_success"
#define TOP_TO_GAME @"top_to_game"
#define BUY_SUCCESS_XUNI @"buy_success_xuni"
#define BUY_SUCCESS_SHIQU @"buy_success_shiwu"
#define ADD_FRIEND_SUCCESS @"add_friend_success"
#define BB_NOTIFICATION_OFFICAL @"office_notification"
#define BB_NOTIFICATION_SYSTEM @"system_notification"
#define BB_NOTIFICATION_TOPIC @"topic_notification"
#define BB_NOTIFICATION_CHAT @"chat_notification"
#define BB_NOTIFICATION_BEFORE_NOTI @"before_noti_notification"
#define BB_GEO_APIKEY  @"0d9f9f1db6b2bc20bce7070618cf589b"
#define REQUEST_ANNOUNCE_LIST  @"announce_list"
#define SHIWU_INFO @"shiwu_info"
#define SHIWU_ISPUBLISH @"shiwu_ispublish"
#define XUNI_INFO @"xuni_info"
#define XUNI_ISPUBLISH @"xuni_ispublish"
#define REQUEST_AD_LIST @"indexad_list"
#define REQUEST_REMOVE @"remove"
#define REQUEST_DISTRICT_LIST @"district_list"
#define REQUEST_EXCHANGE_ADD @"exchange_add"
#define REQUEST_EXCHANGE_LIST @"exchange_list"
#define REQUEST_SIGNIN @"signin"
#define REQUEST_TYPE_LIST @"type_list"
#define REQUEST_SHOP_LIST @"shop_list"
#define REQUEST_SHOP_CALLED_ADD @"shop_called_add"
#define REQUEST_SHOP_CALLED_LIST @"shop_called_list"
#define REQUEST_SHOP_ADD @"shop_add"
#define REQUEST_SHOP_VIP_ADD @"shop_vip_add"
#define REQUEST_GOODS_ADD @"goods_add"
#define REQUEST_GOODS_SAVE @"goods_save"
#define REQUEST_GOODS_LIST @"goods_list"
#define REQUEST_GOODS_GET @"goods_get"
#define REQUEST_SAVE_BLOG @"blog_add"
#define REQUEST_GET_BLOG_LIST @"blog_list"
#define REQUEST_GET_BLOG_DATAIL @"blog_get"
#define REQUEST_SYSTEM_INIT @"index.php/webservice/index/init"
#define REQUEST_REGISTER_GET_CODE @"code_get"
#define REQUEST_REGISTER_VERIFY_CODE @"code_verify"
#define REQUEST_REGISTER_LINK @"client_add"
#define REQUEST_FINDPWD_VERIFY_USER @"client_verify"
#define REQUEST_FINDPWD_RESETPWD @"password_reset"
#define REQUEST_SAVE_POSITION @"position_save"
#define REQUEST_UPLOAD_FILE @"file_upload"
#define REQUEST_SAVE_DEVICE @"device_save"
#define REQUEST_LOGIN_OUT @"client_loginout"
#define REQUEST_SAVE_PASSWORD @"password_save"
#define REQUEST_SAVE_CLIENT @"client_save"
#define REQUEST_GET_CLIENT @"client_get"
#define REQUEST_SAVE_ADVICE @"advice_add"
#define REQUEST_GET_IMG_LIST @"img_list"
#define REQUEST_MERCHANT_GET @"merchant_get"
#define REQUEST_GET_MERCHANT_LIST @"merchant_list"
#define REQUEST_OPERATE_BROADCAST @"broadcast_saveoperate"
#define REQUEST_BROADCAST_LIST @"broadcast_list"
#define REQUEST_GET_NOTICE_LIST @"notice_list"
#define REQUEST_OPERATE_NOTiCE @"notice_saveoperate"
#define REQUEST_GET_APPS_LIST @"apps_list"
#define REQUEST_SERVICE_GET @"service_get"
#define REQUEST_SAVE_FRIEND @"friend_add"
#define REQUEST_REMOVE_FRIEND @"friend_remove"
#define REQUEST_SAVE_MSG @"msg_add"
#define REQUEST_GET_MSG_LIST @"msg_list"
#define REQUEST_ASK_ADD @"ask_add"
#define REQUEST_ASK_LIST @"ask_list"
#define REQUEST_ASK_GET @"ask_get"
#define REQUEST_REPLY_REMOVE @"reply_remove"
#define REQUEST_CART_BUY @"cart_add"
#define REQUEST_CART_OPERATE @"cart_saveoperate"
#define REQUEST_CART_LIST @"cart_list"
#define REQUEST_CLIENT_ACCOUNTPAY @"feeaccount_remove"
#define REQUEST_BUY_LIST @"buy_list"
#define REQUEST_BUYNOW_GET @"buynow_get"
#define REQUEST_BILL_SAVE @"bill_save"
#define REQUEST_CART_GET @"cart_get"
#define REQUEST_LOVE_ADD @"love_add"
#define REQUEST_LOVE_REMOVE @"love_remove"
#define REQUEST_BANK_LIST @"bank_list"
#define REQUEST_CASH_LIST @"cash_list"
#define REQUEST_PAY_LIST @"pay_list"
#define REQUEST_AUTH_SAVE @"auth_save"
#define REQUEST_AUTH_LIST @"auth_list"
#define REQUEST_MOBILE_SAVE @"username_save"
#define REQUEST_BRAND_LIST @"brand_list"
#define REQUEST_QUALITY_LIST @"quality_list"
#define REQUEST_QUALITY_ITEM_LIST @"quality_item_list"
#define REQUEST_DATA_REMOVE @"data_remove"
#define REQUEST_SAVE_OPERATE @"data_saveoperate"
#define REQUEST_SHARE_ADD @"share_add"
#define REQUEST_COUPON_LIST @"coupon_list"
#define REQUEST_BRAND_GET @"brand_get"
#define REQUEST_QUESTION_LIST @"question_list"
#define REQUEST_PLATFORM_SAVE @"platform_save"
#define REQUEST_RECOMMENT_GET @"recomment_get"
#define REQUEST_ATTRIBUTE_LIST @"attribute_list"
#define REQUEST_BLOGSIZE_LIST @"blog_size_list"
#define REQUEST_BRANDRELATED_LIST @"brand_related_list"
#define REQUEST_CARTOUT_LIST @"cart_out_list"
#define REQUEST_KIND_LIST @"kind_list"
#define REQUEST_LIMIT_VERIFY @"limit_verify"
#define REQUEST_ASKTYPE_LIST @"asktype_list"
#define REQUEST_OTHERTYPE_LIST @"othertype_list"
#define REQUEST_EXAM_INIT @"exam_init"
#define REQUEST_EXAM_GET @"exam_get"
#define REQUEST_EXAM_SAVE @"exam_save"
#define REQUEST_TEST_LIST @"test_list"
#define REQUEST_CHAPTER_LIST @"chapter_list"
#define REQUEST_CHAPTER_GET @"chapter_get"
#define REQUEST_FAVORITE_LIST @"favorite_list"
#define REQUEST_VIDEO_LIST @"video_list"
#define REQUEST_VIDEO_BUY @"video_buy"
#define REQUEST_CHAPTER_SAVE @"chapter_saveoperate"
#define REQUEST_VIDEO_SAVE @"video_saveoperate"
#define REQUEST_STUDY_LIST @"study_list"
#define REQUEST_PERCENT_GET @"percent_get"
#define REQUEST_COMPANY_GET @"company_get"
#define REQUEST_DEPT_LIST @"dept_list"
#define REQUEST_CLIENT_REMOVE @"client_remove"
#define REQUEST_CLIENT_LIST @"client_list"
#define REQUEST_SERVICE_GET @"service_get"
#define REQUEST_GROUPCHAT_ADD @"groupchat_add"
#define REQUEST_COMPANYCHAT_ADD @"companychat_add"
#define REQUEST_GROUP_ADD @"group_add"
#define REQUEST_GROUP_LIST @"group_list"
#define REQUEST_GROUP_GET @"group_get"
#define REQUEST_GROUP_REMOVE @"group_remove"