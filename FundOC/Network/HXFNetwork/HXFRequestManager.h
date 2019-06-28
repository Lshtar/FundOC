//
//  HXFRequestManager.h
//  HXFund
//
//  Created by D on 2019/5/29.
//  Copyright © 2019 D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXFRequest.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CompletionHandler)(BOOL success, NSString *code, NSString *message,NSDictionary *data,NSError *error);

@interface HXFRequestManager : NSObject

+ (instancetype)sharedManager;

- (NSURLSessionDataTask *)sendRequest:(HXFRequest *)request completionHandler:(CompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
