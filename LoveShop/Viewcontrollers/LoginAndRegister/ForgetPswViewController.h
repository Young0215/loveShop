//
//  ForgetPswViewController.h
//  LoveShop
//
//  Created by 景睦科技 on 2017/10/20.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PageTypeForgetPassword  = 1,
    PageTypeModifyPassword  = 2,
} PageType;

@interface ForgetPswViewController : UIViewController

@property (nonatomic, assign) PageType pageType;

- (id)initWithPageType:(PageType)pageType;

@end
