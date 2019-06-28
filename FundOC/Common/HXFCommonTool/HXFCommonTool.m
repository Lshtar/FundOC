//
//  HXFCommonTool.m
//  HXFund
//
//  Created by D on 2019/5/29.
//  Copyright © 2019 D. All rights reserved.
//

#import "HXFCommonTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSString+HXFVerbHelper.h"
#import "JKEncrypt.h"
#import "UIDevice+HXFHardware.h"
#import "HXFKeychain.h"

@implementation HXFCommonTool
+ (float)deviceSystemVersion
{
    float systemVersion = [UIDevice currentDevice].systemVersion.floatValue;
    return systemVersion;
}

+ (NSString *)appVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (BOOL)isAvailablePhone:(NSString *)phone
{
    return [phone isMobileNumber];
}

+ (NSString *)deviceUUId
{
    if([[HXFKeychain getUUID] length] == 0)
    {
        NSString *UUIDString = [[UIDevice currentDevice].identifierForVendor UUIDString];
        [HXFKeychain saveUUID:UUIDString];
    }
    return [HXFKeychain getUUID];
}

//请求接口的唯一标识
+ (NSString *)requestUUId
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    
    CFRelease(puuid);
    
    CFRelease(uuidString);
    
    return result;
}

+ (NSString *)MD5:(NSString *)input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

//3desc+md5
+ (NSString *)TDESMD5:(NSString *)input
{
    JKEncrypt * en = [[JKEncrypt alloc]init]; //加密
    
    NSString * encryptStr = [en doEncryptStr:input];
    
    NSString *result = [HXFCommonTool MD5:encryptStr];
    
    return result;
}

+ (BOOL)isReleaseEnvironment
{
    BOOL result;
#if HXF_Environment_Mode
    result = YES;
#else
    result = NO;
#endif
    return result;
}

//高度自适应(根据固定的宽度，字体，文字来计算)
+(CGFloat)getHeightWithWidth:(CGFloat)contentWidth andfont:(UIFont *)contentFont andText:(NSString *)contentString
{
    float contentLabelHEIGHT = 0;
    NSDictionary *attribute = @{NSFontAttributeName:contentFont};
    CGSize size = [contentString boundingRectWithSize:CGSizeMake(contentWidth, 10000) options: NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    contentLabelHEIGHT = size.height;
    return contentLabelHEIGHT;
}

//宽度自适应(根据固定的高度，字体，文字来计算)
+(CGFloat)getWidthWithHeight:(CGFloat)contentHeight andfont:(UIFont *)contentFont andText:(NSString *)contentString
{
    float contentLabelWidth = 0;
    NSDictionary *attribute = @{NSFontAttributeName:contentFont};
    CGSize size = [contentString boundingRectWithSize:CGSizeMake(10000, contentHeight) options:  NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil].size;
    contentLabelWidth = size.width;
    
    return contentLabelWidth;
}

//字符串转字典
+(NSDictionary *)dictionaryFromJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        return nil;
    }
    return dic;
}

//字典转字符串(此处注意)
+(NSString *)jsonStringFromDictionary:(NSDictionary *)dictionary
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return string;
    
}

//一行字符串有2种及以上的颜色
+(NSMutableAttributedString *)oneWordWithString:(NSMutableArray *)stringArray andColor:(NSMutableArray *)colorArray andFont:(NSMutableArray *)fontArray
{
    NSString *stringContent = @"";
    for(int i=0;i<[stringArray count];i++)
    {
        stringContent = [stringContent stringByAppendingString:[stringArray objectAtIndex:i]];
    }
    //
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:stringContent];
    NSUInteger currentLength = 0;
    NSUInteger totalLength = 0;
    for(NSUInteger j=0;j<[stringArray count];j++)
    {
        currentLength = [[stringArray objectAtIndex:j] length];
        //
        [str addAttribute:NSForegroundColorAttributeName value:[colorArray objectAtIndex:j] range:NSMakeRange(totalLength,currentLength)];
        [str addAttribute:NSFontAttributeName value:[fontArray objectAtIndex:j] range:NSMakeRange(totalLength,currentLength)];
        //          [str addAttribute:NSKernAttributeName value:@0 range:NSMakeRange(totalLength,currentLength)];
        //
        totalLength = totalLength +currentLength;
    }
    return str;
}

