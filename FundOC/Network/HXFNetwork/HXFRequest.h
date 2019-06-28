//
//  HXFRequest.h
//  HXFund
//
//  Created by D on 2019/5/29.
//  Copyright © 2019 D. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    VKRequestSerializeTypeHTTP,
    VKRequestSerializeTypeJSON
} VKRequestSerializeType;

@interface VKRequestFormData : NSObject

@property (nonatomic, copy, readonly) NSData *data;

@property (nonatomic, copy, readonly) NSString *name;

@property (nonatomic, copy, readonly) NSString *filename;

@property (nonatomic, copy, readonly) NSString *mimeType;

+ (instancetype)formDataWithData:(NSData *)data
                            name:(NSString *)name
                        filename:(NSString *)filename
                        mimeType:(NSString *)mimeType;

@end

@interface HXFRequest : NSObject
/**
 构造Request
 
 @param parameters 请求携带参数
 @return request
 */
+ (instancetype)requestWithParameters:(id)parameters;

/**
 url
 */
@property (nonatomic, copy, readonly) NSString *requestUrl;

/**
 方法
 */
@property (nonatomic, copy, readonly) NSString *method;

/**
 携带参数
 */
@property (nonatomic, copy, readonly) id parameters;

/**
 参数提交格式
 */
@property (nonatomic, readonly) VKRequestSerializeType serializeType;

/**
 请求超时
 */
@property (nonatomic, readonly) NSTimeInterval timeout;

/**
 重试次数
 */
@property (nonatomic, readonly) NSUInteger retryCount;

/**
 form data
 */
@property (nonatomic, copy) NSArray <VKRequestFormData *> *formData;


/**
 验证responseData
 
 @param responseObject 服务端返回data
 @return YES or NO
 */
- (BOOL)validResponse:(id)responseObject;


- (id)jsonObjectFromResponseObject:(id)responseObject;

/**
 解析结果
 
 @param jsonObject JSON字典或数组
 @return Object对象
 */
- (id)parseJSON:(id)jsonObject;

@end

NS_ASSUME_NONNULL_END
