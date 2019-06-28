//
//  HXFNetWorkManager.h
//  HXFund
//
//  Created by D on 2019/5/29.
//  Copyright © 2019 D. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXFNetWorkTool;

@protocol AFMultipartFormData;

typedef void(^AFConstructingBodyBlock)(id<AFMultipartFormData> data);
typedef void(^AFURLSessionTaskProgressBlock)(NSProgress *progress);


/*!
 *   AFN 请求封装的Block回调
 */
typedef void(^HXFRequestSuccessBlock)(NSInteger errCode, NSDictionary *responseDict, id model);
typedef void(^HXFRequestFailureBlock)(NSError *error);


/*!
 *   AFN 请求封装的代理回调
 */
@protocol HXFNetWorkToolDelegate <NSObject>

@optional
/**
 *   请求结束
 *   @param returnData 返回的数据
 */
- (void)requestDidFinishLoadingWithData:(id)returnData errCode:(NSInteger)errCode;

/**
 *   请求失败
 *   @param error 失败的 error
 */
- (void)requestDidFailWithError:(NSError *)error;

/**
 *   网络请求项即将被移除掉
 *   @param item 网络请求项
 */
- (void)requestWillDealloc:(HXFNetWorkTool *)item;
//NS_ASSUME_NONNULL_BEGIN
//
//
//@interface HXFNetWorkManager : NSObject
//
//@end
//
//NS_ASSUME_NONNULL_END
