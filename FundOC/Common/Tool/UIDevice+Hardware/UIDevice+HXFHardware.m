//
//  UIDevice+HXFHardware.m
//  HeXinFund
//
//  Created by D on 2018/5/4.
//  Copyright © 2018年 D. All rights reserved.
//

#import "UIDevice+HXFHardware.h"
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "sys/utsname.h"

@implementation UIDevice (HXFHardware)

/*
 Platforms
 
 iFPGA ->        ??
 
 iPhone1,1 ->    iPhone 1G, M68
 iPhone1,2 ->    iPhone 3G, N82
 iPhone2,1 ->    iPhone 3GS, N88
 iPhone3,1 ->    iPhone 4/AT&T, N89
 iPhone3,2 ->    iPhone 4/Other Carrier?, ??
 iPhone3,3 ->    iPhone 4/Verizon, TBD
 iPhone4,1 ->    (iPhone 4S/GSM), TBD
 iPhone4,2 ->    (iPhone 4S/CDMA), TBD
 iPhone4,3 ->    (iPhone 4S/???)
 iPhone5,1 ->    iPhone Next Gen, TBD
 iPhone5,1 ->    iPhone Next Gen, TBD
 iPhone5,1 ->    iPhone Next Gen, TBD
 
 iPod1,1   ->    iPod touch 1G, N45
 iPod2,1   ->    iPod touch 2G, N72
 iPod2,2   ->    Unknown, ??
 iPod3,1   ->    iPod touch 3G, N18
 iPod4,1   ->    iPod touch 4G, N80
 
 // Thanks NSForge
 iPad1,1   ->    iPad 1G, WiFi and 3G, K48
 iPad2,1   ->    iPad 2G, WiFi, K93
 iPad2,2   ->    iPad 2G, GSM 3G, K94
 iPad2,3   ->    iPad 2G, CDMA 3G, K95
 iPad3,1   ->    (iPad 3G, WiFi)
 iPad3,2   ->    (iPad 3G, GSM)
 iPad3,3   ->    (iPad 3G, CDMA)
 iPad4,1   ->    (iPad 4G, WiFi)
 iPad4,2   ->    (iPad 4G, GSM)
 iPad4,3   ->    (iPad 4G, CDMA)
 
 AppleTV2,1 ->   AppleTV 2, K66
 AppleTV3,1 ->   AppleTV 3, ??
 
 i386, x86_64 -> iPhone Simulator
 */


#pragma mark sysctlbyname utils
- (NSString *) getSysInfoByName:(char *)typeSpecifier
{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    return results;
}

- (NSString *) platform
{
    return [self getSysInfoByName:"hw.machine"];
}


// Thanks, Tom Harrington (Atomicbird)
- (NSString *) hwmodel
{
    return [self getSysInfoByName:"hw.model"];
}

#pragma mark sysctl utils
- (NSUInteger) getSysInfo: (uint) typeSpecifier
{
    size_t size = sizeof(int);
    int results;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &results, &size, NULL, 0);
    return (NSUInteger) results;
}

- (NSUInteger) cpuFrequency
{
    return [self getSysInfo:HW_CPU_FREQ];
}

- (NSUInteger) busFrequency
{
    return [self getSysInfo:HW_BUS_FREQ];
}

- (NSUInteger) cpuCount
{
    return [self getSysInfo:HW_NCPU];
}

- (NSUInteger) totalMemory
{
    return [self getSysInfo:HW_PHYSMEM];
}

- (NSUInteger) userMemory
{
    return [self getSysInfo:HW_USERMEM];
}

- (NSUInteger) maxSocketBufferSize
{
    return [self getSysInfo:KIPC_MAXSOCKBUF];
}

#pragma mark file system -- Thanks Joachim Bean!

/*
 extern NSString *NSFileSystemSize;
 extern NSString *NSFileSystemFreeSize;
 extern NSString *NSFileSystemNodes;
 extern NSString *NSFileSystemFreeNodes;
 extern NSString *NSFileSystemNumber;
 */

- (NSNumber *) totalDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemSize];
}

- (NSNumber *) freeDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemFreeSize];
}

