//
//  ScanViewController.m
//  DemoCollectionOfMine
//
//  Created by Andy on 16/1/7.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>
static const CGFloat kBorderW = 50;

@interface ScanViewController () <UIAlertViewDelegate,AVCaptureMetadataOutputObjectsDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, weak) UIView *maskView;
@property (nonatomic, strong) UIView *scanWindow;
@property (nonatomic, strong) UIImageView *scanNetImageView;
@end

@implementation ScanViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self resumeAnimation];
    self.navigationController.navigationBar.hidden = YES;

}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //防止返回的时候出现黑边
//    self.view.clipsToBounds = YES;
    //遮罩
    [self setUpMaskView];
    //下边栏
    [self setUpBottomBar];
    //提示文本
    [self setupTipTitleView];
    //顶部导航
    [self setupNavView];
    //设置扫描区域
    [self setupScanWindowView];
    //开始扫描
    [self beginScanning];
}

- (void)beginScanning {
    
    //获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if (!input) {
        return;
    }
    //创建输出流
    AVCaptureMetadataOutput *outPut = [[AVCaptureMetadataOutput alloc] init];
    //设置代理 在主线程刷新
    [outPut setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //设置有效扫描范围
    CGRect scanCrop = [self getScanCrop:_scanWindow.bounds readerViewBounds:self.view.bounds];
    outPut.rectOfInterest = scanCrop;
    //初始化链接对象
    _session = [[AVCaptureSession alloc] init];
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    [_session addInput:input];
    [_session addOutput:outPut];
    //设置扫码支持的编码格式（如下设置条形码和二维码兼容）
    outPut.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    [_session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    if (metadataObjects.count > 0) {
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects firstObject];
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"扫描结果" message:metadataObject.stringValue delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"再次扫描", nil];
//        [alterView show];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Scan Result" message:metadataObject.stringValue preferredStyle:UIAlertControllerStyleAlert];
        __weak ScanViewController *weakSelf = self;
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf.session startRunning];
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf.session startRunning];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0) {
//        [self disMiss];
//    } else if (buttonIndex == 1) {
//        [_session startRunning];
//    }
//}
#pragma mark - 获取扫描区域的比例关系
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds {
    
    CGFloat x,y,width,height;
    x = (CGRectGetWidth(readerViewBounds) - CGRectGetWidth(rect)) * .5 / CGRectGetWidth(readerViewBounds);
    y = (CGRectGetHeight(readerViewBounds) - CGRectGetHeight(rect)) * .5 / CGRectGetHeight(readerViewBounds);
    height = CGRectGetHeight(rect) / CGRectGetHeight(readerViewBounds);
    width = CGRectGetWidth(rect) / CGRectGetWidth(readerViewBounds);
    return CGRectMake(y, x, height, width);
}


- (void)setupScanWindowView {
    
    CGFloat scanWidth = self.view.bounds.size.width - kBorderW * 2;
    CGFloat scanHeight = scanWidth;
    
    _scanWindow = [[UIView alloc] initWithFrame:CGRectMake(kBorderW, CGRectGetMinY(_maskView.frame) + kBorderW, scanWidth, scanHeight)];
    _scanWindow.clipsToBounds = YES;
    
    _scanNetImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_net"]];
    [self.view addSubview:_scanWindow];
    CGFloat buttonWH = 18;
    UIButton *topLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWH, buttonWH)];
    [topLeft setImage:[UIImage imageNamed:@"scan_1"] forState:UIControlStateNormal];
    [_scanWindow addSubview:topLeft];
    
    UIButton *topRight = [[UIButton alloc] initWithFrame:CGRectMake(scanWidth - buttonWH, 0, buttonWH, buttonWH)];
    [topRight setImage:[UIImage imageNamed:@"scan_2"] forState:UIControlStateNormal];
    [_scanWindow addSubview:topRight];
    
    UIButton *bottomLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, scanHeight - buttonWH, buttonWH, buttonWH)];
    [bottomLeft setImage:[UIImage imageNamed:@"scan_3"] forState:UIControlStateNormal];
    [_scanWindow addSubview:bottomLeft];
    
    UIButton *bottomRight = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(topRight.frame), CGRectGetMinY(bottomLeft.frame), buttonWH, buttonWH)];
    [bottomRight setImage:[UIImage imageNamed:@"scan_4"] forState:UIControlStateNormal];
    [_scanWindow addSubview:bottomRight];
}

