//
//  AYTouchID.m
//  DemoCollectionOfMine
//
//  Created by Andy on 16/2/18.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "AYTouchID.h"

@implementation AYTouchID

- (void)startAYTouchIDWithMessage:(NSString *)message fallbackTitle:(NSString *)fallbackTitle delegate:(id<AYTouchIDDelegate>)delegate {
    
    LAContext *context = [[LAContext alloc] init];
    context.localizedFallbackTitle = fallbackTitle;
    NSError *error = nil;
    self.delegate = delegate;
    NSAssert(self.delegate != nil, @"delegate不能为nil");
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:message == nil ? @"提示信息": message  reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                if ([self.delegate respondsToSelector:@selector(touchIDAuthorizeSuccess)]) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [self.delegate touchIDAuthorizeSuccess];
                    }];
                }
            } else if (error) {
                
                switch (error.code) {
                    case LAErrorAuthenticationFailed: {
                        
                        if ([self.delegate respondsToSelector:@selector(touchIDAuthorizeFailture)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate touchIDAuthorizeFailture];
                            }];
                        }
                    }
                        break;
                    case LAErrorAppCancel: {
                        
                        if ([self.delegate respondsToSelector:@selector(touchIDAuthorizeErrorAppCancel)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate touchIDAuthorizeErrorAppCancel];
                            }];
                        }
                    }
                        break;
                    case LAErrorUserCancel: {
                        
                        if ([self.delegate respondsToSelector:@selector(touchIDAuthorizeErrorUserCancel)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate touchIDAuthorizeErrorUserCancel];
                            }];
                        }
                    }
                        break;
                    case LAErrorSystemCancel: {
                        
                        if ([self.delegate respondsToSelector:@selector(touchIDAuthorizeErrorSystemCancel)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate touchIDAuthorizeErrorSystemCancel];
                            }];
                        }
                    }
                        break;
                    case LAErrorUserFallback: {
                        
                        if ([self.delegate respondsToSelector:@selector(touchIDAuthorizeUserFallBack)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate touchIDAuthorizeUserFallBack];
                            }];
                        }
                    }
                        break;
                    case LAErrorTouchIDNotAvailable: {
                        
                        if ([self.delegate respondsToSelector:@selector(touchIDAuthorizeErrorTouchIDNotAvailable)]) {
                            
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate touchIDAuthorizeErrorTouchIDNotAvailable];
                            }];
                        }
                    }
                        break;
                    case LAErrorPasscodeNotSet: {
                        
                        if ([self.delegate respondsToSelector:@selector(touchIDAuthorizeErrorPasscodeNotSet)]) {
                            
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate touchIDAuthorizeErrorPasscodeNotSet];
                            }];
                        }
                    }
                        break;
                    case LAErrorTouchIDLockout: {
                        
                        if ([self.delegate respondsToSelector:@selector(touchIDAuthorizeErrorTouchIDLockout)]) {
                            
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate touchIDAuthorizeErrorTouchIDLockout];
                            }];
                        }
                    }
                        break;
                    case LAErrorTouchIDNotEnrolled: {
                        
                        if ([self.delegate respondsToSelector:@selector(touchIDAuthorizeErrorTouchIDNotEnrolled)]) {
                            
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate touchIDAuthorizeErrorTouchIDNotEnrolled];
                            }];
                        }
                    }
                        break;
                    case LAErrorInvalidContext: {
                        if ([self.delegate respondsToSelector:@selector(touchIDAuthorizeErrorInvalidContext)]) {
                            
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate touchIDAuthorizeErrorInvalidContext];
                            }];
                        }
                    }
                        break;
                    default:
                        break;
                }
            }
        }];
    } else {
        
        if ([self.delegate respondsToSelector:@selector(touchIDIsNotSupport)]) {
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.delegate touchIDIsNotSupport];
            }];
        }
    }
}

@end
