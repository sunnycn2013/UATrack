//
//  UAUtil.m
//  UniqueArchitecture
//
//  Created by cc on 15/6/5.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import "UATrackUtil.h"
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>
#import <CommonCrypto/CommonDigest.h>
#import "UATrackDevice+machine.h"
#import "UAtrackHeader.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "OpenUDID.h"
#import "Reachability.h"

@implementation UATrackUtil

+ (NSString *)getDeviceType{
    return @"";
}


+ (NSString *)getOSVersion
{
    return [UIDevice currentDevice].systemVersion;
}

+ (NSString *)getDModel
{
    return @"";//[[UIDevice currentDevice] machine];
}

+ (NSString *)getDeviceName
{
    return [UIDevice currentDevice].name;
}

+ (NSString *)getDeviceModel
{
    return [UIDevice currentDevice].model;
}

+ (NSString *)getClientVersion
{
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    if (nil == version) {
        version = @"1.0";
    }
    return version;
}

+ (NSString *)getClientBuild{
    NSString *build = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    if (nil == build) {
        build = @"1";
    }
    return build;
}

+ (NSString *)getAdvertisingIdentifier
{
    NSString *idfa = @"";
    if (idfa) {
        idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    return idfa;
}

+ (NSString *)getOpenUDID
{
    NSString *openUDID = @"";
    openUDID = [OpenUDID value];
    return openUDID;
}

+ (NSString *)getNetWorkType
{
    Reachability *reachablity = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    UANetworkStatus status = (int)[reachablity currentReachabilityStatus];
    
    switch (status) {
        case UAReachableViaWiFi:
            return @"WIFI";
            break;
        case UAReachableVia4G:
            return @"4G";
            break;
        case UAReachableVia3G:
            return @"3G";
            break;
        case UAReachableVia2G:
            return @"2G";
            break;
        default:
            return @"";
    }
    
    return @"";
}

+ (NSString *)getScreenSize
{
    int width = [[UIScreen mainScreen] currentMode].size.width;
    int height = [[UIScreen mainScreen] currentMode].size.height;
    return [NSString stringWithFormat:@"%d*%d",width, height];
}

//md5 32位 加密
+ (NSString *)md5:(NSString *)str withKey:(NSString *)key
{
    const char *cStr = [[NSString stringWithFormat:@"%@%@", str, key] UTF8String];
    unsigned char result[16];
    
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],result[1],result[2],result[3],
            result[4],result[5],result[6],result[7],
            result[8],result[9],result[10],result[11],
            result[12],result[13],result[14],result[15]];
}

+ (NSString *)stringFromDic:(NSObject *)obj
{
    if ([NSJSONSerialization isValidJSONObject:obj]) {
        NSError *error;
        NSData *registerData = [NSJSONSerialization dataWithJSONObject:obj options:0 error:&error];
        if (nil == registerData) {
            NSLog(@"Json encode error: %@", error);
            return nil;
        }
        return [[NSString alloc] initWithData:registerData encoding:NSUTF8StringEncoding];
    }
    return nil;
}

+ (NSDictionary *)dictionaryFromJson:(NSString *)obj
{
    if ([obj isKindOfClass:[NSString class]] && obj) {
        NSDictionary *dic = nil;
        NSError *error = nil;
        NSData *data = [obj dataUsingEncoding:NSUTF8StringEncoding];
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        if (!dic) {
            DBLog(@"json obj failed..");
        }
        return dic;
    }
    return nil;
}


+ (NSString *)machineName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *name = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    
    if (name == nil)
    {
        return @"";
    }
    else if ([name isEqualToString:@"x86_64"] || [name isEqualToString:@"i386"])
    {
        return @"iPhone Simultator";
    }
    
    return name;
}

+ (NSString *)getSimInfo
{
    CTTelephonyNetworkInfo *info =[[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    
    NSString *mcc = [carrier mobileCountryCode];
    NSString *mnc = [carrier mobileNetworkCode];
    
    
    if (mnc ==nil || mnc.length<1) {
        
        return @"";
    }
    
    NSString * simStr = [NSString stringWithFormat:@"%@%@",mcc,mnc];
    
    return simStr;
}


@end
