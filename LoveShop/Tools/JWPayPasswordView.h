//
//  JWPayPasswordView.h
//  LoveShop
//
//  Created by 景睦科技 on 2017/11/14.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#define  boxWidth (SCREEN_WIDTH -105)/6 //密码框的宽度

@class JWPayPasswordView;

@protocol JWPayPasswordViewDelegate <NSObject>

@optional

-(void)JWPayPasswordView:(JWPayPasswordView *)view WithPasswordString:(NSString *)Password;

@end

@interface JWPayPasswordView : UIView<UITextFieldDelegate>

@property (nonatomic,assign)id <JWPayPasswordViewDelegate>JWPayPasswordDelegate;

- (id)initWithFrame:(CGRect)frame WithTitle :(NSString *)title;

/// 标题
@property (nonatomic,)UILabel *lable_title;
///  TF
@property (nonatomic,)UITextField *TF;

///  假的输入框
@property (nonatomic,)UIView *view_box;
@property (nonatomic,)UIView *view_box2;
@property (nonatomic,)UIView *view_box3;
@property (nonatomic,)UIView *view_box4;
@property (nonatomic,)UIView *view_box5;
@property (nonatomic,)UIView *view_box6;

///   密码点
@property (nonatomic,)UILabel *lable_point;
@property (nonatomic,)UILabel *lable_point2;
@property (nonatomic,)UILabel *lable_point3;
@property (nonatomic,)UILabel *lable_point4;
@property (nonatomic,)UILabel *lable_point5;
@property (nonatomic,)UILabel *lable_point6;


@end
