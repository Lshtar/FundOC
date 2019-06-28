//
//  HXFUserManager.m
//  HXFund
//
//  Created by D on 2019/5/29.
//  Copyright © 2019 D. All rights reserved.
//

#import "HXFUserManager.h"

@implementation HXFUserManager (private)

#pragma mark - StoreDefaults
- (void)storeData:(NSString *)data forKey:(NSString *)key {
    
    NSUserDefaults *defults = [NSUserDefaults standardUserDefaults];
    [defults setObject:data forKey:key];
    [defults synchronize];
}

- (id)dataForKey:(NSString *)key {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:key];
    return data;
}

- (void)removeDataForKey:(NSString *)key {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

@end

@implementation HXFUserManager
{
    NSString *aToken;
    NSString *aDynamicToken;
    NSString *mobile;
}


+ (HXFUserManager *)shareManager
{
    static HXFUserManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self startMethod];
    }
    return self;
}

- (void)startMethod
{
    self.token = [self dataForKey:@"token"] ? : @"";
}

- (BOOL)isLogin
{
    return self.token.length>0 ? YES : NO;
}

- (void)clear
{
    [self removeDataForKey:@"token"];
    [self removeDataForKey:@"dynamicToken"];
}

- (void)setToken:(NSString *)token
{
    aToken = token;
    [self storeData:token forKey:@"token"];
}

- (NSString *)token
{
    aToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if (aToken.length > 0) {
        return aToken;
    }
    return @"";
}


- (void)setDynamicToken:(NSString *)dynamicToken
{
    //    做3desc加密。 35ac70iop96a15bb085fp48f
    
    NSString *encryption = [HXFCommonTool EncryptThreeTDES:dynamicToken];
    aDynamicToken = encryption;
    [self storeData:encryption forKey:@"dynamicToken"];
}

- (NSString *)dynamicToken
{
    
    
    NSString *locationDtoken = [[NSUserDefaults standardUserDefaults] objectForKey:@"dynamicToken"];
    //做3desc加密
    if (locationDtoken.length > 0)
    {
        NSString *decryption = [HXFCommonTool DecEncryptThreeTDES:locationDtoken];
        aDynamicToken = decryption;
        return aDynamicToken;
    }
    return @"";
}

- (void)setMobile:(NSString *)mobile
{
    mobile = mobile;
    [self storeData:mobile forKey:@"mobile"];
}

- (NSString *)mobile
{
    mobile = [[NSUserDefaults standardUserDefaults] objectForKey:@"mobile"];
    if (mobile.length > 0) {
        return mobile;
    }
    return @"";
}

@end
