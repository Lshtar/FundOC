//
//  HXFUserManager.h
//  HXFund
//
//  Created by D on 2019/5/29.
//  Copyright © 2019 D. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HXFUserManager : NSObject

@property (nonatomic, strong) NSString *token;

@property (nonatomic, strong) NSString *dynamicToken;

@property (nonatomic, strong) NSString *mobile;

+ (HXFUserManager* )shareManager;

- (BOOL)isLogin;

- (void)clear;

@end

NS_ASSUME_NONNULL_END
