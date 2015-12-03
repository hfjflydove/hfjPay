//
//  SPayError.h
//  SPay
//
//  Created by 何飞江 on 15/9/1.
//  Copyright (c) 2015年 何飞江. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SPayErrorOption)
{
    SPayErrUnknownError,
    SPayErrCancelled,  // 取消
    SPayErrChannelReturnFail, // 支付渠道返回错误
    SPayErrInvalidChannel, // 无效的支付渠道
    SPayErrInvalidCharge, // 无效支付订单
    SPayErrViewControllerIsNil, //控制器为空
    SPayErrWxAppNotSupportedOrNotInstalled, // 没有安装微信或者当前的微信版本不支持OpenApi
    SPayErrGuestIDIsNil, // guestID不能为空
    SPayErrApiKeyOrAppKeyIsNil, // apiKey或者appKey不能为空
    SPayErrQuickPayAmountError,  // 快捷支付订单金额不能小于5元
    SPayErrConnectionError // 网络连接错误
};


@interface SPayError : NSObject

@property(nonatomic, assign) SPayErrorOption errorCode;

@property(nonatomic, copy) NSString *message;


@end
