//
//  YJWCleanCache.h
//  LoveShop
//
//  Created by 景睦科技 on 2017/9/21.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^cleanCacheBlock)();

@interface YJWCleanCache : NSObject

/**
 *  清理缓存
 */
+(void)cleanCache:(cleanCacheBlock)block;

/**
 *  整个缓存目录的大小
 */
+(float)folderSizeAtPath;

@end
