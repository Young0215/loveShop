//
//  MyViewController.m
//  LoveShop
//
//  Created by 景睦科技 on 2017/9/21.
//  Copyright © 2017年 景睦科技. All rights reserved.
//
// <WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

/** 屏幕的SIZE */
#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size
/** define:屏幕的宽高比 */
#define CURRENT_SIZE(_size) _size / 375.0 * SCREEN_SIZE.width


#import "MyViewController.h"
#import "ShareCollectionViewCell.h"
#import "ShareView.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
@interface MyViewController ()<UIWebViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource>

/** 分享 */
@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) ShareView * shareView;
@property (nonatomic, strong) ShareCollectionViewCell * shareCell;
@property (nonatomic, strong) NSArray * shareIconAry;


//@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, assign) BOOL      checkLoading;

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) JSContext *context;

@property (nonatomic, copy)   NSString  *thumbURL;

@property (nonatomic, strong) NSArray   *shareArray;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shareIconAry = @[@"朋友圈icon",@"微信ico",@"QQicon"];
//    self.shareArray = [NSArray array];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatusBarBackgroundColor:[UIColor colorWithHexString:@"ff5301"]];
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREENH_HEIGHT - 20)];
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    NSURL *url = [NSURL URLWithString:My_URL];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建
    [self.webView loadRequest:request];//加载
    
//    //    WKWebView
//    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
//    
//    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREENH_HEIGHT - 20) configuration:configuration];
//    // 创建URL
//    NSURL *url = [NSURL URLWithString:My_URL];
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
        return YES;
    }else if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/user/register"]){
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = YES;
        return YES;
    }else if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/cart/cartlist"]){
        NSLog(@"不包含");
        self.checkLoading = YES;
        [self.tabBarController setSelectedIndex:2];
        self.tabBarController.tabBar.hidden = YES;
        return YES;
    }else if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/mobile"]){
        
        [self.tabBarController setSelectedIndex:0];
        self.tabBarController.tabBar.hidden = NO;
        return YES;
    }else if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/mobile/about"]){
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = YES;
        return YES;
    }else if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/invite/cashout"]){
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = NO;
        return YES;
    }else if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/home/init"]){
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = NO;
        return YES;
    }else if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/mobile/"]){
        
        [self.tabBarController setSelectedIndex:0];
        self.tabBarController.tabBar.hidden = NO;
        return YES;
    }else if ([urlString containsString:@"delivery_list"]){ //
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = NO;
        return YES;
    }else if ([urlString containsString:@"usermodify"]){
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = NO;
        return YES;
    }else if ([urlString containsString:@"userbuylist"]){
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = NO;
        return YES;
    }else if ([urlString containsString:@"orderlist"]){
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = NO;
        return YES;
    }else if ([urlString containsString:@"singlelist"]){
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = NO;
        return YES;
    }else if ([urlString containsString:@"userbalance"]){
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = NO;
        return YES;
    }else if ([urlString containsString:@"invite"]){
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = NO;
        return YES;
    }else if ([urlString containsString:@"invite/friends"]){
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = NO;
        return YES;
    }else if ([urlString containsString:@"invite/cashout"]){
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = NO;
        return YES;
    }else if ([urlString containsString:@"invite/record"]){
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = NO;
        return YES;
    }else if ([urlString containsString:@"exchange_shop"]){
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = NO;
        return YES;
    }else if ([urlString containsString:@"profile_setting"]){
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = NO;
        return YES;
    }else if ([urlString containsString:@"password_setting"]){
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = NO;
        return YES;
    }else if ([urlString containsString:@"paymentpwd_setting"]){
        NSLog(@"包含");
        self.checkLoading = YES;
        self.tabBarController.tabBar.hidden = NO;
        return YES;
    }else {
        NSLog(@"包含");
        self.tabBarController.tabBar.hidden = NO;
        return YES;
    }
    
//    else if ([urlString containsString:@"http://www.agys1688.net/?/api/qqlogin/"]){
//        NSLog(@"包含");
//        self.checkLoading = YES;
//        self.tabBarController.tabBar.hidden = NO;
//        [self qqLoginClick];
//        return NO;
//
//    }
//    else if ([urlString containsString:@"http://www.agys1688.net/?/mobile/user/register/"]){
//        NSLog(@"包含");
//        self.checkLoading = YES;
//        self.tabBarController.tabBar.hidden = NO;
//        //        [self fenxiang];
//        return NO;
//    }
    
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
    __weak typeof(self) weakSelf = self;
    _context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    if (![QQApiInterface isQQInstalled]) {
        
        NSLog(@"没安装qq或qq空间");
    }else{
        _context[@"fenxiang"] = ^() {
            NSLog(@"+++++++Begin Log+++++++");
            NSArray *args = [JSContext currentArguments];
            weakSelf.shareArray = [NSArray arrayWithArray:args];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf fenxiang];
                
            });
            NSLog(@"分享: %@ %@", args,weakSelf.shareArray);
