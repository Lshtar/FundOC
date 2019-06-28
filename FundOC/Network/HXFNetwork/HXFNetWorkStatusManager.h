//
//  HXFNetWorkStatusManager.h
//  HXFund
//
//  Created by D on 2019/5/29.
//  Copyright © 2019 D. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HXFNetWorkStatusManager : NSObject
//获取当前网络类型
+ (NSString *)getNetworkType;
//获取当前网络类型
+ (NSString *)getNetworkTypeByReachability;
//获取Wifi信息
+ (id)fetchSSIDInfo;
//获取WIFI名字
+ (NSString *)getWifiSSID;
//获取WIFi的MAC地址
+ (NSString *)getWifiBSSID;
//获取Wifi信号强度
+ (int)getWifiSignalStrength;
//获取设备IP地址
+ (NSString *)getIPAddress;

@end

NS_ASSUME_NONNULL_END
