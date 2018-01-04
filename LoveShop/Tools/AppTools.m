//
//  AppTools.m
//  LoveShop
//
//  Created by 景睦科技 on 2017/9/21.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import "AppTools.h"

@implementation AppTools

/**
 验证手机号码
 */
+(BOOL) isValidateMobile:(NSString *)mobile
{
    if(mobile == nil || mobile.length == 0)
        return NO;
    
    NSString * MOBILE = @"^1[34578]\\d{9}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if ([regextestmobile evaluateWithObject:mobile] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    //    return [phoneTest evaluateWithObject:mobile];
}

/**
 验证身份证号
 */
+ (BOOL) validateIdentityCard: (NSString *)value
{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([value length] != 18) {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:value]) {
        return NO;
    }
    int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6
    + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
    
}

/**
 不带延迟的提示框
 */

+ (void)showString:(NSString*)format,...
{
    if (format == nil) {
        return;
    }
    
    va_list args;
    va_start(args,format);
    NSString *string = [[NSString alloc] initWithFormat:format arguments:args] ;
    va_end(args);
    
    
    //取得window，及window的宽高
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    CGFloat windowWidth = window.frame.size.width;
    //CGFloat windowHeight = window.frame.size.height;
    
    //获取传入的字符串占用的大小，最大宽度为window宽度减120，120为字符边距和view边距总和
    UIFont *font = [UIFont boldSystemFontOfSize:16];
    CGRect frame = [string boundingRectWithSize:CGSizeMake(windowWidth-120, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    
    //创建一个label容纳字符串
    frame.origin.x += 30;
    frame.origin.y += 10;
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = string;
    label.textColor = [UIColor grayColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = font;
    
    //显示不下时自动缩小字体
    label.numberOfLines = 15;
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumScaleFactor = 0.8;
    label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    
    //创建一个view容纳label
    frame.size.width += 60;
    //    frame.origin.x = (windowWidth-frame.size.width)/2;
    //    frame.origin.y = windowHeight/3;
    frame.size.height += 20;
    UIView *view =  [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor lightGrayColor];
    view.layer.cornerRadius = 5.0f;
    view.layer.masksToBounds = YES;
    view.alpha = 1.0;
    
    //label加入view
    [view addSubview:label];
    
    view.center = window.center;
    //view加入window
    [window addSubview:view];
    
    //持续显示1.2s以后，以持续时间0.8s的动画方式变淡消失
    [UIView animateWithDuration:0.5 delay:1.2 options:0 animations:^{
        view.alpha = 0;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
    
}

/**
 带延迟的提示框
 */

+(void)showStringWithTime:(NSTimeInterval)delayTime string:(NSString *)format, ...{
    if (format == nil) {
        return;
    }
    
    va_list args;
    va_start(args,format);
    NSString *string = [[NSString alloc] initWithFormat:format arguments:args] ;
    va_end(args);
    
    
    //取得window，及window的宽高
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    CGFloat windowWidth = window.frame.size.width;
    //CGFloat windowHeight = window.frame.size.height;
    
    //获取传入的字符串占用的大小，最大宽度为window宽度减120，120为字符边距和view边距总和
    UIFont *font = [UIFont boldSystemFontOfSize:16];
    CGRect frame = [string boundingRectWithSize:CGSizeMake(windowWidth-120, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    
    //创建一个label容纳字符串
    frame.origin.x += 30;
    frame.origin.y += 10;
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = string;
    label.textColor = [UIColor grayColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = font;
    
    //显示不下时自动缩小字体
    label.adjustsFontSizeToFitWidth = YES;
    label.numberOfLines = 15;
    label.minimumScaleFactor = 0.8;
    label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    
    //创建一个view容纳label
    frame.size.width += 60;
    //    frame.origin.x = (windowWidth-frame.size.width)/2;
    //    frame.origin.y = windowHeight/3;
    frame.size.height += 20;
    UIView *view =  [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor lightGrayColor];
    view.layer.cornerRadius = 5.0f;
    view.layer.masksToBounds = YES;
    view.alpha = 1.0;
    
    //label加入view
    [view addSubview:label];
    
    view.center = window.center;
    //view加入window
    [window addSubview:view];
    
    //持续显示1.2s以后，以持续时间0.8s的动画方式变淡消失
    [UIView animateWithDuration:0.5 delay:delayTime options:0 animations:^{
        view.alpha = 0;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
}

/**
 验证手机登录状态
 */
+(BOOL) isUserLogin {
    
    NSString *userId =  [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_ID"];
    
    if (userId != nil && [userId intValue] > 0)
    {
        //已经登录
        return YES;
    }
    return NO;
    
}

/**
 截取URL 获取订单信息 和支付金额
 */

+ (NSDictionary *)dictionaryWithUrlString:(NSString *)urlStr
{
    if (urlStr && urlStr.length && [urlStr rangeOfString:@"?"].length == 1) {
        NSArray *array = [urlStr componentsSeparatedByString:@"?"];
        if (array && array.count == 2) {
            NSString *paramsStr = array[1];
            if (paramsStr.length) {
                NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
                NSArray *paramArray = [paramsStr componentsSeparatedByString:@"&"];
                for (NSString *param in paramArray) {
                    if (param && param.length) {
                        NSArray *parArr = [param componentsSeparatedByString:@"="];
                        if (parArr.count == 2) {
                            [paramsDict setObject:parArr[1] forKey:parArr[0]];
                        }
                    }
                }
                return paramsDict;
            }else{
                return nil;
            }
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}

/**
 银行卡号加密
 */
+(NSString *)bankCardAddEncrypt:(NSString *)string {
    
    // 转换成可变字符串
    NSMutableString *stringM = [NSMutableString stringWithFormat:@"%@",string];
    
    NSRange range = {6,stringM.length -6};
    
    [stringM deleteCharactersInRange:range];
    
    [stringM appendString:@"********"];//个数根据银行卡号长度规则而定
    
    NSMutableString *endString = [NSMutableString stringWithFormat:@"%@",string];
    
    NSRange endRange = {0,stringM.length};
    
    [endString deleteCharactersInRange:endRange];
    
    [stringM appendString:endString];
    
    NSLog(@"银行卡号：%@",stringM);
    return stringM;
    
}

/**
 身份证号加密
 */
+(NSString *)identityCardAddEncrypt:(NSString *)string {
    
    // 转换成可变字符串
    NSMutableString *stringM = [NSMutableString stringWithFormat:@"%@",string];
    
    NSRange range = {3,stringM.length -3};
    
    [stringM deleteCharactersInRange:range];
    
    [stringM appendString:@"***********"];//个数根据银行卡号长度规则而定
    
    NSMutableString *endString = [NSMutableString stringWithFormat:@"%@",string];
    
    NSRange endRange = {0,stringM.length};
    
    [endString deleteCharactersInRange:endRange];
    
    [stringM appendString:endString];
    
    NSLog(@"身份证号:%@",stringM);
    return stringM;
}

/**
 获取手机型号
 */

+ (NSString *)getIphoneModel {
    
    NSString *phoneModel = [[UIDevice currentDevice] deviceModel];
    NSLog(@"设备:%@",phoneModel);
    if ([phoneModel isEqualToString:@"iPhone SE"]) {
        phoneModel = @"iPhone SE";
        return phoneModel;
    }else if ([phoneModel isEqualToString:@"iPhone 6"]) {
        phoneModel = @"iPhone 6";
        return phoneModel;
    }else if ([phoneModel isEqualToString:@"iPhone 6S"]) {
        phoneModel = @"iPhone 6S";
        return phoneModel;
    }else if ([phoneModel isEqualToString:@"iPhone 6 Plus"]) {
        phoneModel = @"iPhone 6 Plus";
        return phoneModel;
    }else if ([phoneModel isEqualToString:@"iPhone 6S Plus"]) {
        phoneModel = @"iPhone 6S Plus";
        return phoneModel;
    }else if ([phoneModel isEqualToString:@"iPhone 7 Plus"]) {
        phoneModel = @"iPhone 7 Plus";
        return phoneModel;
    }else if ([phoneModel isEqualToString:@"iPhone 7"]) {
        phoneModel = @"iPhone 7";
        return phoneModel;
    }else {
        return phoneModel;
    }
    
}



@end
