//
//  HXFKeychain.h
//  HeXinFound
//
//  Created by lishaopeng on 2018/6/4.
//  Copyright © 2018年 Dusk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXFKeychain : NSObject

+ (void)saveUUID:(NSString *)UUID;

+ (NSString *)getUUID;

@end
