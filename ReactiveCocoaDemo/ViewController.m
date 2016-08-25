//
//  ViewController.m
//  ReactiveCocoaDemo
//
//  Created by nercita on 16/8/25.
//  Copyright © 2016年 nercita. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "LoytTextField.h"

@interface ViewController ()
@property (nonatomic, strong) LoytTextField *userNameField;
@property (nonatomic, strong) LoytTextField *passWordField;
@property (nonatomic, strong) UIButton *loginBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

-(void)setupUI{
    
    [self.view addSubview:self.userNameField];
    [self.view addSubview:self.passWordField];
    [self.view addSubview:self.loginBtn];
    
    RACSignal *userName = self.userNameField.rac_textSignal;
    RACSignal *passWord = self.passWordField.rac_textSignal;
    
    @weakify(self);
    [[RACSignal combineLatest:@[userName,passWord]]
                 subscribeNext:^(RACTuple *x) {
                     
                     @strongify(self);
                     NSString *name = x.first;
                     NSString *pwd = x.second;
                     NSLog(@"name: %@,pwd: %@",name,pwd);
                     
                     self.loginBtn.enabled = name.length && pwd.length;
         
     }];
    
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
                 subscribeNext:^(id x) {
                     SEDLog(@"登录");
        
        
    }];
    
}


-(LoytTextField *)userNameField{
    
    if (!_userNameField) {
        
        _userNameField = [[LoytTextField alloc] init];
        _userNameField.left = 20;
        _userNameField.top = 40;
        _userNameField.width = SCREEN_WIDTH - 40;
        _userNameField.height = 40;
        _userNameField.placeholder = @"请输入用户名";
        _userNameField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"username_icon"]];
        _userNameField.leftViewMode = UITextFieldViewModeAlways;
        _userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
    }
    return _userNameField;
}

-(LoytTextField *)passWordField{
    
    if (!_passWordField) {
        
        _passWordField = [[LoytTextField alloc] init];
        _passWordField.left = 20;
        _passWordField.top = self.userNameField.bottom + 20;
        _passWordField.width = SCREEN_WIDTH - 40;
        _passWordField.height = 40;
        _passWordField.placeholder = @"请输入密码";
        _passWordField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Vector-Smart-Object"]];
        _passWordField.leftViewMode = UITextFieldViewModeAlways;
        _passWordField.secureTextEntry = YES;
        _passWordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _passWordField;
}

-(UIButton *)loginBtn{
    
    if (!_loginBtn) {
        //顺序是内容,sizeToFit,位置,否则位置容易出误差
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setImage:[UIImage imageNamed:@"login_icon"] forState:UIControlStateNormal];
        [_loginBtn sizeToFit];
        _loginBtn.centerX = SCREEN_WIDTH*0.5;
        _loginBtn.top = self.passWordField.bottom + 20;
    }
    return _loginBtn;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

-(void)demo1{
    
    ///  自定义信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@"hehe"];
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    [signal subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
}

-(void)demo2{
    
    
}

@end
