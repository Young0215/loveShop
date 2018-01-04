//
//  AppDelegate.m
//  LoveShop
//
//  Created by 景睦科技 on 2017/9/21.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "StoreViewController.h"
#import "CartViewController.h"
#import "MyViewController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [NSThread sleepForTimeInterval:1];
    
    [self congigVender];
    
    [self addTabBarController];
    
    [self handleShowGuideView];
    
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMKEY];
    
    [self registerUMKey];
    
    return YES;
}

-(void)handleShowGuideView {
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        [self helpScroll];
        
    }else{
        
        [[UIApplication sharedApplication] setStatusBarHidden:NO];

    }
}

/** 注册平台 */
- (void)registerUMKey{
    
    
    /* 微信 */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAPPKEY appSecret:WXAppSecret redirectURL:@"http://mobile.umeng.com/social"];
    
    /*QQ*/
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAPPKEY/*设置QQ平台的appID*/  appSecret:QQAppSecret redirectURL:@"http://mobile.umeng.com/social"];
    
    /*
     注**
     redirectURL必须要和微博设置的回调一致
     */
    
    /* 新浪 */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:WBAPPKEY  appSecret:WBAppSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
}

- (void)congigVender
{
    //IQKeyboardManager
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    
}

- (void)addTabBarController
{
    //  tabBar控制器
    
    UITabBarController *customerTB = [[UITabBarController alloc] init];
    customerTB.delegate = self;
    self.window.rootViewController = customerTB;
    [self.window makeKeyAndVisible];
    
    HomeViewController *home = [[HomeViewController alloc] init];
    home.tabBarItem.title = @"首页";
    home.tabBarItem.image = [UIImage imageNamed:@"home"];
    home.tabBarItem.selectedImage = [UIImage imageNamed:@"home_selected"];
//    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:home];
    
    StoreViewController *store = [[StoreViewController alloc] init];
    store.tabBarItem.title = @"分类";
    store.tabBarItem.image = [UIImage imageNamed:@"store"];
    store.tabBarItem.selectedImage = [UIImage imageNamed:@"store_selected"];
//    UINavigationController *storeNav = [[UINavigationController alloc] initWithRootViewController:store];
    
    CartViewController *cart = [[CartViewController alloc] init];
    cart.tabBarItem.title = @"购物车";
    cart.tabBarItem.image = [UIImage imageNamed:@"cart"];//
    cart.tabBarItem.selectedImage = [UIImage imageNamed:@"cart_selected"];
//    UINavigationController *cartNav = [[UINavigationController alloc] initWithRootViewController:cart];
    
    MyViewController *my = [[MyViewController alloc] init];
    my.tabBarItem.title = @"我的";
    my.tabBarItem.image = [UIImage imageNamed:@"my"];
    my.tabBarItem.selectedImage = [UIImage imageNamed:@"my_selected"];
    [[UITabBar appearance] setTintColor:[UIColor colorWithHexString:@"ff5301"]];
//    UINavigationController *myNav = [[UINavigationController alloc] initWithRootViewController:my];
    
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:@"ff5301"]];
//    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                          [UIColor whiteColor],NSForegroundColorAttributeName,
//                                                          [UIFont systemFontOfSize:16], NSFontAttributeName, nil]];
    
    customerTB.viewControllers = @[home,store,cart,my];
    
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result1 = %@",resultDic);
            }];
        }
    }
    return result;
    
//    return YES;
    
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result2 = %@",resultDic);
        }];
    }
    return YES;
}

#pragma mark -- Guide

