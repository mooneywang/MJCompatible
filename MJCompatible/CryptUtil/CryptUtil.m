//
//  CryptUtil.m
//  NTTBankingApp
//
//  Created by user on 2014/10/28.
//  Copyright (c) 2014年 Okisoft. All rights reserved.
//

#import "CryptUtil.h"
#import <CommonCrypto/CommonCrypto.h>

/**
  暗号化関連のユーティリティクラスです。
  swiftだと鍵が不正な場合、Stringへの変換時にクラッシュするのでobjcで実装
 */
@implementation CryptUtil

/**
  指定の文字列をSHA-256でハッシュ化します。
 
  @param text ハッシュ化する文字列
  @return ハッシュ化した文字列
 */
+ (NSString *)sha256:(NSString *)text {
    
    if (text == nil) {
        return nil;
    }
    
    const char *s = [text cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(keyData.bytes, (CC_LONG)keyData.length, digest);
    NSData *out = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash = [out description];
    hash = [hash stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    return hash;
}

/**
  指定の文字列をAES-128(ECB/PKCS7Padding)で暗号化します。
 
  @param text 暗号化する文字列
  @param key 暗号化に使用する鍵
  @return 暗号化した文字列(Base64 Encode)
 */
+ (NSString *)encryptAES128:(NSString *)text key:(NSString *)key {
    
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    char *keyPtr = (char *)[keyData bytes];
    
    NSData *textData = [text dataUsingEncoding:NSUTF8StringEncoding];
    
    size_t bufferSize = [textData length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          nil,
                                          [textData bytes],
                                          [textData length],
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    free(buffer);
    
    return nil;
}

/**
  AES-128(ECB/PKCS7Padding)で暗号化された文字列を復号します。
 
  @param text 暗号化された文字列(Base64 Encode)
  @param key 復号に使用する鍵
  @return 復号した文字列 エラーの場合は空文字
 */
+ (NSString *)decryptAES128:(NSString *)text key:(NSString *)key {
    
    if (!text || !key) {
        // 文字列、鍵がnilの場合は空文字を返却する。(initWithBase64EncodedStringでcrashする。バグ?)
        return @"";
    }
    
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    char *keyPtr = (char *)[keyData bytes];
    
    NSData *textData = [[NSData alloc] initWithBase64EncodedString:text options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    size_t bufferSize = [textData length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          nil,
                                          [textData bytes],
                                          [textData length],
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    free(buffer);
    
    return nil;
}

/**
  Base64エンコードの文字列をBase64URLエンコードの文字列に変換します。
 
  @param text 変換する文字列(Base64 Encode)
  @return 変換した文字列(Base64URL Encode)
 */
+ (NSString *)encodeBase64Url:(NSString *)text {
    
    NSString *result = [text stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    result = [result stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    
    return result;
}

/**
  Base64URLエンコードの文字列をBase64エンコードの文字列に変換します。
 
  @param text 変換する文字列(Base64URL Encode)
  @return 変換した文字列(Base64 Encode)
 */
+ (NSString *)decodeBase64Url:(NSString *)text {
    
    NSString *result = [text stringByReplacingOccurrencesOfString:@"-" withString:@"+"];
    result = [result stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    
    return result;
}

@end
