//
//  LoginViewController.m
//  LoveShop
//
//  Created by 景睦科技 on 2017/9/21.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPswViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView       *backView;

@property (nonatomic, strong) UIView       *buttonView;

@property (nonatomic, strong) UITextField  *phoneTextField;

@property (nonatomic, strong) UITextField  *pswTextField;

@property (nonatomic, strong) UIButton     *loginBtn;

@property (nonatomic, assign) BOOL         checkboxChecked;

@property (nonatomic, strong) UIButton     *qqBtn;

@property (nonatomic, strong) UIButton     *weixinBtn;

@property (nonatomic, strong) UIButton     *xinlangBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.view.backgroundColor = bgColor;
    
    self.checkboxChecked = YES;
    
    [self setNavigationLeftItem];
    
    [self createTextFields];
    
    [self createLabel];
    
    [self createButtons];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.checkboxChecked = YES;
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
    
}

#pragma mark----- initUI

- (void)createTextFields {
    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(30, 30 + 64, SCREEN_WIDTH - 60, 110)];
    self.backView.backgroundColor = bgColor;//bgColor
    [self.view addSubview:self.backView];
    
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 60, 40)];
    phoneView.backgroundColor = [UIColor whiteColor];
    phoneView.layer.cornerRadius = 4.0;
    [self.backView addSubview:phoneView];
    
    UIView *pswView = [[UIView alloc] initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH - 60, 40)];
    pswView.backgroundColor = [UIColor whiteColor];
    pswView.layer.cornerRadius = 4.0;
    [self.backView addSubview:pswView];
    
    UIImageView *nameImg = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, 25, 25)];
    nameImg.image = [UIImage imageNamed:@"name"];
    [phoneView addSubview:nameImg];
    
    UIImageView *pswImg = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, 25, 25)];
    pswImg.image = [UIImage imageNamed:@"psw"];
    [pswView addSubview:pswImg];
    
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH - 100, 40)];
    self.phoneTextField.delegate = self;
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTextField.returnKeyType = UIReturnKeyDone;
    self.phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    self.phoneTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.phoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    self.phoneTextField.secureTextEntry = YES;//明文或密文
    self.phoneTextField.placeholder = @"请输入用户名";
    self.phoneTextField.font = [UIFont systemFontOfSize:14];
    [phoneView addSubview:self.phoneTextField];
    
    self.pswTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH - 100, 40)];
    self.pswTextField.delegate = self;
    self.pswTextField.keyboardType = UIKeyboardTypeDefault;
    self.pswTextField.returnKeyType = UIReturnKeyDone;
    self.pswTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pswTextField.leftViewMode = UITextFieldViewModeAlways;
    self.pswTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.pswTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.pswTextField.secureTextEntry = YES;//明文或密文
    self.pswTextField.placeholder = @"请输入密码";
    self.pswTextField.font = [UIFont systemFontOfSize:14];
    [pswView addSubview:self.pswTextField];
    
    
    self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(30, self.backView.frame.origin.y + self.backView.frame.size.height + 30, SCREEN_WIDTH - 60, 80)];
    self.buttonView.backgroundColor = bgColor;//bgColor
    [self.view addSubview:self.buttonView];
    
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH - 60, 40);
    [self.loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    [self.loginBtn setBackgroundColor:[UIColor colorWithHexString:@"ff5301"]];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.layer.cornerRadius = 4.0;
    [self.loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonView addSubview:self.loginBtn];
    
    UIButton *selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectedBtn.frame = CGRectMake(0, 50, 110, 30);
    selectedBtn.tag = 101;
    [selectedBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    selectedBtn.imageEdgeInsets = UIEdgeInsetsMake(5, -10, 5, 30);
    [selectedBtn setTitle:@"记住密码" forState:UIControlStateNormal];
    [selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    selectedBtn.titleEdgeInsets = UIEdgeInsetsMake(5, -20, 5, 0);
    selectedBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [selectedBtn addTarget:self action:@selector(rememberPsw:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonView addSubview:selectedBtn];
    
    UIButton *askBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    askBtn.frame = CGRectMake(self.buttonView.frame.size.width - 110, 50, 110, 30);
    [askBtn setImage:[UIImage imageNamed:@"ask"] forState:UIControlStateNormal];
    askBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 30, 5, 10);
    [askBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [askBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    askBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 40, 5, 0);
    askBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [askBtn addTarget:self action:@selector(forgetPsw:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonView addSubview:askBtn];
    
    
    UILabel  *registerLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, self.buttonView.frame.origin.y + self.buttonView.frame.size.height + 30, 200, 20)];
    registerLabel.text = @"还没有账号？那还不赶紧去";
    registerLabel.font = [UIFont systemFontOfSize:10];
    registerLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:registerLabel];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(250, self.buttonView.frame.origin.y + self.buttonView.frame.size.height + 30, 50, 20);
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [registerBtn setTitleColor:[UIColor colorWithHexString:@"ff5301"] forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [registerBtn addTarget:self action:@selector(registerBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    
}

- (void)createButtons {
    
    self.qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.qqBtn.frame = CGRectMake(30, self.buttonView.frame.origin.y + self.buttonView.frame.size.height + 140, 50, 50);
    self.qqBtn.layer.cornerRadius = 25;
    [self.qqBtn setBackgroundImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    [self.qqBtn addTarget:self action:@selector(onClickQQ:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.qqBtn];
    
    self.weixinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.weixinBtn.frame = CGRectMake((SCREEN_WIDTH - 60)/2 + 135, self.buttonView.frame.origin.y + self.buttonView.frame.size.height + 140, 50, 50);
    self.weixinBtn.layer.cornerRadius = 25;
    [self.weixinBtn setBackgroundImage:[UIImage imageNamed:@"weixing"] forState:UIControlStateNormal];
    [self.weixinBtn addTarget:self action:@selector(onClickWX:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.weixinBtn];
    
    
    self.xinlangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.xinlangBtn.frame = CGRectMake((SCREEN_WIDTH - 60)/2 , self.buttonView.frame.origin.y + self.buttonView.frame.size.height + 140, 50, 50);
    self.xinlangBtn.layer.cornerRadius = 25;
    [self.xinlangBtn setBackgroundImage:[UIImage imageNamed:@"weibo"] forState:UIControlStateNormal];
    [self.xinlangBtn addTarget:self action:@selector(onClickWX:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.xinlangBtn];
    
    
}

- (void)createLabel {
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-140)/2, self.buttonView.frame.origin.y + self.buttonView.frame.size.height + 80, 140, 30)];
    label.text=@"第三方登录";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:label];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(30, self.buttonView.frame.origin.y + self.buttonView.frame.size.height + 95, 100, 1)];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(240, self.buttonView.frame.origin.y + self.buttonView.frame.size.height + 95, 100, 1)];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView2];
    
}


#pragma mark----- UIButton


- (void)registerBtn:(UIButton *)sender {
    
    //注册
    RegisterViewController  *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:NO];
    
}


