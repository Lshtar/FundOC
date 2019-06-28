//
//  HXFRequestManager.m
//  HXFund
//
//  Created by D on 2019/5/29.
//  Copyright © 2019 D. All rights reserved.
//

#import "HXFRequestManager.h"
#import <AFNetworking/AFNetworking.h>

@interface HXFRequestManager ()
{
    NSString *_token;
    NSString *_dToken;
}
@end

@implementation HXFRequestManager

+ (id)sharedManager{
    static HXFRequestManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HXFRequestManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (AFHTTPSessionManager *)managerForRequest:(HXFRequest *)request {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (request.serializeType == VKRequestSerializeTypeHTTP) {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    } else if (request.serializeType == VKRequestSerializeTypeJSON) {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    _token = [HXFUserManager shareManager].token;
    _dToken = [HXFUserManager shareManager].dynamicToken;
    
    if (_token && _token.length) {
        [manager.requestSerializer setValue:_token forHTTPHeaderField:@"HX-TOKEN"];
    }else {
        [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"HX-TOKEN"];
    }
    if (_dToken && _dToken.length) {
        [manager.requestSerializer setValue:_dToken forHTTPHeaderField:@"HX-DYNAMIC-TOKEN"];
    }else {
        [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"HX-DYNAMIC-TOKEN"];
    }
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"HX-PLATFORM"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"HX-CHANNEL"];
    //
    NSString *appVersionString = [HXFCommonTool appVersion];
    NSString *deviceString = [HXFCommonTool deviceUUId];
    NSString *platformString = [HXFCommonTool iphonePlatform];
    NSString *numberString = [HXFCommonTool requestUUId];
    //
    [manager.requestSerializer setValue:appVersionString forHTTPHeaderField:@"HX-CLIENT-VERSION"];
    [manager.requestSerializer setValue:deviceString forHTTPHeaderField:@"HX-DEVICE-CODE"];
    [manager.requestSerializer setValue:platformString forHTTPHeaderField:@"HX-MODEL"];
    [manager.requestSerializer setValue:numberString forHTTPHeaderField:@"HX-SERIAL-NUMBER"];
    //
    manager.requestSerializer.timeoutInterval = request.timeout;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/javascript", @"text/html", @"text/plain", nil];
    //
    DLog(@"⭐️\nrequestUrl=%@\nHX-SERIAL-NUMBER=%@",request.requestUrl,numberString);
    DLog(@"HTTPRequestHeaders = %@",    manager.requestSerializer.HTTPRequestHeaders);
    //
    return manager;
}

- (NSString *)urlForRequest:(HXFRequest *)request {
    return request.requestUrl;
}

- (id)successBlockForRequest:(HXFRequest *)request
           completionHandler:(CompletionHandler)completionHandler {
    return ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *resultDictionary = (NSDictionary *)responseObject;
        NSString *status = [resultDictionary  valueForKey:@"status"];
        NSString *code = [resultDictionary  valueForKey:@"code"];
        NSString *message = [resultDictionary  valueForKey:@"message"];
        NSDictionary *data = [resultDictionary valueForKey:@"data"];
        if([status isEqualToString:@"T"])
        {
            completionHandler(YES,code,message,data,nil);
        }
        else
        {
            completionHandler(NO,code,message,data,nil);
        }
    };
}

- (id)failureBlockForRequest:(HXFRequest *)request
           completionHandler:(CompletionHandler)completionHandler {
    
    return ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(NO,netwrok_error_code,@"当前网络不佳，请检查",[NSDictionary dictionary],error);
    };
}

- (NSURLSessionDataTask *)sendRequest:(HXFRequest *)request completionHandler:(CompletionHandler)completionHandler
{
    //添加网络判断
    HXFReachability *reach = [HXFReachability reachabilityForInternetConnection];
    NetworkStatus status = [reach currentReachabilityStatus];
    if(status == NotReachable)
    {
        completionHandler(NO,netwrok_error_code,@"当前网络不佳，请检查",[NSDictionary dictionary],nil);
        NSURLSessionDataTask *task;
        return task;
    }
    //
    NSAssert([[request class] isSubclassOfClass:[HXFRequest class]], @"发送的请求必须是HXFRequest的子类!");
    NSString *method = request.method;
    NSString *domain = HXF_DOMAIN;
    NSString *url = [NSString stringWithFormat:@"%@%@",domain,[self urlForRequest:request]];
    id successBlock = [self successBlockForRequest:request
                                 completionHandler:completionHandler];
    id failureBlock = [self failureBlockForRequest:request
                                 completionHandler:completionHandler];
    AFHTTPSessionManager *manager = [self managerForRequest:request];
    //
    NSURLSessionDataTask *task;
    if ([method caseInsensitiveCompare:@"get"] == NSOrderedSame) {
        task = [manager GET:url parameters:request.parameters progress:nil success:successBlock failure:failureBlock];
    } else if ([method caseInsensitiveCompare:@"post"] == NSOrderedSame) {
        if (request.formData.count) {
            id bodyBlock = ^(id<AFMultipartFormData>  _Nonnull formData) {
                [request.formData enumerateObjectsUsingBlock:^(VKRequestFormData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [formData appendPartWithFileData:obj.data name:obj.name fileName:obj.filename mimeType:obj.mimeType];
                }];
            } ;
            task = [manager POST:url parameters:request.parameters constructingBodyWithBlock:bodyBlock progress:nil success:successBlock failure:failureBlock];
        } else {
            task = [manager POST:url parameters:request.parameters progress:nil success:successBlock failure:failureBlock];
        }
    } else if ([method caseInsensitiveCompare:@"put"] == NSOrderedSame) {
        task = [manager PUT:url parameters:request.parameters success:successBlock failure:failureBlock];
    } else if ([method caseInsensitiveCompare:@"delete"] == NSOrderedSame) {
        task = [manager PUT:url parameters:request.parameters success:successBlock failure:failureBlock];
    }
    return task;
}

@end