//正则表达式(判断规则:只包含数字不判断位数)
+(BOOL)regularOnlyNumberExpressionsWithString:(NSString *)string
{
    NSString * regex = @"^[0-9]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:string];
}

//iphone手机型号
+ (NSString *)iphonePlatform
{
    return [UIDevice platformString];
}

//md5加密流程返回字典
+ (NSDictionary *)dictionaryMd5ResultWithDictionary:(NSDictionary *)dictionary
{
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    NSString *sign = [HXFCommonTool stringMd5ResultWithDictionary:dictionary];
    [mutDic setValue:sign forKey:@"sign"];
    return [mutDic copy];
}

//md5加密流程
+ (NSString *)stringMd5ResultWithDictionary:(NSDictionary *)dictionary
{
    NSArray *keyArray = dictionary.allKeys;
    NSArray *compareArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2)
                             {
                                 return [obj1 compare:obj2] == NSOrderedDescending ? NSOrderedDescending : NSOrderedAscending;
                             }];
    
    NSString *joinString = @"";
    for(NSInteger i=0;i<[compareArray count]; i++)
    {
        NSString *tempKey = compareArray[i];
        //        NSString *tempString = [NSString stringWithFormat:@"%@=%@&",tempKey,[dictionary valueForKey:tempKey]];
        
        id tempValue = [dictionary valueForKey:tempKey];
        NSString *tempString;
        if ([tempValue isKindOfClass:[NSString class]]) {
            tempString = [NSString stringWithFormat:@"%@=%@&",tempKey,[dictionary valueForKey:tempKey]];
        }else {
            NSError *error = nil;
            NSString * jsonString1;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tempValue options:nil error:&error];
            jsonString1 = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            tempString = [NSString stringWithFormat:@"%@=%@&",tempKey,jsonString1];
        }
        
        joinString = [joinString stringByAppendingString:tempString];
    }
    
    NSString *keyDec = [NSString stringWithFormat:@"key=%@",MD5_Key];
    
    joinString = [joinString stringByAppendingString:keyDec];
    
    NSString *md5String = [HXFCommonTool MD5:joinString];
    return [md5String uppercaseString];
}

//两张图片合成一张图
+ (UIImage *)composeImgageBackgroundImg:(UIImage *)backgroundImg addImg:(UIImage *)addImg addframe:(CGRect)addFrame
{
    //背景图
    CGImageRef backgroundImgRef = backgroundImg.CGImage;
    CGFloat backgroundWidth = CGImageGetWidth(backgroundImgRef);
    CGFloat backgroundHeight = CGImageGetHeight(backgroundImgRef);
    
    //添加的图
    CGImageRef addImgRef = addImg.CGImage;
    
    //以背景图大小为画布创建上下文
    UIGraphicsBeginImageContext(CGSizeMake(backgroundWidth, backgroundHeight));
    [backgroundImg drawInRect:CGRectMake(0, 0, backgroundWidth, backgroundHeight)];//先把1.png 画到上下文中
    [addImg drawInRect:addFrame];//再把小图放在上下文中
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();//从当前上下文中获得最终图片
    UIGraphicsEndImageContext();//关闭上下文
    
    CGImageRelease(addImgRef);
    CGImageRelease(backgroundImgRef);
    
    return resultImg;
}

//返回一个拉伸的image去掉top、left、bottom、right、之后。中间部分拉伸
+ (UIImage *)stretchImage:(UIImage *)originImage top:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right
{
    // 设置端盖的值
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    // 设置拉伸的模式
    UIImageResizingMode mode = UIImageResizingModeStretch;
    // 拉伸图片
    UIImage *newImage = [originImage resizableImageWithCapInsets:edgeInsets resizingMode:mode];
    return newImage;
}

//3desc加密
+ (NSString *)EncryptThreeTDES:(NSString *)input
{
    JKEncrypt * en = [[JKEncrypt alloc]init]; //加密
    
    NSString * result = [en doEncryptStr:input];
    
    return result;
}
//3des解密
+ (NSString *)DecEncryptThreeTDES:(NSString *)input
{
    JKEncrypt * en = [[JKEncrypt alloc]init]; //加密
    
    NSString * result = [en doDecEncryptStr:input];
    
    return result;
}

