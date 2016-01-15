//
//  WaterWareView.m
//  DemoCollectionOfMine
//
//  Created by Andy on 16/1/13.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "WaterWareView.h"
#import <CoreMotion/CoreMotion.h>
@interface WaterWareView ()

@property (nonatomic, strong) CADisplayLink *waveDisplayLink;

@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) CMMotionManager *motionManger;
@property (assign, nonatomic) CGAffineTransform originTransform;
@property (assign, nonatomic) CGAffineTransform currentTransform;
@end

static CGFloat currentPercent;

@implementation WaterWareView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.motionManger = [[CMMotionManager alloc] init];
        self.motionManger.deviceMotionUpdateInterval = .1f;
        self.backgroundColor = [UIColor yellowColor];
        _waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(startWave)];
        [_waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        _timer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        [self configParameter];
        [self setSubLayer];
        [self showViewAnima];
    }
    return self;
}

- (void)configParameter {
    
    _waterColor = [UIColor colorWithRed:102 / 255 green:204 / 255.0 blue:1 alpha:1];
    _waterShdowColor = [UIColor colorWithRed:0 green:128 / 255.0 blue:1 alpha:1];
    _waveAmplitude = 3.0;
    _waveSpeed = 1.0;
    _increase = YES;
    _isShowCurrentPercent = YES;
    _percent = 0;
    _originTransform = self.transform;
    currentPercent = 0;
}

- (void)showViewAnima {
    
    [self.motionManger startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        
        //        NSLog(@"gravity.x = %.2f",motion.gravity.x);
        _currentTransform = CGAffineTransformRotate(_originTransform, M_PI_2 * (- motion.gravity.x));
        __weak WaterWareView *weakSelf = self;
        [UIView animateWithDuration:.5 animations:^{
            weakSelf.transform = _currentTransform;
        }];
    }];
}
- (void)setSubLayer {
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 200, 200) cornerRadius:100];
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.frame = self.bounds;
    self.layer.mask = shapeLayer;
}

- (void)timerAction:(NSTimer *)timer {
    
    currentPercent += .001;
    if (currentPercent >= _percent) {
        [_timer invalidate];
    }
}

- (void)startWave {
    
    if (_increase) {
        _waveAmplitude += .02;
    } else {
        _waveAmplitude -= .02;
    }
    
    if (_waveAmplitude <= 1) {
        _increase = YES;
    }
    if (_waveAmplitude>=1.5) {
        _increase = NO;
    }
    _waveSpeed += 0.1;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat waterHeight = rect.size.height * (1 - currentPercent);
    //  获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //  推入
    CGContextSaveGState(context);
    CGFloat frontPathY = waterHeight;
    //  创建前景波浪路径
    CGMutablePathRef frontPath = CGPathCreateMutable();
    CGPathMoveToPoint(frontPath, NULL, 0, frontPathY);
    //  创建背景波浪路径
    CGMutablePathRef backPath = CGPathCreateMutable();
    CGFloat backPathY = waterHeight;
    CGPathMoveToPoint(backPath, NULL, 0, backPathY);
    //  波浪线宽度
    CGContextSetLineWidth(context, 1);
    for (float index = 0; index < rect.size.width; index ++) {
        //  前波浪线高度
        frontPathY = _waveAmplitude *sin(index / 180 * M_PI + 4 * _waveSpeed / M_PI) * 5 + waterHeight;
        //  后波浪线高度
        backPathY = _waveAmplitude * cos(index / 180 * M_PI + 3 * _waveSpeed / M_PI) * 5 + waterHeight;
        CGPathAddLineToPoint(backPath, NULL, index, backPathY);
        CGPathAddLineToPoint(frontPath, NULL, index, frontPathY);
    }
    //  后波浪绘制
    CGContextSetFillColorWithColor(context, _waterShdowColor.CGColor);
    CGPathAddLineToPoint(backPath, nil, rect.size.width, rect.size.height);
    CGPathAddLineToPoint(backPath, nil, 0, rect.size.height);
    CGPathAddLineToPoint(backPath, nil, 0, waterHeight);
    CGPathCloseSubpath(backPath);
    CGContextAddPath(context, backPath);
    CGContextFillPath(context);
    //  推入
    CGContextSaveGState(context);
    //  弹出
//    CGContextRestoreGState(context);
    //  前波浪绘制
    CGContextSetFillColorWithColor(context, _waterColor.CGColor);
    CGPathAddLineToPoint(frontPath, NULL, rect.size.width, rect.size.height);
    CGPathAddLineToPoint(frontPath, NULL, 0, rect.size.height);
    CGPathAddLineToPoint(frontPath, NULL, 0, waterHeight);
    CGPathCloseSubpath(frontPath);
    CGContextAddPath(context, frontPath);
    CGContextFillPath(context);
    //  推入
    CGContextSaveGState(context);
    //释放
    CGPathRelease(backPath);
    CGPathRelease(frontPath);
}

@end
