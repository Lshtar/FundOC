//
//  HXFRoutineMacros.h
//  HXFund
//
//  Created by D on 2019/5/28.
//  Copyright © 2019 D. All rights reserved.
//

#ifndef HXFRoutineMacros_h
#define HXFRoutineMacros_h

///------ 尺寸 ------
#define hxf_ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define hxf_ScreenHeight    [UIScreen mainScreen].bounds.size.height
#define hxf_ScreenSize      [UIScreen mainScreen].bounds.size

//iPhoneX / iPhoneXS
#define  isIphoneX_XS     (hxf_ScreenWidth == 375.f && hxf_ScreenHeight == 812.f ? YES : NO)
//iPhoneXR / iPhoneXSMax
#define  isIphoneXR_XSMax    (hxf_ScreenWidth == 414.f && hxf_ScreenHeight == 896.f ? YES : NO)
//异型全面屏
#define   isFullScreen    (isIphoneX_XS || isIphoneXR_XSMax)
// Status bar height.
#define  Height_StatusBar     (isFullScreen ? 44.f : 20.f)
#define  Height_NavBar        (isFullScreen ? 88.f : 64.f)
#define  Height_TabBar        (isFullScreen ? (49.f+34.f) : 49.f)

/************ 适配大小 *****************/
#define MULTI    1.15   //修改放大系数(针对于plus), 6自动适应大小
#define MULTID   1.08   //修改放大系数(针对于plus), 6自动适应大小

#define UIPX    hxf_ScreenWidth/750.0f;

#define SP6(value)   ((hxf_ScreenWidth / 375.0) * (value*1.0))

#define SP(value)    ((hxf_ScreenWidth / 320.0) * (value))
#define SPH(value)   ((((hxf_ScreenWidth - 320) / 320.0) * ((MULTI - 1) / 0.29) + 1) * (value))
#define SPHP(value)  ((((hxf_ScreenWidth - 320) / 320.0) * ((MULTID - 1) / 0.29) + 1) * (value))

///------ Ratio(Point)基于iPhone6 ------
#define kRatioX6 ([UIScreen mainScreen].bounds.size.width / 375.)
#define kRatioY6 ([UIScreen mainScreen].bounds.size.height / 667.)

///------ Ratio(Point)基于iPhone5s ------
#define kRatioX5 ([UIScreen mainScreen].bounds.size.width / 320)
#define kRatioY5 ([UIScreen mainScreen].bounds.size.height / 568)

///------ Ratio(Point)基于iPhone6P ------
#define kRatioX6P ([UIScreen mainScreen].bounds.size.width / 621.)
#define kRatioY6P ([UIScreen mainScreen].bounds.size.height / 1104.)

///------ Ratio(Point)基于iPhonex ------
#define kRatioXx ([UIScreen mainScreen].bounds.size.width / 562.5.)
#define kRatioYx ([UIScreen mainScreen].bounds.size.height / 1218.)

/************ iPhone Type *****************/
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


#if DEBUG
#define INK(code, obj) NSLog(@"%ld  -----  %@", (long)code, obj);
#define INKFUNC NSLog(@"%s", __func__);
#else
#define INK(code, obj) {}
#define INKFUNC {}
#endif

#if DEBUG
#define NSLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define NSLog(format, ...)
#endif

///------ 区分设备和模拟器 ------
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

///------ <强烈推荐❤️>替换NSLog使用，debug模式下可以打印很多方法名、行信息(方便查找)，release下不会打印 ------
#ifdef DEBUG
//-- 区分设备和模拟器,
//解决Product -> Scheme -> Run -> Arguments -> OS_ACTIVITY_MODE为disable时，真机下 Xcode Debugger 不打印的bug ---
#if TARGET_OS_IPHONE
/*iPhone Device*/
#define DLog(format, ...) printf("%s:Dev: %s [Line %d]\n%s\n\n", [DATE_STRING UTF8String], __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String])
#else
/*iPhone Simulator*/
#define DLog(format, ...) NSLog((@":Sim: %s [Line %d]\n%@\n\n"), __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:format, ##__VA_ARGS__])
#endif
#else
#define DLog(...)
#endif


#endif /* HXFRoutineMacros_h */
