//
//  TouchIDViewController.m
//  DemoCollectionOfMine
//
//  Created by Andy on 16/2/18.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "TouchIDViewController.h"
#import "AYTouchID.h"
@interface TouchIDViewController () <AYTouchIDDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) AYTouchID *touchID;

@end

@implementation TouchIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _touchID = [[AYTouchID alloc] init];
    [_touchID startAYTouchIDWithMessage:@"Message" fallbackTitle:@"Fallback" delegate:self];
}

- (IBAction)touchIDAction:(id)sender {
    
    [_touchID startAYTouchIDWithMessage:@"Message" fallbackTitle:@"Fallback" delegate:self];
}

#pragma mark - AYTouchIDDelegate

- (void)touchIDAuthorizeSuccess {
    
    _titleLabel.text = @"TouchID 验证成功";
}

- (void)touchIDAuthorizeFailture {
    
    _titleLabel.text = @"TouchID 验证失败";
}

- (void)touchIDAuthorizeErrorUserCancel {
    
    _titleLabel.text = @"取消TouchID验证（User）";
}
- (void)touchIDAuthorizeUserFallBack {
    
    _titleLabel.text = @"点击了TouchID对话框输入密码";
}
- (void)touchIDAuthorizeErrorSystemCancel {
    _titleLabel.text = @"取消TouchID验证（Sys）";
}
- (void)touchIDAuthorizeErrorPasscodeNotSet {
    _titleLabel.text = @"未设置密码，无法启用TouchID";
}
- (void)touchIDAuthorizeErrorTouchIDNotEnrolled {
    
    _titleLabel.text = @"TouchID未录入指纹";
}
- (void)touchIDAuthorizeErrorTouchIDNotAvailable {
    
    _titleLabel.text = @"该设备TouchID失效";
}
- (void)touchIDAuthorizeErrorTouchIDLockout {
    
    _titleLabel.text = @"多次验证失败，请输入密码";
}
- (void)touchIDAuthorizeErrorAppCancel {
    
    _titleLabel.text = @"当前被挂起取消授权";
}
- (void)touchIDAuthorizeErrorInvalidContext {
    
    _titleLabel.text = @"当前软件被挂起，LAContext对象释放";
}
-(void)touchIDIsNotSupport {
    
    _titleLabel.text = @"当前设备无TouchID";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
