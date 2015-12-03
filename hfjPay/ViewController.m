//
//  ViewController.m
//  SPay
//
//  Created by 何飞江 on 15/9/1.
//  Copyright (c) 2015年 何飞江. All rights reserved.
//

#import "ViewController.h"
#import "SPay.h"
#import "SPayUtility.h"


#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define kMaxAmount        9999999
#define RGB7790e0 UIColorFromRGB(0x7790e0)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define kGuest_id @"111"


@interface ViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *myTextField;

@property(nonatomic, copy) NSString *channel_type;

@property (nonatomic, strong) UIAlertView *alertView;

// 测试
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) UILabel *urlLabel;
@property (nonatomic, strong) UITextField *guestIdTextField;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat x = 10;
    CGFloat width = self.view.frame.size.width - 2 * x;
    CGFloat btnW = (width - 10) / 2;
    self.myTextField = [[UITextField alloc]initWithFrame:CGRectMake(x, 40, btnW, 44)];
    self.myTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.myTextField.leftViewMode = UITextFieldViewModeAlways;
    self.myTextField.clipsToBounds = YES;
    self.myTextField.layer.cornerRadius = 8;
    self.myTextField.layer.borderColor = RGB7790e0.CGColor;
    self.myTextField.layer.borderWidth = 1.0;
    self.myTextField.backgroundColor = [UIColor whiteColor];
    self.myTextField.placeholder = @"输入金额";
    self.myTextField.delegate = self;
    self.myTextField.returnKeyType =UIReturnKeyDone;
    self.myTextField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:self.myTextField];
    self.myTextField.text = @"5";
    
    UIButton *quickPayBtn = [[UIButton alloc] init];
    [self setupBtn:quickPayBtn withTitle:@"快捷支付" tag:3 action:@selector(payAction:)];
    [quickPayBtn setFrame:CGRectMake(x, CGRectGetMaxY(self.myTextField.frame)+10, btnW, 44)];
    
    UIButton *verifiedBtn = [[UIButton alloc] init];
    [self setupBtn:verifiedBtn withTitle:@"实名认证查询" tag:0 action:@selector(verified)];
    [verifiedBtn setFrame:CGRectMake(CGRectGetMaxX(quickPayBtn.frame) + 10, quickPayBtn.frame.origin.y, btnW, 44)];
    
    
    self.guestIdTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(verifiedBtn.frame), CGRectGetMinY(self.myTextField.frame), btnW, 44)];
    self.guestIdTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.guestIdTextField.leftViewMode = UITextFieldViewModeAlways;
    self.guestIdTextField.clipsToBounds = YES;
    self.guestIdTextField.layer.cornerRadius = 8;
    self.guestIdTextField.layer.borderColor = RGB7790e0.CGColor;
    self.guestIdTextField.layer.borderWidth = 1.0;
    self.guestIdTextField.backgroundColor = [UIColor whiteColor];
    self.guestIdTextField.placeholder = @"用户ID";
    self.guestIdTextField.delegate = self;
    self.guestIdTextField.returnKeyType = UIReturnKeyDone;
    self.guestIdTextField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:self.guestIdTextField];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 改回原来的状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.segment.selectedSegmentIndex = 0;
    [self segmentChangeIndex:self.segment];
    
    self.segment.hidden = YES;
    self.urlLabel.hidden = YES;
}

- (void)segmentChangeIndex:(UISegmentedControl *)segment
{
    switch (segment.selectedSegmentIndex) {
        case 0:
            self.url = @"http://tm1.spay.silversnet.com/api/order.php";
            break;
        case 1:
            self.url = @"http://101.200.192.2:9902/api/order.php";
            break;
        case 2:
            self.url = @"https://merchant.spay.silversnet.com/api/order.php";
            break;
        default:
            break;
    }
    self.urlLabel.text = self.url;
}

- (void)setupBtn:(UIButton *)btn withTitle:(NSString *)title tag:(NSInteger)tag action:(SEL)action
{
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 8;
    btn.backgroundColor = RGB7790e0;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 18.0];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.tag = tag;
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

/** 实名认证查询 */
- (void)verified
{
    [SPay quickPayRealNameVerifiedWithGuestID:kGuest_id viewController:self];
}


