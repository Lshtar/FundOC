//
//  HXFRequest.m
//  HXFund
//
//  Created by D on 2019/5/29.
//  Copyright © 2019 D. All rights reserved.
//

#import "HXFRequest.h"

@implementation HXFRequest
+ (instancetype)requestWithParameters:(id)parameters {
    return [[self alloc]initWithParameters:parameters];
}

- (instancetype)initWithParameters:(id)parameters {
    self = [super init];
    if (self) {
        if ([parameters isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = (NSDictionary *)parameters;
            if (dict.allKeys.count > 0) {
                _parameters = [HXFCommonTool dictionaryMd5ResultWithDictionary:parameters];
            }else {
                
                _parameters = [HXFCommonTool dictionaryMd5ResultWithDictionary:@{@"def":[self generateRandomNumber]}];
            }
        }
        //
        //        _parameters = [parameters copy];
    }
    return self;
}

- (NSString *)requestUrl {
    return @"";
}

- (NSString *)method {
    return @"post";
}

- (VKRequestSerializeType)serializeType {
    return VKRequestSerializeTypeJSON;
}

- (NSTimeInterval)timeout {
    return 30.0;
}

- (NSUInteger)retryCount {
    return 0;
}

- (BOOL)validResponse:(id)responseObject {
    if (![responseObject isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    return [[responseObject objectForKey:@"code"] intValue] == 0;
}

- (id)jsonObjectFromResponseObject:(id)responseObject {
    return [responseObject objectForKey:@"data"];
}

- (id)parseJSON:(id)jsonObject {
    return jsonObject;
}
- (NSString *)generateRandomNumber {
    NSMutableString *mutableNum = [[NSMutableString alloc] init];
    for (NSInteger i = 0; i < 6; i ++) {
        NSString *string = [NSString stringWithFormat:@"%u",arc4random()%10];
        [mutableNum appendString:string];
    }
    return mutableNum;
}

@end
