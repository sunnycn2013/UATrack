//
//  UAUtil.h
//  UniqueArchitecture
//
//  Created by cc on 15/6/5.
//  Copyright (c) 2015年 summer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    UANotReachable = 0,
    UAReachableViaWiFi,
    UAReachableVia4G,
    UAReachableVia3G,
    UAReachableVia2G
} UANetworkStatus;

@interface UATrackUtil : NSObject

/**
 *  设备类型 5 5s 6 6+ X86_64
 *
 *  @return deviceType
 */
+ (NSString *)getDeviceType;

+ (NSString *)getDeviceModel;
+ (NSString *)getDeviceName;

+ (NSString *)getDModel;


/**
 *  获取网络类型 wifi 4G 3G 2G
 *
 *  @return networkType
 */
+ (NSString *)getNetWorkType;


/**
 *  操作系统版本 7.0 8.1
 *
 *  @return opernate version
 */
+ (NSString *)getOSVersion;

/**
 *  获取当前客户端版本号 1.0 1.1 2.1
 *
 *  @return client version
 */
+ (NSString *)getClientVersion;

/**
 *  获取当前设备build号
 *
 *  @return build
 */
+ (NSString *)getClientBuild;

/**
 *  获取当前设备的实际尺寸大小
 *
 *  @return screen size
 */
+ (NSString *)getScreenSize;

/**
 *  获取当前的设备的AdvertisingIdentifier 
 *
 *  @return AdvertisingIdentifier
 */
+ (NSString *)getAdvertisingIdentifier;

+ (NSString *)getOpenUDID;
/**
 *  MD5校验函数
 *
 *  @param str 校验串
 *  @param key 校验key
 *
 *  @return sign
 */
+ (NSString *)md5:(NSString *)str withKey:(NSString *)key;

/**
 *  字典转字符串
 *
 *  @param obj 传入Dictionary类型
 *
 *  @return 返回一个json字符串
 */
+ (NSString *)stringFromDic:(NSObject *)obj;

+ (NSDictionary *)dictionaryFromJson:(NSString *)obj;

+ (NSString *)machineName;
+ (NSString *)getSimInfo;



@end