- (void)payAction:(UIButton *)sender
{
    [self.guestIdTextField  resignFirstResponder];
    
    //    if (!self.guestIdTextField.text.length) {
    //
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入一个用户ID" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //        [alert show];
    //        return;
    //    }
    
    
    [self.myTextField resignFirstResponder];
    
    if (!self.myTextField.text.length || ![self.myTextField.text floatValue]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入金额" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    
    NSInteger tag = ((UIButton*)sender).tag;
    
    switch (tag) {
        case 1:
            self.channel_type = @"wechat";
            break;
        case 2:
            self.channel_type = @"alipay";
            break;
        case 3:
            self.channel_type = @"quickPay";
            break;
        default:
            break;
    }
    
    
    //    long long amount = [[self.myTextField.text stringByReplacingOccurrencesOfString:@"." withString:@""] longLongValue];
    //    NSString *amountStr = [NSString stringWithFormat:@"%lld", amount];
    
    NSString *amountStr = [NSString stringWithFormat:@"%lld", [self.myTextField.text longLongValue] * 100];
    // NSLog(@"amountStr---%@", amountStr);
    
    // 测试  url
    NSURL* url = [NSURL URLWithString:self.url];
    NSMutableURLRequest * postRequest=[NSMutableURLRequest requestWithURL:url];
    
    NSDictionary *dict = @{
                           @"act" : @"create",
                           @"subject" : @"your subject",
                           @"amount"  : amountStr,
                           @"channel_type" : self.channel_type,
                           };
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:dict];
    NSString *guest_id = kGuest_id;
    if ([self.channel_type isEqualToString:@"quickPay"]) {
        
        // 快捷支付需要传递guest_id(用户ID)
        if (self.guestIdTextField.text.length) {
            guest_id = self.guestIdTextField.text;
        }
        [dictM  setObject:guest_id forKey:@"guest_id"];
        dict = [NSDictionary dictionaryWithDictionary:dictM];
    }
    
    
    NSData* data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    postRequest.HTTPBody = data;
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    postRequest.timeoutInterval = 20;
    __weak ViewController *weakSelf = self;
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [self showAlertWait];
    
    [NSURLConnection sendAsynchronousRequest:postRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf hideAlert];
        });
        
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        
        if (httpResponse.statusCode != 200 || connectionError != nil) {
            
            NSLog(@"网络错误+++++, code : %ld", httpResponse.statusCode);
            NSLog(@"error = %@", connectionError);
            return;
        }
        
        NSDictionary *payment = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"payment = %@", payment);
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            // 需要和设置里面的URL Types一致,才能正常从支付宝转跳回自己的app
            NSString *scheme = @"SPayDemo";
            [SPay createPayment:payment appURLScheme:scheme guestID:guest_id viewController:self withCompletion:^(NSString *result, SPayError *error) {
                
                NSString *message = [NSString stringWithFormat:@"支付结果:%@; 错误信息:%@; 错误码:%ld", result, error.message, (unsigned long)error.errorCode];
                [weakSelf showAlertMessage:message];
            }];
        });
    }];
}

// 修改快捷支付界面的部分的UI
- (void)utility
{
    [SPayUtility sharedInstance].statusBarStyle = UIStatusBarStyleDefault;
    [SPayUtility sharedInstance].navTitleColor = [UIColor redColor];
    [SPayUtility sharedInstance].navItemColor = [UIColor redColor];
    [SPayUtility sharedInstance].navItemFont = [UIFont systemFontOfSize:18];
    [SPayUtility sharedInstance].navTitleFont = [UIFont systemFontOfSize:13];
    [SPayUtility sharedInstance].viewBGColor = [UIColor blueColor];
    [SPayUtility sharedInstance].btnNormalColor = [UIColor redColor];
    [SPayUtility sharedInstance].btnDisableColor = [UIColor lightGrayColor];
    [SPayUtility sharedInstance].btnTitleColor = [UIColor yellowColor];
    [SPayUtility sharedInstance].btnTitleDisableColor = [UIColor grayColor];
    [SPayUtility sharedInstance].closeKeyBoardHandle = YES; // 键盘处理
    
}

- (void)showAlertWait
{
    self.alertView = [[UIAlertView alloc] initWithTitle:@"加载中,请稍后..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [self.alertView show];
}

- (void)showAlertMessage:(NSString*)msg
{
    self.alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [self.alertView show];
}

- (void)hideAlert
{
    if (self.alertView != nil)
    {
        [self.alertView dismissWithClickedButtonIndex:0 animated:NO];
        self.alertView = nil;
    }
}

@end
