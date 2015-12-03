//
//  SPayUtility.h
//  SPay
//
//  Created by 何飞江 on 15/10/20.
//  Copyright © 2015年 何飞江. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SPayUtility : NSObject

/** SPayUtility 单例对象 */
+ (SPayUtility *)sharedInstance;

/** 是否关闭填写银行卡信息界面的键盘处理事件 */
@property (nonatomic, assign) BOOL closeKeyBoardHandle;

/** 快捷支付界面状态栏 */
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

/** 导航栏标题字体颜色 */
@property (nonatomic, strong) UIColor *navTitleColor;

/** 导航栏item字体颜色 */
@property (nonatomic, strong) UIColor *navItemColor;

/** 导航栏标题字体大小 */
@property (nonatomic, strong) UIFont *navTitleFont;

/** 导航栏item字体大小 */
@property (nonatomic, strong) UIFont *navItemFont;

/** 所有大界面的背景颜色 */
@property (nonatomic, strong) UIColor *viewBGColor;

/** SDK里面所有下一步, 确定, 完成等按钮的正常状态背景颜色 */
@property (nonatomic, strong) UIColor *btnNormalColor;

/** SDK里面所有下一步, 确定, 完成等按钮的不可点击状态背景颜色 */
@property (nonatomic, strong) UIColor *btnDisableColor;

/** SDK里面所有下一步, 确定, 完成等按钮的正常状态字体颜色 */
@property (nonatomic, strong) UIColor *btnTitleColor;

/** SDK里面所有下一步, 确定, 完成等按钮的不可点击状态字体颜色 */
@property (nonatomic, strong) UIColor *btnTitleDisableColor;


@end