- (void)login:(UIButton *)sender {
    
    //登录
    NSLog(@"登录");
    [self.view endEditing:YES];
    [self.phoneTextField resignFirstResponder];
    [self.pswTextField resignFirstResponder];
    
    NSString *phone = self.phoneTextField.text;
    NSString *password = [self.pswTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (phone ==nil || phone.length == 0) {
        [AppTools showString:@"手机号不能为空"];
        return ;
    }
    
    if (phone.length < 11 || phone.length > 11) {
        [AppTools showString:@"请输入正确的手机号码."];
        return ;
    }
    
    if (![AppTools isValidateMobile:phone]) {
        [AppTools showString:@"请输入正确的手机号码."];
        return ;
    }
    
    if (password == nil || password.length == 0 ) {
        [AppTools showString:@"密码不能为空."];
        return;
    }
    
    if(password.length < 6 || password.length > 16 )
    {
        [AppTools showString:@"密码长度有误，密码为6-16个字符."];
        return;
    }
    
    //登录接口调用方法
    
    
}

- (void)onClickQQ:(UIButton *)button{
    
    //QQ登录
    NSLog(@"QQ登录");
    
}

- (void)onClickWX:(UIButton *)button{
    
    //微信登录
    NSLog(@"微信登录");
    
}


- (void)onClickSina:(UIButton *)button{
    
    //新浪登录
    NSLog(@"新浪登录");
    
}

- (void)rememberPsw:(UIButton *)sender {
    
    NSLog(@"remember");
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:101];
    if (self.checkboxChecked) {
        //同意
        [btn setImage:[UIImage imageNamed:@"noSelected"] forState:UIControlStateNormal];
        self.checkboxChecked = NO;
    }else {
        //不同意
        [btn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        self.checkboxChecked = YES;
    }
    
}

- (void)forgetPsw:(UIButton *)sender {
    
    //忘记密码
    ForgetPswViewController *forget = [[ForgetPswViewController alloc] initWithPageType:PageTypeForgetPassword];
    [self.navigationController pushViewController:forget animated:NO];
    
}

- (void)setNavigationLeftItem
{
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    
}

-(void)goBack {
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark-----UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.phoneTextField) {
        self.phoneTextField.text = [self.phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }  else if (textField == self.pswTextField) {
        self.pswTextField.text = [self.pswTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.phoneTextField) {
        [self.phoneTextField resignFirstResponder];
        
    } else if (textField == self.pswTextField) {
        [self.pswTextField resignFirstResponder];
        
    }
    
    return YES;
}

#pragma mark-----

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.phoneTextField resignFirstResponder];
    [self.pswTextField resignFirstResponder];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
