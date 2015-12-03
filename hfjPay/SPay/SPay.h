//
//  SPay.h
//  SPay
//
//  Created by 何飞江 on 15/9/1.
//  Copyright (c) 2015年 何飞江. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SPayError.h"


@protocol SPayDelegate <NSObject>

- (void)paymentResult:(NSString *)result error:(SPayError *)error;

@end

@interface SPay : NSObject

typedef void (^SPayCompletion)(NSString *result, SPayError *error);

/** SPay 单利对象 */
+ (SPay *)defaultService;

/**
 *  支付调用接口
 *
 *  @param payment          payment 对象
 *  @param scheme           URL Scheme，支付宝渠道回调需要
 *  @param completionBlock  支付的结果回调 Block
 */
+ (void)createPayment:(NSDictionary *)payment appURLScheme:(NSString *)scheme withCompletion:(SPayCompletion)completionBlock;

/**
 *  支付调用接口
 *
 *  @param payment          payment 对象
 *  @param scheme           URL Scheme，支付宝渠道回调需要
 *  @param guestID          商户下面的用户ID,快捷支付渠道需要
 *  @param viewController   快捷支付渠道需要
 *  @param completionBlock  支付的结果回调 Block
 */
+ (void)createPayment:(NSDictionary *)payment appURLScheme:(NSString *)scheme guestID:(NSString *)guestID viewController:(UIViewController*)viewController withCompletion:(SPayCompletion)completionBlock;

/**
 *  回调结果接口(支付宝/微信)
 *
 *  @param url              结果url
 *  @param completionBlock  跳转支付过程中，当app被kill掉时，能通过这个接口得到支付结果
 */
+ (BOOL)handleOpenURL:(NSURL *)url withCompletion:(SPayCompletion)completionBlock;

/**
 *  实名认证查询
 *
 *  @param guestID          商户下面的用户ID
 *  @param viewController   快捷支付渠道需要
 */
+ (void)quickPayRealNameVerifiedWithGuestID:(NSString *)guestID viewController:(UIViewController *)viewController;

/**
 *  版本号
 *
 *  @return  SPay SDK 版本号
 */
+ (NSString *)version;

/**
 *  设置 Debug 打印模式
 *
 *  @param enabled    是否启用打印功能
 */
+ (void)setDebugLog:(BOOL)enabled;

FOUNDATION_EXPORT void SPayLog(NSString *format,...) NS_FORMAT_FUNCTION(1,2) ;




@end
