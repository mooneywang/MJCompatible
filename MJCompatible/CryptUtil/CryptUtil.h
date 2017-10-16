//
//  CryptUtil.h
//  NTTBankingApp
//
//  Created by user on 2014/10/28.
//  Copyright (c) 2014年 Okisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CryptUtil : NSObject
+ (NSString *)sha256:(NSString *)text;
+ (NSString *)encryptAES128:(NSString *)text key:(NSString *)key;
+ (NSString *)decryptAES128:(NSString *)text key:(NSString *)key;
+ (NSString *)encodeBase64Url:(NSString *)text;
+ (NSString *)decodeBase64Url:(NSString *)text;
@end