//        for (JSValue *jsVal in args) {
//            NSLog(@"分享: %@ %@", args,jsVal.toString);
//            weakSelf.shareArray = [NSArray arrayWithArray:args];
////            weakSelf.thumbURL = jsVal.toString;
//        }
            NSLog(@"-------End Log-------");
        };
    }
    if (![WXApi isWXAppInstalled]) {
        NSLog(@"没安装微信");
    }else{
        _context[@"fenxiang"] = ^() {
            NSLog(@"+++++++Begin Log+++++++");
            NSArray *args = [JSContext currentArguments];
            weakSelf.shareArray = [NSArray arrayWithArray:args];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf fenxiang];
                
            });
            NSLog(@"分享: %@ %@", args,weakSelf.shareArray);
//        for (JSValue *jsVal in args) {
//            NSLog(@"分享: %@ %@", args,jsVal.toString);
//            weakSelf.shareArray = [NSArray arrayWithArray:args];
////            weakSelf.thumbURL = jsVal.toString;
//        }
            NSLog(@"-------End Log-------");
        };
    }
    
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"错误：%@",error.localizedDescription);
    NSLog(@"didFailLoadWithError");
    
}

#pragma mark - share

- (void)fenxiang {
    
    NSLog(@"分享");
    
    self.shareView = [[ShareView alloc]initWithFrame:CGRectMake(0, SCREEN_SIZE.height-CURRENT_SIZE(130), SCREEN_SIZE.width, CURRENT_SIZE(130))];
    self.shareView.backgroundColor = [UIColor whiteColor];
    
    self.shareView.collection.delegate = self;
    self.shareView.collection.dataSource = self;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.shareView];
    
}

//- (void)tapOnBgView:(UITapGestureRecognizer *)recognizer {
//
//    NSLog(@"取消分享");
//    [self.shareView removeFromSuperview];
//
////    self.bgView.hidden = YES;
//
//}

#pragma mark -------------------- UICollectionViewDataSource --------------------

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.shareIconAry.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    self.shareCell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    //    [cell sizeToFit];
    
    self.shareCell.icon.image = [UIImage imageNamed:self.shareIconAry[indexPath.row]];
    
    return self.shareCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    
    switch (indexPath.row) {
        case 0:
            [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
            break;
        case 1:
            [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
            break;
        case 2:
            [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_QQ];
            break;
            
        default:
            break;
    }
}

#pragma mark -------------------- 分享 --------------------

//- (void) shareInfo:(UIButton *) sender{
//    NSLog(@"分享");
//    [self initShareView];
//}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSLog(@"分享内容:%@",self.shareArray);
    NSString *shareTitle = [NSString stringWithFormat:@"%@", [[self.shareArray objectAtIndex:1] toString]];
    NSString *shareDer = [NSString stringWithFormat:@"%@", [[self.shareArray objectAtIndex:2] toString]]; // ;
    NSURL    *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [[self.shareArray objectAtIndex:3] toString]]]; //
    UIImage  *imagea = [UIImage imageWithData: [NSData dataWithContentsOfURL:imageUrl]];
    NSLog(@"分享链接：%@  %@ %@",shareTitle,shareDer,imageUrl);
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:shareTitle descr:shareDer thumImage:imagea];
    //设置网页地址
    shareObject.webpageUrl = [[self.shareArray objectAtIndex:0] toString];// encodedString
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
            NSLog(@"分享失败");
            
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                NSLog(@"分享成功");
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
    
}

//#pragma mark - WKNavigationDelegate
//
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
//    }else if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/invite/cashout"]){
//        NSLog(@"包含");
//        self.checkLoading = YES;
//        self.tabBarController.tabBar.hidden = YES;
//        
//    }else if ([urlString isEqualToString:@"http://www.agys1688.net/?/mobile/mobile/"]){
//        
//        [self.tabBarController setSelectedIndex:0];
//        self.tabBarController.tabBar.hidden = NO;
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
