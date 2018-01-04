//
//  StoreViewController.m
//  LoveShop
//
//  Created by 景睦科技 on 2017/9/21.
//  Copyright © 2017年 景睦科技. All rights reserved.
//
// <WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
#import "StoreViewController.h"

@interface StoreViewController ()<UIWebViewDelegate>

//@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, assign) BOOL      checkLoading;

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatusBarBackgroundColor:[UIColor colorWithHexString:@"ff5301"]];
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREENH_HEIGHT - 20)];
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    NSURL *url = [NSURL URLWithString:Fenlei_URL];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建
    [self.webView loadRequest:request];//加载
    
//    //    WKWebView
//    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
//    
//    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREENH_HEIGHT - 20) configuration:configuration];
//    // 创建URL
//    NSURL *url = [NSURL URLWithString:Fenlei_URL];
//    // 创建Request
//    NSURLRequest *request =[NSURLRequest requestWithURL:url];
//    // 加载网页
//    [self.webView loadRequest:request];
//    
//    self.webView.UIDelegate = self;
//    
//    self.webView.navigationDelegate = self;
//    
//    [self.view addSubview:self.webView];
    
}

#pragma mark-----  设置状态栏颜色

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

#pragma mark   ==============产生随机订单号==============

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

#pragma mark  UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"33%@",request.URL.absoluteString);
    NSString *urlString = request.URL.absoluteString;
    // containsString
    if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/user/login"]) {
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = YES;
    }else if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/user/register"]){
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = YES;
        
    }else if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/cart/cartlist"]){
        NSLog(@"不包含");
        self.checkLoading = YES;
        [self.tabBarController setSelectedIndex:2];
        self.tabBarController.tabBar.hidden = YES;
        
    }else if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/mobile"]){
        
        [self.tabBarController setSelectedIndex:0];
        self.tabBarController.tabBar.hidden = NO;
        
    }else if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/mobile/about"]){
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = YES;
        
    }else if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/home"]){
        
        [self.tabBarController setSelectedIndex:3];
        self.tabBarController.tabBar.hidden = NO;
        
    }else if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/mobile/"]){
        
        [self.tabBarController setSelectedIndex:0];
        self.tabBarController.tabBar.hidden = NO;
        
    }else if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/mobile/glist"]){
        
        [self.tabBarController setSelectedIndex:1];
        self.tabBarController.tabBar.hidden = NO;
        
    }else if ([urlString containsString:@"item"]){
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = YES;
        
    }else {
        NSLog(@"包含");
        self.tabBarController.tabBar.hidden = NO;
    }
    return YES;
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
//    if (self.checkLoading) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//    }else{
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSLog(@"webViewDidStartLoad");
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"webViewDidFinishLoad");
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"错误：%@",error.localizedDescription);
    NSLog(@"didFailLoadWithError");
    
}


//#pragma mark - WKNavigationDelegate
//// 页面开始加载时调用
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
//    
//    if (self.checkLoading) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//    }else{
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    }
////    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    NSLog(@"didStartProvisionalNavigation");
//    
//}
//// 当内容开始返回时调用
//- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
//    
//}
//// 页面加载完成之后调用
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    NSLog(@"didFinishNavigation");
//    
//}
//// 页面加载失败时调用
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
//    
//}
//// 接收到服务器跳转请求之后调用
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
//    
//    NSLog(@"didReceiveServerRedirectForProvisionalNavigation");
//}
//// 在收到响应后，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
//    
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    
//    //允许跳转
//    decisionHandler(WKNavigationResponsePolicyAllow);
//    //不允许跳转
//    //decisionHandler(WKNavigationResponsePolicyCancel);
//}
//// 在发送请求之前，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//    
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    NSLog(@"33%@",navigationAction.request.URL.absoluteString);
//    NSString *urlString = navigationAction.request.URL.absoluteString;
//    // containsString
//    if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/user/login"]) {
//        NSLog(@"包含");
//        self.checkLoading = YES;
//        self.tabBarController.tabBar.hidden = YES;
//    }else if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/user/register"]){
//        NSLog(@"包含");
//        self.checkLoading = YES;
//        self.tabBarController.tabBar.hidden = YES;
//        
//    }else if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/cart/cartlist"]){
//        NSLog(@"不包含");
//        self.checkLoading = YES;
//        [self.tabBarController setSelectedIndex:2];
//        self.tabBarController.tabBar.hidden = YES;
//        
//    }else if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/mobile"]){
//        
//        [self.tabBarController setSelectedIndex:0];
//        self.tabBarController.tabBar.hidden = NO;
//        
//    }else if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/mobile/about"]){
//        NSLog(@"包含");
//        self.checkLoading = YES;
//        self.tabBarController.tabBar.hidden = YES;
//        
//    }else if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/home/"]){
//        
//        [self.tabBarController setSelectedIndex:3];
//        self.tabBarController.tabBar.hidden = NO;
//        
//    }else if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/mobile/"]){
//        
//        [self.tabBarController setSelectedIndex:0];
//        self.tabBarController.tabBar.hidden = NO;
//        
//    }else if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/mobile/glist"]){
//        
//        [self.tabBarController setSelectedIndex:1];
//        self.tabBarController.tabBar.hidden = NO;
//        
//    }else if ([urlString containsString:@"item"]){
//        NSLog(@"包含");
//        self.checkLoading = YES;
//        self.tabBarController.tabBar.hidden = YES;
//        
//    }
////    else if ([urlString containsString:@"alipay"]){
////
////        self.checkLoading = YES;
////        [MBProgressHUD hideHUDForView:self.view animated:YES];
////
////        if ([urlString containsString:@"alipayapi.php?"]) {
////
////            NSDictionary *strDic = [AppTools dictionaryWithUrlString:urlString];
////            NSLog(@"订单号 金额 %@",strDic);
////            NSString *appScheme = @"cmalipay";
////            Order *order = [[Order alloc] init];
////            order.partner = PARTNER;
////            order.sellerID = SELLER;
////            order.outTradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
////            order.subject = [strDic objectForKey:@"out_trade_no"]; //商品标题
////            order.totalFee = [strDic objectForKey:@"total_fee"]; //商品价格
////            NSString *orderSpec = [order description];
////            NSLog(@"orderSpec = %@",orderSpec);
////
////            //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
////            id<DataSigner> signer = CreateRSADataSigner(RSA_PRIVATE);
////            NSString *signedString = [signer signString:orderSpec];
////            NSLog(@"1111: %@",signedString);
////            //将签名成功字符串格式化为订单字符串,请严格按照该格式
////            NSString *orderString = nil;
////            if (signedString != nil) {
////                orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
////                               orderSpec, signedString, @"RSA"];
////
////                [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
////                    NSLog(@"reslut3 = %@",resultDic);
////                }];
////            }
////        }
////    }
//    else {
//        NSLog(@"包含");
//        self.tabBarController.tabBar.hidden = NO;
//    }
//    
//    //允许跳转
//    decisionHandler(WKNavigationActionPolicyAllow);
//    //不允许跳转
//    //decisionHandler(WKNavigationActionPolicyCancel);
//}
//
//#pragma mark -- WKScriptMessageHandler
//- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
//{
//    //JS调用OC方法
//    //message.boby就是JS里传过来的参数
//    NSLog(@"body:%@",message.body);
//    
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
