//
//  NSString+HXFVerbHelper.h
//  HXFund
//
//  Created by D on 2019/5/29.
//  Copyright © 2019 D. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HXFVerbHelper)
// 是否同时包含数字和字母
- (BOOL)containCharacterAndNumber;
//检测是否是手机号码
- (BOOL)isMobileNumber;
//身份证号
- (BOOL)isIDCard;
//精确的身份证号码
- (BOOL)isAccurateIDCard;
// 银行卡号
- (BOOL)isBankCard;
//昵称
+ (BOOL) validateNickname:(NSString *)nickname;
//用户名
+ (BOOL) validateUserName:(NSString *)name;

- (BOOL)isNumberAndDotError;

-(BOOL)testNumberAndPointOfTF;

-(NSString *)substringWithDotBehindLength:(NSInteger)length;

+ (BOOL)stringContainsEmoji:(NSString *)string;

- (BOOL)isName;

/**
 *    @brief    固定电话区号格式化（将形如 01085792889 格式化为 010-85792889）
 *
 *    @return    返回格式化后的号码（形如 010-85792889）
 */
- (NSString*)areaCodeFormat;

/**
 *    @brief    验证固定电话区号是否正确（e.g. 010正确，040错误）
 *
 *    @return    返回固定电话区号是否正确
 */
- (BOOL)isAreaCode;


@end

NS_ASSUME_NONNULL_END
