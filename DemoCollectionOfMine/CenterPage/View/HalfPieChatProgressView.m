//
//  HalfPieChatProgressView.m
//  DemoCollectionOfMine
//
//  Created by Andy on 16/1/21.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "HalfPieChatProgressView.h"

@implementation AYHalfLayer

- (instancetype)init {
    
    if ([super init]) {
        self.shadowOffset = CGSizeMake(0, -0.3);
        self.shadowColor = [UIColor grayColor].CGColor;
        self.shadowOpacity = 0.5;
    }
    return self;
}

- (void)configrationLayerWithRadius:(CGFloat)radius angle:(AYHalfShapeLayerAngle)angle {
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, radius, radius);
    CGPathAddArc(path, NULL, radius, radius, radius, angle.start, angle.end, 0);
    CGPathCloseSubpath(path);
    self.path = path;
    self.bounds = CGRectMake(0, 0, radius * 2, radius * 2);
    CGPathRelease(path);
}

@end

@interface HalfPieChatProgressView () {
    
    CGFloat _radius;
}

@property (nonatomic, assign) CGFloat arcWidth;
@property (nonatomic, strong) AYHalfLayer *ayLayer;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, assign) AYHalfShapeLayerAngle angle;
@end

@implementation HalfPieChatProgressView

- (CAShapeLayer *)maskLayer {
    
    if (!_maskLayer) {

        _maskLayer = [CAShapeLayer layer];
        _maskLayer.frame = CGRectMake(0, 0, _radius * 2, _radius * 2);
        _maskLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_radius,_radius) radius:_radius * .5 startAngle:_angle.start endAngle:_angle.end clockwise:YES].CGPath;
        _maskLayer.lineWidth = _radius;
        _maskLayer.fillColor = [UIColor clearColor].CGColor;
        _maskLayer.strokeColor = [UIColor blackColor].CGColor;
        self.layer.mask = _maskLayer;
    }
    return _maskLayer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _finishCorlor = [UIColor blueColor];
        _unfinishCorlor = [UIColor lightGrayColor];
        _backCorlor = [UIColor greenColor];
        _percent = .86;
        _startAngle = 135;
        _endAngle = 405;
        _lineWidth = 10;
        _radius = frame.size.width * .5;
        _angle = AYHalfShapeLayerAngleMake(_startAngle, _endAngle);
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    [super willMoveToSuperview:newSuperview];
//    AYHalfShapeLayerAngle angle = AYHalfShapeLayerAngleMake(0, 0);
    
//    _angle = AYHalfShapeLayerAngleMake(_startAngle, _endAngle);
    CGFloat endAngle = _percent * (_angle.end - _angle.start) + _angle.start;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_radius, _radius) radius:_radius - _lineWidth startAngle:_angle.start endAngle:endAngle clockwise:YES];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    AYHalfLayer *layer = [AYHalfLayer layer];
    //        [layer configrationLayerWithRadius:_radius - _offSet angle:angle];
    //        layer.position = CGPointMake(_radius, _radius);
    layer.strokeColor = self.finishCorlor.CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.path = path.CGPath;
    layer.lineWidth = _lineWidth;
    [self.layer addSublayer:layer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 2;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
//    [self.maskLayer addAnimation:animation forKey:@"showAnima"];
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    [self drawMiddleCircle];
    [self drawUnfinishCircle];
}

- (void)drawUnfinishCircle {
    
    UIBezierPath *cPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_radius, _radius) radius:_radius - _lineWidth startAngle:_angle.start endAngle:_angle.end clockwise:YES];
    cPath.lineWidth = self.lineWidth;
    //    cPath.lineCapStyle = kCGLineCapRound;
    //    cPath.lineJoinStyle = kCGLineJoinRound;
    UIColor *color = self.backCorlor;
    [color setStroke];
    [cPath stroke];
}

- (void)drawMiddleCircle {
    
    UIBezierPath *cPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_radius, _radius) radius:_radius - _lineWidth * .5 startAngle:_angle.start endAngle:_angle.end clockwise:YES];
    cPath.lineWidth = self.lineWidth;
//    cPath.lineCapStyle = kCGLineCapRound;
//    cPath.lineJoinStyle = kCGLineJoinRound;
    UIColor *color = self.unfinishCorlor;
    [color setStroke];
    [cPath stroke];
}

@end