- (void)setupNavView {
    
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, CGRectGetMinY(_maskView.frame))];
    maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
    [self.view addSubview:maskView];
    
    //1.返回
    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(20, 30, 25, 25);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"qrcode_scan_titlebar_back_nor"] forState:UIControlStateNormal];
    backBtn.contentMode=UIViewContentModeScaleAspectFit;
    [backBtn addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    //2.相册
    
    UIButton * albumBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    albumBtn.frame = CGRectMake((self.view.bounds.size.width - 50) * .5, 20, 50, 67);
    [albumBtn setBackgroundImage:[UIImage imageNamed:@"qrcode_scan_btn_photo_nor"] forState:UIControlStateNormal];
    [albumBtn setBackgroundImage:[UIImage imageNamed:@"qrcode_scan_btn_photo_down"] forState:UIControlStateHighlighted];
    albumBtn.contentMode=UIViewContentModeScaleAspectFit;
    [albumBtn addTarget:self action:@selector(myAlbum) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:albumBtn];
    
    //3.闪光灯
    
    UIButton * flashBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    flashBtn.frame = CGRectMake(self.view.bounds.size.width - 70,20, 50, 67);
    [flashBtn setBackgroundImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
    [flashBtn setBackgroundImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_down"] forState:UIControlStateSelected];
    flashBtn.contentMode=UIViewContentModeScaleAspectFit;
    [flashBtn addTarget:self action:@selector(openFlash:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:flashBtn];
}

#pragma mark 恢复动画
- (void)resumeAnimation {
    
    CAAnimation *anim = [_scanNetImageView.layer animationForKey:@"translationAnimation"];
    if(anim){
        // 1. 将动画的时间偏移量作为暂停时的时间点
        CFTimeInterval pauseTime = _scanNetImageView.layer.timeOffset;
        // 2. 根据媒体时间计算出准确的启动动画时间，对之前暂停动画的时间进行修正
        CFTimeInterval beginTime = CACurrentMediaTime() - pauseTime;
        
        // 3. 要把偏移时间清零
        [_scanNetImageView.layer setTimeOffset:0.0];
        // 4. 设置图层的开始动画时间
        [_scanNetImageView.layer setBeginTime:beginTime];
        
        [_scanNetImageView.layer setSpeed:1.0];
        
    }else{
        
        CGFloat scanNetImageViewH = 241;
        CGFloat scanWindowH = self.view.bounds.size.width - kBorderW * 2;
        CGFloat scanNetImageViewW = _scanWindow.bounds.size.width;
        
        _scanNetImageView.frame = CGRectMake(0, -scanNetImageViewH, scanNetImageViewW, scanNetImageViewH);
        CABasicAnimation *scanNetAnimation = [CABasicAnimation animation];
        scanNetAnimation.keyPath = @"transform.translation.y";
        scanNetAnimation.byValue = @(scanWindowH);
        scanNetAnimation.duration = 1.0;
        scanNetAnimation.repeatCount = MAXFLOAT;
        [_scanNetImageView.layer addAnimation:scanNetAnimation forKey:@"translationAnimation"];
        [_scanWindow addSubview:_scanNetImageView];
    }
    
    
    
}

-(void)openFlash:(UIButton*)button {
    
    button.selected = !button.selected;
    if (button.selected) {
        [self turnTorchOn:YES];
    } else {
        
        [self turnTorchOn:NO];
    }
}

- (void)turnTorchOn:(BOOL)on {
    
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]) {
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
            } else {
                
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
        } else {
            
            [device unlockForConfiguration];
        }
    }
}

- (void)myAlbum {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        //初始化相册拾取器
        UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
        //设置代理
        imagePC.delegate = self;
        //3.设置资源：
        /**
         UIImagePickerControllerSourceTypePhotoLibrary,相册
         UIImagePickerControllerSourceTypeCamera,相机
         UIImagePickerControllerSourceTypeSavedPhotosAlbum,照片库
         */
        imagePC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        //转场动画
        imagePC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:imagePC animated:YES completion:nil];
    } else {
        
//        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"设备不支持访问相册，请在设置->隐私->照片中进行设置！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alter show];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"设备不支持访问相册，请在设置->隐私->照片中进行设置！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - imagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    //获取选取的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //初始化监测器
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
    [picker dismissViewControllerAnimated:YES completion:^{
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
        if (features.count >= 1) {
            CIQRCodeFeature *feature = [features objectAtIndex:0];
            NSString *scannedResult = feature.messageString;
//            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"扫描结果" message:scannedResult delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alterView show];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Scan Result" message:scannedResult preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        } else {
            
//            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"改图片没有包含一个二维码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alterView show];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"图片没有包含一个二维码" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
}

- (void)disMiss {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupTipTitleView {
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_maskView.frame) - 25, self.view.bounds.size.width, 25)];
    tipLabel.text = @"将取景框对准二维码,即可自动扫描";
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.font = [UIFont systemFontOfSize:12.0];
    [self.view addSubview:tipLabel];
}

- (void)setUpBottomBar {
    
    UIView *bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_maskView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(_maskView.frame))];
    bottomBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
    [self.view addSubview:bottomBar];
    
    UIButton *myCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 50) * .5, CGRectGetHeight(bottomBar.frame) - 67, 50, 67)];
    [myCodeBtn setImage:[UIImage imageNamed:@"qrcode_scan_btn_myqrcode_nor"] forState:UIControlStateNormal];
    [myCodeBtn setImage:[UIImage imageNamed:@"qrcode_scan_btn_myqrcode_down"] forState:UIControlStateHighlighted];
    myCodeBtn.contentMode = UIViewContentModeScaleAspectFit;
    [myCodeBtn addTarget:self action:@selector(myCode:) forControlEvents:UIControlEventTouchUpInside];
    [bottomBar addSubview:myCodeBtn];
}

- (void)myCode:(UIButton *)btn {
    
    
}

- (void)setUpMaskView {
    
    UIView *maskView = [[UIView alloc] init];
    _maskView = maskView;
    maskView.layer.borderWidth = kBorderW;
    maskView.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7].CGColor;
    maskView.bounds = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width);
    maskView.center = CGPointMake(self.view.bounds.size.width * .5, self.view.bounds.size.height * .5);
    [self.view addSubview:maskView];
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
