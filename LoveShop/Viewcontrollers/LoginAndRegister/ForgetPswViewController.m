//
//  ForgetPswViewController.m
//  LoveShop
//
//  Created by 景睦科技 on 2017/10/20.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import "ForgetPswViewController.h"

@interface ForgetPswViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView        *backView;

@property (nonatomic, strong) UITextField   *accountTextField;

@property (nonatomic, strong) UITextField   *phoneTextField;

@property (nonatomic, strong) UITextField   *pswTextField;

@property (nonatomic, strong) UITextField   *codeTextField;

@property (nonatomic, strong) UIButton      *reSendBtn;// 验证码

@property (nonatomic, strong) UIButton      *sureBtn;// 确认密码

@property (nonatomic, assign) NSInteger     countdown; // 验证码倒计时

@property (nonatomic, strong) NSTimer       *countdownTimer;

@end

@implementation ForgetPswViewController

- (id)initWithPageType:(PageType)pageType
{
    self = [super init];
    if (self) {
        self.navigationItem.title = pageType == PageTypeForgetPassword ? @"忘记密码" : @"修改密码";
        _pageType = pageType;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = bgColor;
    
    [self setNavigationLeftItem];
    
    [self initUI];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
    
}

#pragma mark -- initMethod

- (void)setNavigationLeftItem
{
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    
}

- (void)initUI {
    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(20, 10 + 64, SCREEN_WIDTH - 40, 150)];
    self.backView.backgroundColor = bgColor;//bgColor
    [self.view addSubview:self.backView];
    
    self.accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, 30)];
    self.accountTextField.delegate = self;
    self.accountTextField.layer.cornerRadius = 4.0;
    self.accountTextField.backgroundColor = [UIColor whiteColor];
    self.accountTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.accountTextField.returnKeyType = UIReturnKeyDone;
    self.accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.accountTextField.leftViewMode = UITextFieldViewModeAlways;
    self.accountTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.accountTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    self.phoneTextField.secureTextEntry = YES;//明文或密文
    self.accountTextField.placeholder = @"  请输入你的账号";
    self.accountTextField.font = [UIFont systemFontOfSize:14];
    [self.backView addSubview:self.accountTextField];
    
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH - 40, 30)];
    self.phoneTextField.delegate = self;
    self.phoneTextField.layer.cornerRadius = 4.0;
    self.phoneTextField.backgroundColor = [UIColor whiteColor];
    self.phoneTextField.keyboardType = UIKeyboardTypeDefault;
    self.phoneTextField.returnKeyType = UIReturnKeyDone;
    self.phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    self.phoneTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.phoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.phoneTextField.secureTextEntry = NO;//明文或密文
    self.phoneTextField.placeholder = @"  请输入你的手机号";
    self.phoneTextField.font = [UIFont systemFontOfSize:14];
    [self.backView addSubview:self.phoneTextField];
    
    self.pswTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH - 40, 30)];
    self.pswTextField.delegate = self;
    self.pswTextField.layer.cornerRadius = 4.0;
    self.pswTextField.backgroundColor = [UIColor whiteColor];
    self.pswTextField.keyboardType = UIKeyboardTypeDefault;
    self.pswTextField.returnKeyType = UIReturnKeyDone;
    self.pswTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pswTextField.leftViewMode = UITextFieldViewModeAlways;
    self.pswTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.pswTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.pswTextField.secureTextEntry = YES;//明文或密文
    self.pswTextField.placeholder = @"  请输入新密码";
    self.pswTextField.font = [UIFont systemFontOfSize:14];
    [self.backView addSubview:self.pswTextField];
    
    self.codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 120, (SCREEN_WIDTH - 40)/2, 30)];
    self.codeTextField.delegate = self;
    self.codeTextField.layer.cornerRadius = 4.0;
    self.codeTextField.backgroundColor = [UIColor whiteColor];
    self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTextField.returnKeyType = UIReturnKeyDone;
    self.codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.codeTextField.leftViewMode = UITextFieldViewModeAlways;
    self.codeTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.codeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.codeTextField.placeholder = @"  请输入验证码";
    self.codeTextField.font = [UIFont systemFontOfSize:14];
    [self.backView addSubview:self.codeTextField];

    
    self.reSendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.reSendBtn.frame = CGRectMake((SCREEN_WIDTH - 40)/2 + 30, 120, SCREEN_WIDTH - 40 - ((SCREEN_WIDTH - 40)/2 + 30), 30);
    [self.reSendBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.reSendBtn.layer.cornerRadius = 4.0;
    self.reSendBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.reSendBtn.backgroundColor = [UIColor lightGrayColor];
    [self.reSendBtn addTarget:self action:@selector(reSendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.reSendBtn];
    
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(35, self.backView.frame.origin.y + self.backView.frame.size.height + 30, SCREEN_WIDTH - 70, 40);
    if (self.pageType == PageTypeForgetPassword) {
        [self.sureBtn setTitle:@"确认密码" forState:UIControlStateNormal];
    }else{
        [self.sureBtn setTitle:@"确认修改密码" forState:UIControlStateNormal];
    }
    self.sureBtn.layer.cornerRadius = 4.0;
    self.sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.sureBtn.backgroundColor = [UIColor colorWithHexString:@"389fdf"];
    [self.sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sureBtn];
    
    
    
    
}

#pragma mark -- UIButton

- (void)reSendBtnClick:(UIButton *)sender {
    
    //发送验证码
    [self.phoneTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];
    [self.pswTextField resignFirstResponder];
    [self.accountTextField resignFirstResponder];
    
    NSString *phone = self.phoneTextField.text;
    self.reSendBtn.userInteractionEnabled = YES;
    if ([phone length] == 0) {
        [AppTools showString:@"手机号不能为空"];
        return;
    }
    if (![AppTools isValidateMobile:phone]) {
        [AppTools showString:@"请输入正确的手机号码."];
        return;
    }
    if (phone.length < 11 || phone.length > 11) {
        [AppTools showString:@"请输入正确的手机号码."];
        return ;
    }
    
    // 验证码接口  忘记密码验证码  修改密码验证码
    [self beginTimer];
    
    
}

- (void)sureBtnClick:(UIButton *)sender {
    
    //确认密码
    [self.view endEditing:YES];
    NSString *phone = self.phoneTextField.text;
    NSString *code  = self.codeTextField.text;
    NSString *password = [self.pswTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *account = [self.accountTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (account == nil || account.length == 0) {
        [AppTools showString:@"账号不能为空."];
        return;
    }
    
    if (phone ==nil || phone.length == 0) {
        [AppTools showString:@"手机号不能为空"];
        return ;
    }
    
    if (phone.length < 11 || phone.length > 11) {
        [AppTools showString:@"请输入正确的手机号码"];
        return ;
    }
    
    if (![AppTools isValidateMobile:phone]) {
        [AppTools showString:@"请输入正确的手机号码"];
        return ;
    }
    
    if (code == nil || [@"" isEqualToString:code]) {
        [AppTools showString:@"请输入验证码"];
        return;
    }
    
    if (code.length < 6 || code.length > 6) {
        [AppTools showString:@"请输入正确的验证码"];
        return ;
    }
    
    if (password == nil || password.length == 0) {
        [AppTools showString:@"密码不能为空."];
        return;
    }
    
    if(password.length < 6 || password.length > 16)
    {
        [AppTools showString:@"密码长度有误，密码为6-16个字符."];
        return;
    }
    
    // 忘记密码接口  修改密码接口
    
}


-(void)goBack {
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark-----验证码

- (void)beginTimer {
    
    self.countdown = 60;
    self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    
}

- (void)timeFireMethod
{
    self.countdown--;
    if (self.countdown == 0) {
        [self.countdownTimer invalidate];
    }
    [self flashReSendBtn];
}

- (void)flashReSendBtn
{
    if (self.countdown > 0) {
        [self.reSendBtn setTitle:[NSString stringWithFormat:@"%zd秒重新发送", self.countdown] forState:UIControlStateNormal];
        self.reSendBtn.userInteractionEnabled = NO;
    } else {
        [self.reSendBtn setTitle:@"点击获取验证码" forState:UIControlStateNormal];
        self.reSendBtn.userInteractionEnabled = YES;
    }
    
}

#pragma mark-----UITextFieldDelegate

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.phoneTextField) {
        self.phoneTextField.text = [self.phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    } else if (textField == self.codeTextField) {
        self.codeTextField.text = [self.codeTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    } else if (textField == self.pswTextField) {
        self.pswTextField.text = [self.pswTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    } else if (textField == self.accountTextField) {
        self.accountTextField.text = [self.accountTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.phoneTextField) {
        [self.phoneTextField resignFirstResponder];
        
    } else if (textField == self.codeTextField) {
        [self.codeTextField resignFirstResponder];
        
    } else if (textField == self.pswTextField) {
        [self.pswTextField resignFirstResponder];
        
    } else if (textField == self.accountTextField) {
        [self.accountTextField resignFirstResponder];
        
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
