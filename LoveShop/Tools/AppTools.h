//
//  AppTools.h
//  LoveShop
//
//  Created by 景睦科技 on 2017/9/21.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppTools : NSObject

/**
 验证手机号码格式
 */
+(BOOL) isValidateMobile:(NSString *)mobile;

/**
 验证身份证号格式
 */
+ (BOOL)validateIdentityCard: (NSString *)identityCard;


/**
 提示框
 */
+ (void)showString:(NSString*)string, ...;

+ (void)showStringWithTime:(NSTimeInterval)delayTime string:(NSString*)string, ...;

/**
 截取URL 获取订单信息 和支付金额
 */

+ (NSDictionary *)dictionaryWithUrlString:(NSString *)urlStr;

/**
 验证手机登录状态
 */
+(BOOL) isUserLogin;

/**
 银行卡号加密
 */

+ (NSString *)bankCardAddEncrypt:(NSString *)string;

/**
 身份证号加密
 */
+(NSString *)identityCardAddEncrypt:(NSString *)string;

/**
 获取手机型号
 */

+ (NSString *)getIphoneModel;

@end