#pragma mark platform type and name utils
- (NSUInteger) platformType
{
    NSString *platform = [self platform];
    
    // The ever mysterious iFPGA
    if ([platform isEqualToString:@"iFPGA"])        return UIDeviceIFPGA;
    
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"])    return UIDevice1GiPhone;
    if ([platform isEqualToString:@"iPhone1,2"])    return UIDevice3GiPhone;
    if ([platform hasPrefix:@"iPhone2"])            return UIDevice3GSiPhone;
    if ([platform hasPrefix:@"iPhone3"])            return UIDevice4iPhone;
    if ([platform hasPrefix:@"iPhone4"])            return UIDevice4SiPhone;
    if ([platform hasPrefix:@"iPhone5"])            return UIDevice5iPhone; // 5.3/5.4==>iphone5c
    if ([platform hasPrefix:@"iPhone6"])            return UIDevice5SiPhone;
    if ([platform isEqualToString:@"iPhone7,1"])    return UIDevice6PlusiPhone;
    if ([platform isEqualToString:@"iPhone7,2"])    return UIDevice6iPhone;
    if ([platform isEqualToString:@"iPhone8,1"])    return UIDevice6siPhone;
    if ([platform isEqualToString:@"iPhone8,2"])    return UIDevice6sPlusiPhone;
    if ([platform isEqualToString:@"iPhone8,4"])    return UIDeviceSEiPhone;
    if ([platform isEqualToString:@"iPhone9,1"])    return UIDevice7iPhone;
    if ([platform isEqualToString:@"iPhone9,2"])    return UIDevice7PlusiPhone;
    if ([platform isEqualToString:@"iPhone9,3"])    return UIDevice7iPhone;
    if ([platform isEqualToString:@"iPhone9,4"])    return UIDevice7PlusiPhone;
    if ([platform isEqualToString:@"iPhone10,1"])    return UIDevice8iPhone;
    if ([platform isEqualToString:@"iPhone10,2"])    return UIDevice8PlusiPhone;
    if ([platform isEqualToString:@"iPhone10,4"])    return UIDevice8iPhone;
    if ([platform isEqualToString:@"iPhone10,5"])    return UIDevice8PlusiPhone;
    if ([platform isEqualToString:@"iPhone10,3"])    return UIDeviceXiPhone;
    if ([platform isEqualToString:@"iPhone10,6"])    return UIDeviceXiPhone;
    
    // iPod
    if ([platform hasPrefix:@"iPod1"])              return UIDevice1GiPod;
    if ([platform hasPrefix:@"iPod2"])              return UIDevice2GiPod;
    if ([platform hasPrefix:@"iPod3"])              return UIDevice3GiPod;
    if ([platform hasPrefix:@"iPod4"])              return UIDevice4GiPod;
    if ([platform hasPrefix:@"iPod5"])              return UIDevice5GiPod;
    if ([platform hasPrefix:@"iPod6"])              return UIDevice6GiPod;
    
    // iPad
    if ([platform hasPrefix:@"iPad1"])              return UIDevice1GiPad;
    if ([platform hasPrefix:@"iPad2"])              return UIDevice2GiPad;
    if ([platform hasPrefix:@"iPad3"])              return UIDevice3GiPad;
    if ([platform hasPrefix:@"iPad4"])              return UIDevice4GiPad;
    
    // Apple TV
    if ([platform hasPrefix:@"AppleTV2"])           return UIDeviceAppleTV2;
    if ([platform hasPrefix:@"AppleTV3"])           return UIDeviceAppleTV3;
    
    if ([platform hasPrefix:@"iPhone"])             return UIDeviceUnknowniPhone;
    if ([platform hasPrefix:@"iPod"])               return UIDeviceUnknowniPod;
    if ([platform hasPrefix:@"iPad"])               return UIDeviceUnknowniPad;
    if ([platform hasPrefix:@"AppleTV"])            return UIDeviceUnknownAppleTV;
    
    // Simulator thanks Jordan Breeding
    if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"])
    {
        BOOL smallerScreen = [[UIScreen mainScreen] bounds].size.width < 1024;
        return smallerScreen ? UIDeviceSimulatoriPhone : UIDeviceSimulatoriPad;
    }
    
    return UIDeviceUnknown;
}

+ (NSString *) platformString
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine
                                                encoding:NSUTF8StringEncoding];
    
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"VerizoniPhone4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone6Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone6sPlus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhoneSE";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone7Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone7";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone7Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"])   return @"iPhone8";
    if ([deviceString isEqualToString:@"iPhone10,2"])   return @"iPhone8Plus";
    if ([deviceString isEqualToString:@"iPhone10,4"])   return @"iPhone8";
    if ([deviceString isEqualToString:@"iPhone10,5"])   return @"iPhone8Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])   return @"iPhoneX";
    if ([deviceString isEqualToString:@"iPhone10,6"])   return @"iPhoneX";
    if ([deviceString isEqualToString:@"iPhone11,8"])   return @"iPhoneXR";
    if ([deviceString isEqualToString:@"iPhone11,2"])   return @"iPhoneXS";
    if ([deviceString isEqualToString:@"iPhone11,6"])   return @"iPhoneXSMax";

    
    //iPod
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod1";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod2";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod3";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod4";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod5";
    
    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad2";//(WiFi)
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad2";// (GSM)
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad2";//(CDMA)
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad2";//(32nm)
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad_mini";//(WiFi)
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad_mini";//(GSM)
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad_mini";//(CDMA)
    
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad3";//(WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad3";//(CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad3";//(4G)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad4";// (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad4";// (4G)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad4";// (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPadAir";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPadAir";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPadAir";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPadAir2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPadAir2";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    if ([deviceString isEqualToString:@"iPad4,4"]
        ||[deviceString isEqualToString:@"iPad4,5"]
        ||[deviceString isEqualToString:@"iPad4,6"])      return @"iPadmini2";
    
    if ([deviceString isEqualToString:@"iPad4,7"]
        ||[deviceString isEqualToString:@"iPad4,8"]
        ||[deviceString isEqualToString:@"iPad4,9"])      return @"iPadmini3";
    
    return deviceString;
}

// added by
- (BOOL)supportResizeImage
{
    NSUInteger platformType = [self platformType];
    BOOL rt = platformType == UIDevice1GiPhone
    || platformType == UIDevice3GiPhone
    || platformType == UIDevice1GiPod
    || platformType == UIDevice2GiPod;
    
    return !rt;
}


- (BOOL) hasRetinaDisplay
{
    return ([UIScreen mainScreen].scale == 2.0f);
}

- (UIDeviceFamily) deviceFamily
{
    NSString *platform = [self platform];
    if ([platform hasPrefix:@"iPhone"]) return UIDeviceFamilyiPhone;
    if ([platform hasPrefix:@"iPod"]) return UIDeviceFamilyiPod;
    if ([platform hasPrefix:@"iPad"]) return UIDeviceFamilyiPad;
    if ([platform hasPrefix:@"AppleTV"]) return UIDeviceFamilyAppleTV;
    
    return UIDeviceFamilyUnknown;
}

#pragma mark MAC addy
// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
// Accidentally munged during previous update. Fixed thanks to mlamb.
- (NSString *) macaddress
{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Error: Memory allocation error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2\n");
        free(buf); // Thanks, Remy "Psy" Demerest
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    free(buf);
    return outstring;
}

@end