-(UIButton*)buttonPhoto:(NSString*)photo hilPhoto:(NSString*)Hphoto rect:(CGRect)rect  title:(NSString*)title select:(SEL)sel Tag:(int)tag View:(UIView*)ViewA textColor:(UIColor*)textcolor{
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    [button setBackgroundImage:[UIImage imageNamed:Hphoto] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:photo] forState:UIControlStateHighlighted];
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    button.tag=tag;
    [button setTitleColor:textcolor forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor clearColor]];
    [ViewA addSubview:button];
    return button;
}
-(UIImageView*)addSubviewImage:(NSString*)imageName  rect:(CGRect)rect{
    UIImageView*view=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    view.frame=rect;
    view.backgroundColor = [UIColor clearColor];
    return view;
}
-(void)helpScroll{
    
    scrVl=[[UIScrollView alloc] init];
    scrVl.pagingEnabled = YES;
    scrVl.delegate=self;
    scrVl.frame=CGRectMake(0, 0,SCREEN_WIDTH, SCREENH_HEIGHT);
    scrVl.bounces = NO;
    scrVl.contentSize=CGSizeMake(SCREEN_WIDTH*3, SCREENH_HEIGHT);
    [scrVl setShowsHorizontalScrollIndicator:NO];
    [scrVl setBackgroundColor:[UIColor clearColor]];
    [self.window addSubview:scrVl];
    
    for (int i=0; i<3; i++) {
        NSString *phoneModel = [[UIDevice currentDevice] deviceModel];
        NSLog(@"手机模型：%@",phoneModel);
        if ([phoneModel isEqualToString:@"iPhone 6"] || [phoneModel isEqualToString:@"iPhone 7"] || [phoneModel isEqualToString:@"iPhone 8"] || [phoneModel isEqualToString:@"iPhone 6S"]) {
            [scrVl addSubview:[self addSubviewImage:[NSString stringWithFormat:@"%d2",i+1] rect:CGRectMake(SCREEN_WIDTH*i, 0,SCREEN_WIDTH ,SCREENH_HEIGHT)]];
        }else if ([phoneModel isEqualToString:@"iPhone 6 Plus"] || [phoneModel isEqualToString:@"iPhone 7 Plus"] || [phoneModel isEqualToString:@"iPhone 8 Plus"] || [phoneModel isEqualToString:@"iPhone 6S Plus"]){
            
            [scrVl addSubview:[self addSubviewImage:[NSString stringWithFormat:@"%d3",i+1] rect:CGRectMake(SCREEN_WIDTH*i, 0,SCREEN_WIDTH ,SCREENH_HEIGHT)]];
        }else if ([phoneModel isEqualToString:@"iPhone 5"] || [phoneModel isEqualToString:@"iPhone 5S"] || [phoneModel isEqualToString:@"iPhone 5C"] || [phoneModel isEqualToString:@"iPhone SE"]){
            
            [scrVl addSubview:[self addSubviewImage:[NSString stringWithFormat:@"%d1",i+1] rect:CGRectMake(SCREEN_WIDTH*i, 0,SCREEN_WIDTH ,SCREENH_HEIGHT)]];
        }else{
            // iphone X
            [scrVl addSubview:[self addSubviewImage:[NSString stringWithFormat:@"%d2",i+1] rect:CGRectMake(SCREEN_WIDTH*i, 0,SCREEN_WIDTH ,SCREENH_HEIGHT)]];
        }
        
    }
    
    [self buttonPhoto:nil hilPhoto:nil rect:CGRectMake(SCREEN_WIDTH * 2 + (SCREEN_WIDTH - 200)/2 - 10, SCREENH_HEIGHT - 36 - 125, 200 , 36) title:nil select:@selector(hiddenScroller:) Tag:1 View:scrVl textColor:[UIColor clearColor]];
    
//    thePGLeft=[[PageControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 90)/2, self.window.frame.size.height - 20 - 30, 90, 20)];
//    
//    thePGLeft.dotColorCurrentPage=[UIColor redColor];
//    
//    thePGLeft.center=CGPointMake(160,50);
//    
//    thePGLeft.numberOfPages=3;
//    [self.window addSubview:thePGLeft];
    
}
-(void)hiddenScroller:(id)sender
{
//    NSLog(@"点击了");

    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         scrVl.alpha = 0.0;
//                         thePGLeft.alpha=0.0;
                     }
                     completion:^(BOOL finished){
                         
                         [scrVl removeFromSuperview];
//                         [thePGLeft removeFromSuperview];
                         
                     }
     ];
}


#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    CGPoint offset = scrollView.contentOffset;
//    CGRect bounds = scrollView.frame;
//    [thePGLeft setCurrentPage:offset.x / bounds.size.width];
    
}

#pragma mark -- UIApplicationDelegate


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
