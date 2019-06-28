//
//  HXFKeychain.m
//  HeXinFound
//
//  Created by lishaopeng on 2018/6/4.
//  Copyright © 2018年 Dusk. All rights reserved.
//

#import "HXFKeychain.h"
#import <Security/Security.h>
#import "KeychainItemWrapper.h"

#define keyChain_idenentify @"com.yuxi.HeXinFound"

@implementation HXFKeychain

+ (void)saveUUID:(NSString *)UUID
{
    if([HXFKeychain getUUID].length > 0)
    {
        return;
    }
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc]initWithIdentifier:keyChain_idenentify accessGroup:nil];
    [keychain setObject:UUID forKey:(__bridge id)kSecAttrLabel];
}

+ (NSString *)getUUID
{
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc]initWithIdentifier:keyChain_idenentify accessGroup:nil];

    NSString *uuidString = [keychain objectForKey:(__bridge id)kSecAttrLabel];
    return uuidString;
}

@end
