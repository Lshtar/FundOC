//
//  HXFCommonTool.h
//  HXFund
//
//  Created by D on 2019/5/29.
//  Copyright © 2019 D. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HXFCommonTool : NSObject
//系统版本
+ (float)deviceSystemVersion;

//app版本
+ (NSString *)appVersion;

//校验手机号
+ (BOOL)isAvailablePhone:(NSString *)phone;

//设备唯一标识
+ (NSString *)deviceUUId;

//请求接口的唯一标识
+ (NSString *)requestUUId;

//md5加密
+ (NSString *)MD5:(NSString *)input;

//是否是正式环境
+ (BOOL)isReleaseEnvironment;

//高度自适应(根据固定的宽度，字体，文字来计算)
+(CGFloat)getHeightWithWidth:(CGFloat)contentWidth andfont:(UIFont *)contentFont andText:(NSString *)contentString;

//宽度自适应(根据固定的高度，字体，文字来计算)
+(CGFloat)getWidthWithHeight:(CGFloat)contentHeight andfont:(UIFont *)contentFont andText:(NSString *)contentString;

//字符串转字典
+(NSDictionary *)dictionaryFromJsonString:(NSString *)jsonString;

//字典转字符串
+(NSString *)jsonStringFromDictionary:(NSDictionary *)dictionary;

//一行字符串有2种及以上的颜色以及字体
+(NSMutableAttributedString *)oneWordWithString:(NSMutableArray *)stringArray andColor:(NSMutableArray *)colorArray andFont:(NSMutableArray *)fontArray;

//正则表达式(判断规则:只包含数字不判断位数)
+(BOOL)regularOnlyNumberExpressionsWithString:(NSString *)string;

//iphone手机型号
+ (NSString *)iphonePlatform;

//md5加密流程返回字典
+ (NSDictionary *)dictionaryMd5ResultWithDictionary:(NSDictionary *)dictionary;

//两张图片合成一张图
+ (UIImage *)composeImgageBackgroundImg:(UIImage *)backgroundImg addImg:(UIImage *)addImg addframe:(CGRect)addFrame;

//返回一个拉伸的image去掉top、left、bottom、right、之后。中间部分拉伸
+ (UIImage *)stretchImage:(UIImage *)originImage top:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;

//3desc加密
+ (NSString *)EncryptThreeTDES:(NSString *)input;
//3des解密
+ (NSString *)DecEncryptThreeTDES:(NSString *)input;
//h5调用原生加密方法
+ (NSString *)H5EncryWithString:(NSString *)string;

/**
 给数字字符串（每隔3位）加逗号
 
 @param string 传入字符串
 @return 返回字符串
 */
+ (NSString *)changeCommaWithString:(NSString *)string;

/**
 删除数字字符串中的逗号
 
 @param string 传入字符串
 @return 返回字符串
 */
+ (NSString *)deleteCommaWithString:(NSString *)string;

/**
 转成万元的方法
 
 @param string 传入数字字符串
 @return 返回字符串
 */
+ (NSString *)changeTenThousand:(NSString *)string;

//将一个字符串中单个字符分割转化成数组
+ (NSMutableArray *)getArrayWithString:(NSString *)string;


/**
 将字符串每四位用空格分割
 
 @param string 原字符串
 @return 返回的字符串
 */
+ (NSString *)separateWithSpacePerFourLetter:(NSString *)string;

//绘制view中制定的frame成一个image
+ (UIImage *)imageWithView:(UIView *)view frame:(CGRect)frame;

//绘制将image绘制成带圆角的
+ (UIImage*)changeImage:(UIImage *)originImage cornerRadius:(CGFloat)radius;

//手机号转换方法中间4位是****
+ (NSString *)changeMobileShowStatus:(NSString *)mobile;
/**
 根据View切图片
 
 @param view 要切的View
 @return 返回的图片
 */
+ (UIImage *)captureScreenView:(UIView *)view;

/**
 yes是后台大于前端版本号显示后台版本，no 显示"最新版本" 或者根据需求显示
 @param version 后台版本号
 @return yes or no;
 */
+ (BOOL)compareVersionNum:(NSString *)version;


/**
 高斯模糊图片
 
 @param frame frame
 @return image
 */

/**
 高斯模糊图片
 
 @param frame frame
 @param image 被高斯模糊的图片
 @return image
 */
+ (UIImage *)gaoSiImageWithFrame:(CGRect )frame image:(UIImage *)image;

/**
 根据传入的文字 显示背景,文字颜色
 */

+ (UILabel*) textStr:(NSString*) textStr strColor:(UIColor*) strColor  backgroudColor:(UIColor*) backgroundColor;

@end

NS_ASSUME_NONNULL_END
