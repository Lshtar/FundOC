//
//  HXFConfiguration.h
//  HXFund
//
//  Created by D on 2019/5/28.
//  Copyright © 2019 D. All rights reserved.
//

#ifndef HXFConfiguration_h
#define HXFConfiguration_h

//专线号码
#define SpecialLine_number @"4000048821"
#define netwrok_error_code       @"999"

#if HXF_Environment_Mode

#define MD5_Key  @"a31ea9d9-db3a-4dad-abc9-75c21d0de00d"

#else

#define MD5_Key  @"1ba3844e-5c2a-4e3d-bca3-b3683059221c"

#endif

/**
 只适用于控制器
 
 @param msg 消息
 @return hud
 */
#define showToast(msg) [HXFHUD showMessage:msg forView:self.view animation:YES];

#define showLoading [[HXFNewLoadingView shareInstance] showLoadingForView:self.view];

#define hideLoadingView [[HXFLoadingView shareInstance] hideLoading];

//判断是否空值
#define CHECK_String(string) ((string) && ([(string) isKindOfClass:[NSString class]]) && ([(string) length] > 0))
#define CHECK_Array(array) (array != nil && ![array isEqual:[NSNull null]] && array.count > 0)
#define CHECK_Dictionary(dict) (dict != nil && ![dict isEqual:[NSNull null]] && dict.count > 0)
#define CHECK_Value(value) (value != nil && ![value isEqual:[NSNull null]])

#define kIsNull(exp) ((exp == nil || exp == NULL || ([exp isKindOfClass:[NSString class]] && [exp length] == 0))?1:0)

#define WeakSelf __weak typeof(self) weakSelf = self;
#define StrongSelf __strong typeof(weakSelf) self = weakSelf;


///------ 有效性验证<字符串、数组、字典等> ------
#define VALID_STRING(str)      ((str) && ([(str) isKindOfClass:[NSString class]]) && ([(str) length] > 0))
#define VALID_ARRAY(arr)       ((arr) && ([(arr) isKindOfClass:[NSArray class]]) && ([(arr) count] > 0))
#define VALID_DICTIONARY(dict) ((dict) && ([(dict) isKindOfClass:[NSDictionary class]]) && ([(dict) count] > 0))
#define VALID_NUMBER(number)   ((number) && ([(number) isKindOfClass:NSNumber.class]))

#endif /* HXFConfiguration_h */
