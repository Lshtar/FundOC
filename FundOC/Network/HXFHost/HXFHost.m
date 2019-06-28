//
//  HXFHost.m
//  HXFund
//
//  Created by D on 2019/5/29.
//  Copyright © 2019 D. All rights reserved.
//

#import "HXFHost.h"

@implementation HXFHost

#pragma mark ------------------Switch------------------


#if HXF_Environment_Mode

#define HXFReleaseSwitch 1

#else

#define HXFReleaseSwitch 0

#endif

//正式环境1.测试0


#pragma mark ------------------Host------------------

#if HXFReleaseSwitch
// 正式
NSString * const  HXF_DOMAIN = @"https://api.hxlc.com/";
#else
//开发环境
//NSString * const HXF_DOMAIN = @"http://172.20.102.58:9001/";
//测试环境
NSString * const HXF_DOMAIN = @"https://api.test.hxlc.com/";
//程序员本地
//NSString * const HXF_DOMAIN = @"http://172.20.106.36:9001/";
//

#endif

#pragma mark ------------------Request------------------

//注册
NSString * const REQUEST_register = @"api/user/register";
//登录
NSString * const REQUEST_login = @"api/user/login";

@end
