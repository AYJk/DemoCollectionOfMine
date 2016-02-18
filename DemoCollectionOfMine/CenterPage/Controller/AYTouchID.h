//
//  AYTouchID.h
//  DemoCollectionOfMine
//
//  Created by Andy on 16/2/18.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <LocalAuthentication/LocalAuthentication.h>

@protocol AYTouchIDDelegate <NSObject>

@required
/**
 *  TouchID验证成功
 */
- (void)touchIDAuthorizeSuccess;
/**
 *  TouchID验证失败
 */
- (void)touchIDAuthorizeFailture;

@optional

/**
 *  用户点击取消按钮
 */
- (void)touchIDAuthorizeErrorUserCancel;


/**
 *  用户点击输入密码按钮
 */
- (void)touchIDAuthorizeUserFallBack;

/**
 *  验证TouchID过程中锁屏，按下Home键，电话等
 */
- (void)touchIDAuthorizeErrorSystemCancel;

/**
 *  无法启用TouchID设备没有设置密码
 */
- (void)touchIDAuthorizeErrorPasscodeNotSet;

/**
 *  设备没有录入TouchID，无法启用TouchID
 */
- (void)touchIDAuthorizeErrorTouchIDNotEnrolled;

/**
 *  该设备的TouchID无效
 */
- (void)touchIDAuthorizeErrorTouchIDNotAvailable;

/**
 *  多次连续使用Touch ID失败，Touch ID被锁，需要用户输入密码解锁
 */
- (void)touchIDAuthorizeErrorTouchIDLockout;

/**
 *  当前软件被挂起取消了授权(如突然来了电话,应用进入前台)
 */
- (void)touchIDAuthorizeErrorAppCancel;

/**
 *  当前软件被挂起取消了授权 (授权过程中,LAContext对象被释)
 */
- (void)touchIDAuthorizeErrorInvalidContext;

/**
 *  当前设备不支持指纹识别
 */
-(void)touchIDIsNotSupport;
@end

@interface AYTouchID : LAContext

@property (weak, nonatomic) id<AYTouchIDDelegate>delegate;

/**
 *  发起TouchID验证 (Initiate TouchID validation)
 *
 *  @param message 提示框需要显示的信息 默认为：输入密码 (Fallback button title. Default is "Enter Password")
 */
- (void)startAYTouchIDWithMessage:(NSString *)message fallbackTitle:(NSString *)fallbackTitle delegate:(id<AYTouchIDDelegate>)delegate;

@end