//h5调用原生加密方法
+ (NSString *)H5EncryWithString:(NSString *)string
{
    NSString *keyDec = [NSString stringWithFormat:@"&key=%@",MD5_Key];
    
    string = [string stringByAppendingString:keyDec];
    
    NSString *md5String = [HXFCommonTool MD5:string];
    
    return [md5String uppercaseString];
}
/**
 给数字字符串（每隔3位）加逗号
 
 @param string 传入字符串
 @return 返回字符串
 */
+ (NSString *)changeCommaWithString:(NSString *)string
{
    NSArray <NSString *>*arr = [string componentsSeparatedByString:@"."];
    NSInteger intPart = [arr[0] integerValue];
    NSInteger commaNum = arr[0].length/3;//小数点前边的整数部分
    if (commaNum == 0) {
        if (arr.count == 2) {//有小数的话
            return [NSString stringWithFormat:@"%@.%@",arr[0],arr[1]];
        }else {//没小数的话
            return arr[0];
        }
    }else {
        NSMutableString *result = [NSMutableString stringWithFormat:@""];
        
        for (NSInteger i = 0; i < commaNum + 1; i ++) {
            NSInteger yushu = intPart%1000;//余数
            intPart = intPart/1000;
            NSString *yushuStr;
            if (yushu >= 0 && yushu < 10) {//如果余数为小于10，而且前边还有数 需要补0
                yushuStr = [NSString stringWithFormat:@",00%ld",yushu];
            }else if (yushu >= 10 && yushu < 100) {//如果余数为小于100，而且前边还有数 需要补"0",","
                yushuStr = [NSString stringWithFormat:@",0%ld",yushu];
            }else if (yushu >= 100 && yushu < 1000) {//如果余数为小于1000，而且前边还有数 需要补","
                yushuStr = [NSString stringWithFormat:@",%ld",yushu];
            }
            [result insertString:yushuStr atIndex:0];
        }
        NSInteger length = result.length;
        for (NSInteger i = 0; i < length; i ++) {
            if ([result hasPrefix:@"0"]||[result hasPrefix:@","]) {
                [result deleteCharactersInRange:NSMakeRange(0, 1)];
            }else {
                break;
            }
        }
        if (arr.count == 2) {//有小数的话
            return [NSString stringWithFormat:@"%@.%@",result,arr[1]];
        }else {//没小数的话
            return result;
        }
    }
}
/**
 删除数字字符串中的逗号
 
 @param string 传入字符串
 @return 返回字符串
 */
+ (NSString *)deleteCommaWithString:(NSString *)string {
    NSString *result = [string stringByReplacingOccurrencesOfString:@"," withString:@""];
    return result;
}
+ (NSString *)changeTenThousand:(NSString *)string {
    NSInteger num = [string integerValue];
    if (num >= 10000) {
        double doubleNum = num/10000.0000;
        string = [NSString stringWithFormat:@"%lf",doubleNum];
        //        NSInteger length = string.length;
        NSArray <NSString *>*arr1 = [string componentsSeparatedByString:@"."];
        NSString *lastObj;
        if (arr1.count > 1) {
            lastObj = [NSString stringWithFormat:@".%@",arr1[1]];
            NSInteger length1 = lastObj.length;
            for (NSInteger i = 0; i < length1; i ++) {
                if ([lastObj hasSuffix:@"0"]||[lastObj hasSuffix:@"."]) {
                    lastObj = [lastObj substringWithRange:NSMakeRange(0, lastObj.length - 1)];
                }
            }
            string = [NSString stringWithFormat:@"%@%@",arr1[0],lastObj];
        }else {
            
        }
        string = [NSString stringWithFormat:@"%@万",string];
    }
    return string;
}

//将一个字符串中单个字符分割转化成数组
+ (NSMutableArray *)getArrayWithString:(NSString *)string
{
    NSMutableArray *mutArray = [NSMutableArray array];
    if(string.length>0)
    {
        for (NSInteger k=0; k<string.length; k++)
        {
            NSString *single = [string substringWithRange:NSMakeRange(k, 1)];
            [mutArray addObject:single];
        }
    }
    return mutArray;
}
+ (NSString *)separateWithSpacePerFourLetter:(NSString *)string {
    NSMutableString *mutableString = [NSMutableString string];
    NSInteger shang = string.length/4;
    //    NSInteger yushu = string.length%4;
    for (NSInteger i = 0; i < shang; i ++) {
        NSString *appending = [string substringToIndex:4];
        string = [string substringFromIndex:4];
        [mutableString appendFormat:@"%@ ",appending];
    }
    [mutableString appendString:string];
    if ([mutableString hasSuffix:@" "]) {
        [mutableString deleteCharactersInRange:NSMakeRange(mutableString.length - 1, 1)];
    }
    return mutableString;
}

