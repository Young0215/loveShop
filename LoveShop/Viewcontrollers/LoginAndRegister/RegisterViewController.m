//
//  RegisterViewController.m
//  LoveShop
//
//  Created by 景睦科技 on 2017/9/21.
//  Copyright © 2017年 景睦科技. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView       *backView;

@property (nonatomic, strong) UITextField  *phoneTextField;//手机号

@property (nonatomic, strong) UITextField  *pswTextField;//密码

@property (nonatomic, strong) UITextField  *codeTextField;//验证码

@property (nonatomic, strong) UITextField  *againPswTextField;//确认密码

@property (nonatomic, strong) UIButton     *reSendBtn;//发送验证码

@property (nonatomic, strong) UIButton     *regisBtn;//注册

@property (nonatomic, assign) BOOL         checkboxChecked;

@property (nonatomic, assign) NSInteger    countdown; // 验证码倒计时

@property (nonatomic, strong) NSTimer      *countdownTimer;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = bgColor;
    
    self.checkboxChecked = YES;
    
    [self setNavigationLeftItem];
    
    [self createTextFields];
    
    [self creatButtons];
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.checkboxChecked = YES;
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
    
}

#pragma mark----- initUI

- (void)createTextFields {
    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(20, 20 + 64, SCREEN_WIDTH - 40, 200)];
    self.backView.backgroundColor = bgColor;//bgColor
    [self.view addSubview:self.backView];
    
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, 40)];
    phoneView.backgroundColor = [UIColor whiteColor];
    phoneView.layer.cornerRadius = 4.0;
    [self.backView addSubview:phoneView];
    
    UIView *pswView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH - 40, 40)];
    pswView.backgroundColor = [UIColor whiteColor];
    pswView.layer.cornerRadius = 4.0;
    [self.backView addSubview:pswView];
    
    UIView *againPswView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH - 40, 40)];
    againPswView.backgroundColor = [UIColor whiteColor];
    againPswView.layer.cornerRadius = 4.0;
    [self.backView addSubview:againPswView];
    
    UIView *codeView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH - 180, 40)];
    codeView.backgroundColor = [UIColor whiteColor];
    codeView.layer.cornerRadius = 4.0;
    [self.backView addSubview:codeView];
    
    UIImageView *nameImg = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, 25, 25)];
    nameImg.image = [UIImage imageNamed:@"name"];
    [phoneView addSubview:nameImg];
    
    UIImageView *pswImg = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, 25, 25)];
    pswImg.image = [UIImage imageNamed:@"psw"];
    [pswView addSubview:pswImg];
    
    UIImageView *againPswImg = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, 25, 25)];
    againPswImg.image = [UIImage imageNamed:@"psw"];
    [againPswView addSubview:againPswImg];
    
    UIImageView *codeImg = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, 25, 25)];
    codeImg.image = [UIImage imageNamed:@"code"];
    [codeView addSubview:codeImg];
    
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH - 80, 40)];
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

    self.pswTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH - 80, 40)];
    self.pswTextField.delegate = self;
    self.pswTextField.keyboardType = UIKeyboardTypeDefault;
    self.pswTextField.returnKeyType = UIReturnKeyDone;
    self.pswTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pswTextField.leftViewMode = UITextFieldViewModeAlways;
    self.pswTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.pswTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.pswTextField.secureTextEntry = YES;//明文或密文
    self.pswTextField.placeholder = @"请输入用户密码";
    self.pswTextField.font = [UIFont systemFontOfSize:14];
    [pswView addSubview:self.pswTextField];
    
    self.againPswTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH - 80, 40)];
    self.againPswTextField.delegate = self;
    self.againPswTextField.keyboardType = UIKeyboardTypeDefault;
    self.againPswTextField.returnKeyType = UIReturnKeyDone;
    self.againPswTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.againPswTextField.leftViewMode = UITextFieldViewModeAlways;
    self.againPswTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.againPswTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.againPswTextField.secureTextEntry = YES;//明文或密文
    self.againPswTextField.placeholder = @"请确认密码";
    self.againPswTextField.font = [UIFont systemFontOfSize:14];
    [againPswView addSubview:self.againPswTextField];
    
    self.codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH - 220, 40)];
    self.codeTextField.delegate = self;
    self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTextField.returnKeyType = UIReturnKeyDone;
    self.codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.codeTextField.leftViewMode = UITextFieldViewModeAlways;
    self.codeTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.codeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.codeTextField.placeholder = @"请输入手机验证码";
    self.codeTextField.font = [UIFont systemFontOfSize:14];
    [codeView addSubview:self.codeTextField];
    
    self.reSendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.reSendBtn.frame = CGRectMake(codeView.frame.size.width + 40, 150, 100, 40);
    [self.reSendBtn setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    self.reSendBtn.layer.cornerRadius = 4.0;
    self.reSendBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.reSendBtn.backgroundColor = [UIColor lightGrayColor];
    [self.reSendBtn addTarget:self action:@selector(reSendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.reSendBtn];
    
    
}

- (void)creatButtons {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, self.backView.frame.origin.y + self.backView.frame.size.height + 10, SCREEN_WIDTH - 40, 90)];
    view.backgroundColor = bgColor;
    [self.view addSubview:view];
    
    
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, 30)];
    buttonView.backgroundColor = bgColor;
    [view addSubview:buttonView];
    
    UIButton *selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectedBtn.frame = CGRectMake(0, 5, 20, 20);
    selectedBtn.tag = 101;
    [selectedBtn setImage:[UIImage imageNamed:@"dui"] forState:UIControlStateNormal];
    [selectedBtn addTarget:self action:@selector(selectedBtn:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:selectedBtn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 30)];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"点击注册表示你已经同意爱购云商";
    [buttonView addSubview:label];
    
    UIButton *third = [UIButton buttonWithType:UIButtonTypeCustom];
    third.frame = CGRectMake(label.frame.size.width , 0, 100, 30);
    [third setTitle:@"《服务协议》" forState:UIControlStateNormal];
    third.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [third setTitleColor:[UIColor colorWithHexString:@"ff5301"] forState:UIControlStateNormal];
    third.titleLabel.font = [UIFont systemFontOfSize:12];
    [third addTarget:self action:@selector(thirdBtn:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:third];
    
    self.regisBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.regisBtn.frame = CGRectMake(0, 50, SCREEN_WIDTH - 40, 40);
    self.regisBtn.layer.cornerRadius = 4.0;
    [self.regisBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    self.regisBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.regisBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.regisBtn setBackgroundColor:[UIColor colorWithHexString:@"ff5301"]];
    [self.regisBtn addTarget:self action:@selector(regisBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.regisBtn];
    
    
    
}



#pragma mark----- UIButton


- (void)regisBtn:(UIButton *)sender {
    
    //注册
    [self.view endEditing:YES];
    NSString *phone = self.phoneTextField.text;
    NSString *code  = self.codeTextField.text;
    NSString *password = [self.pswTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *againPsw = [self.againPswTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
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
    
    if (code == nil || [@"" isEqualToString:code]) {
        [AppTools showString:@"请输入验证码."];
        return;
    }
    
    if (password == nil || password.length == 0 || againPsw == nil || againPsw.length == 0) {
        [AppTools showString:@"密码不能为空."];
        return;
    }
    
    if(password.length < 6 || password.length > 16 || againPsw.length < 6 || againPsw.length > 16)
    {
        [AppTools showString:@"密码长度有误，密码为6-16个字符."];
        return;
    }
    
    
    if(![self.pswTextField.text isEqualToString:self.againPswTextField.text])
    {
        [AppTools showString:@"两次密码不一致"];
        return;
    }
    
    if (self.checkboxChecked) {
        //同意服务协议
        // 注册接口
        
        
    }else {
        //不同意服务协议
        [AppTools showString:@"请先同意服务协议"];
    }
    
}

- (void)selectedBtn:(UIButton *)sender {
    
    //同意不同意
    UIButton *btn = (UIButton *)[self.view viewWithTag:101];
    if (self.checkboxChecked) {
        //同意
        [btn setImage:[UIImage imageNamed:@"huidui"] forState:UIControlStateNormal];
        self.checkboxChecked = NO;
    }else {
        //不同意
        [btn setImage:[UIImage imageNamed:@"dui"] forState:UIControlStateNormal];
        self.checkboxChecked = YES;
    }
    
}

- (void)thirdBtn:(UIButton *)sender {
    //服务协议
//    AboutUsViewController *about = [[AboutUsViewController alloc] initWithPageType:PageTypeServiceAgreement];
//    [self.navigationController pushViewController:about animated:NO];
    
}

- (void)reSendBtnClick:(UIButton *)sender {
    
    //发送验证码
    [self.phoneTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];
    [self.pswTextField resignFirstResponder];
    [self.againPswTextField resignFirstResponder];
    
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
    
    // 验证码接口
    [self beginTimer];
    
    
}


- (void)setNavigationLeftItem
{
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    
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
        self.countdownTimer = nil;
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
    } else if (textField == self.againPswTextField) {
        self.againPswTextField.text = [self.againPswTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
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
        [self.againPswTextField becomeFirstResponder];
    } else if (textField == self.againPswTextField) {
        [self.againPswTextField resignFirstResponder];
        
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