//绘制view中制定的frame成一个image
+ (UIImage *)imageWithView:(UIView *)view frame:(CGRect)frame
{
    int scale = [UIScreen mainScreen].scale;
    CGRect rect = frame;
    rect.origin.x *= scale;
    rect.origin.y *= scale;
    rect.size.width *= scale;
    rect.size.height *= scale;
    
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) {
        return nil;
    }
    [view.layer renderInContext:context];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    //  这里是重点, 意思是取范围内的cgimage
    CGImageRef cgImage = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage * newImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return newImage;
    
}

//绘制将image绘制成带圆角的
+ (UIImage*)changeImage:(UIImage *)originImage cornerRadius:(CGFloat)radius
{
    CGRect rect = (CGRect){0.f,0.f,originImage.size};
    //size——同UIGraphicsBeginImageContext,参数size为新创建的位图上下文的大小
    //opaque—透明开关，如果图形完全不用透明，设置为YES以优化位图的存储。
    //scale—–缩放因子
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    //根据矩形画带圆角的曲线
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    [originImage drawInRect:rect];
    //图片缩放，是非线程安全的
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    return image;
}

//手机号转换方法中间4位是****
+ (NSString *)changeMobileShowStatus:(NSString *)mobile
{
    if(mobile.length==11)
    {
        NSString *prefixString = [mobile substringToIndex:3];
        NSString *suffixString = [mobile substringFromIndex:(mobile.length-4)];
        NSString *merge = [NSString stringWithFormat:@"%@****%@",prefixString,suffixString];
        return merge;
    }
    return mobile;
}
/**
 根据View切图片
 
 @param view 要切的View
 @return 返回的图片
 */
+ (UIImage *)captureScreenView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.size, YES, [UIScreen mainScreen].scale); //currentView 当前的view  创建一个基于位图的图形上下文并指定大小为
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];//renderInContext呈现接受者及其子范围到指定的上下文
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();//返回一个基于当前图形上下文的图片
    UIGraphicsEndImageContext();
    return image;
}
+ (BOOL)compareVersionNum:(NSString *)version {
    BOOL result = NO;
    NSString *localV = [HXFCommonTool appVersion];
    NSArray *arr1 = [localV componentsSeparatedByString:@"."];
    NSArray *arr2 = [version componentsSeparatedByString:@"."];
    if ([arr1[0] integerValue] < [arr2[0] integerValue]) {
        result = YES;
    }else if ([arr1[0] integerValue] == [arr2[0] integerValue]) {
        if ([arr1[1] integerValue] < [arr2[1] integerValue]) {
            result = YES;
        }else if ([arr1[1] integerValue] == [arr2[1] integerValue]) {
            if ([arr1[2] integerValue] < [arr2[2] integerValue]) {
                result = YES;
            }else {
                result = NO;
            }
        }else {
            result = NO;
        }
    }else {
        result = NO;
    }
    return result;
}
+ (UIImage *)gaoSiImageWithFrame:(CGRect )frame image:(UIImage *)image{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *ciImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    //设置模糊程度
    [filter setValue:@8.0f forKey: @"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    NSLog(@"%f,%f,%f,%f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
    CGImageRef outImage = [context createCGImage: result fromRect:frame];
    UIImage * blurImage = [UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;
    
}

+ (UILabel*)textStr:(NSString *)textStr strColor:(UIColor *)strColor backgroudColor:(UIColor *)backgroundColor
{
    UILabel* strLabel = [[UILabel alloc] initWithFrame:CGRectMake(19 , 16.5, 29, 18)];
    strLabel.backgroundColor = backgroundColor;
    strLabel.layer.masksToBounds = YES;
    strLabel.layer.cornerRadius = 5;
    strLabel.font = [UIFont systemFontOfSize:12.0f];
    strLabel.textColor = strColor;
    strLabel.text = textStr;
    strLabel.textAlignment = NSTextAlignmentCenter;
    return strLabel;
}

@end
