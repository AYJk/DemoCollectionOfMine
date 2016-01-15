//
//  PieChatCircularArc.m
//  PieChatTest
//
//  Created by Andy on 16/1/4.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "PieChartCircularArc.h"

@implementation AYLayer

- (instancetype)init {
    
    if ([super init]) {
        self.shadowOffset = CGSizeMake(0, -0.3);
        self.shadowColor = [UIColor grayColor].CGColor;
        self.shadowOpacity = 0.5;
    }
    return self;
}

- (void)configrationLayerWithRadius:(CGFloat)radius angle:(AYShapeLayerAngle)angle {
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, radius, radius);
    CGPathAddArc(path, NULL, radius, radius, radius, angle.start, angle.end, 0);
    CGPathCloseSubpath(path);
    self.path = path;
    self.bounds = CGRectMake(0, 0, radius * 2, radius * 2);
    CGPathRelease(path);
}

@end

@interface PieChartCircularArc () {
    
    CGFloat _radius;
    CGFloat _offSet;
}

@property (nonatomic ,strong) NSArray<UIColor *> *colors;
@property (nonatomic, strong) NSArray<NSNumber *> *datas;
@property (nonatomic, assign) CGFloat arcWidth;
@property (nonatomic, strong) AYLayer *ayLayer;
@property (nonatomic, strong) CAShapeLayer *maskLayer;

@end

@implementation PieChartCircularArc

- (CAShapeLayer *)maskLayer {
    
    if (!_maskLayer) {
        _maskLayer = [CAShapeLayer layer];
        _maskLayer.frame = CGRectMake(0, 0, _radius * 2 + _offSet * .5, _radius * 2 + _offSet * .5);
        _maskLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width * .5,self.bounds.size.width * .5) radius:_radius * .5 + _offSet * .5 startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
        _maskLayer.lineWidth = _radius + _offSet;
        _maskLayer.fillColor = [UIColor clearColor].CGColor;
        _maskLayer.strokeColor = [UIColor blackColor].CGColor;
        self.layer.mask = _maskLayer;
    }
    return _maskLayer;
}

- (instancetype)pieChartCenter:(CGPoint)center radius:(CGFloat)radius colors:(NSArray<UIColor *> *)colors datas:(NSArray<NSNumber *> *)datas offset:(CGFloat)offset {
    double sum = 0;
    for (NSNumber *num in datas) {
        sum += num.doubleValue;
        NSAssert(num.doubleValue <=1 && sum <= 1, @"请检查datas数组");
    }
    NSAssert(colors.count == datas.count, @"colors 和 ratioes 不匹配，导致错误！");
    CGRect frame = CGRectMake(0, 0, radius * 2 + offset, radius * 2 + offset);
    if ([super initWithFrame:frame]) {
        _colors = colors;
        _datas = datas;
        _radius = radius;
        _offSet = offset < 10 ? 10:offset;
    }
    self.center = center;
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    [super willMoveToSuperview:newSuperview];
    AYShapeLayerAngle angle = AYShapeLayerAngleMake(0, 0);
    for (int index = 0; index < _colors.count; index ++) {
        angle = AYShapeLayerAngleMake(angle.end, angle.end + M_PI * 2 * self.datas[index].doubleValue);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width * .5, self.bounds.size.height * .5) radius:_radius - _offSet * .5 startAngle:angle.start endAngle:angle.end clockwise:YES];
        AYLayer *layer = [AYLayer layer];
//        [layer configrationLayerWithRadius:_radius - _offSet angle:angle];
//        layer.position = CGPointMake(_radius, _radius);
        layer.strokeColor = self.colors[index].CGColor;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.path = path.CGPath;
        layer.lineWidth = _offSet;
        [self.layer addSublayer:layer];
    }
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 2;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [self.maskLayer addAnimation:animation forKey:@"showAnima"];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    if (![self isInMask:touchPoint]) {
        return;
    }
    CGPoint translatePoint = [self translateIntoCoordinateSystem:touchPoint];
    double angle = atan2(translatePoint.y, translatePoint.x);
    if (angle < 0) {
        angle += M_PI * 2;
    }
    int index = [self touchIntoLayer:angle];
    __weak typeof (self)weakSelf = self;
    if (self.ayLayer == [self getLayerWithIndex:index]) {
        [UIView animateWithDuration:0.2 animations:^{
            [weakSelf getLayerWithIndex:index].transform = CATransform3DMakeScale(1, 1, 1);
            [weakSelf getLayerWithIndex:index].position = CGPointMake(0 , 0 );
        } completion:^(BOOL finished) {
            weakSelf.ayLayer = nil;
        }];
        if (self.tappedHandler) {
            self.tappedHandler(index, NO);
        }
        return;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [weakSelf getLayerWithIndex:index].transform = CATransform3DMakeScale(1, 1, 1);
        [weakSelf getLayerWithIndex:index].position = [weakSelf positionWithIndex:index];
        if (weakSelf.ayLayer) {
            weakSelf.ayLayer.transform = CATransform3DMakeScale(1, 1, 1);
            weakSelf.ayLayer.position = CGPointMake(0, 0);
        }
    } completion:^(BOOL finished) {
        weakSelf.ayLayer = [weakSelf getLayerWithIndex:index];
    }];
    if (self.tappedHandler) {
        self.tappedHandler(index, YES);
    }
}

//获取更改后的layer的中心位置
- (CGPoint)positionWithIndex:(int)index {
    AYShapeLayerAngle angle;
    __weak typeof(self)weakSelf = self;
    double start = 0;
    double end = 0;
    for (int i = 0; i <= index; i++) {
        if (i < index) {
            start += weakSelf.datas[i].doubleValue;
        }
        end += weakSelf.datas[i].doubleValue;
    }
    angle = AYShapeLayerAngleMake(2 * M_PI * start, 2 * M_PI * end);
    double direactionAngle = direction(angle);
    double cosT = _offSet / 2 * cos(direactionAngle);
    double sinT = _offSet / 2 * sin(direactionAngle);
    return CGPointMake(cosT, sinT);
}

//获取对应layer
- (AYLayer *)getLayerWithIndex:(int)index {
    return (AYLayer *)self.layer.sublayers[index];
}

- (BOOL)isInMask:(CGPoint)point {
    
    double x = point.x - _radius - _offSet;
    double y = point.y - _radius - _offSet;
    double pow = powf(x, 2) + powf(y, 2);
    if (sqrt(pow) <= _radius) {
        return YES;
    }
    return NO;
}

- (CGPoint)translateIntoCoordinateSystem:(CGPoint)point {
    
    return CGPointMake(point.x - _radius, point.y - _radius);
}

//判断当前点在第几个layer的区间之内，-1表示判断错误
- (int)touchIntoLayer:(double)angle {
    
    AYShapeLayerAngle layerBounds = AYShapeLayerAngleMake(0, 0);
    for (int i = 0 ; i < self.datas.count; i ++) {
        layerBounds =  AYShapeLayerAngleMake(layerBounds.end, layerBounds.end + M_PI * 2 * self.datas[i].doubleValue);
        if (angle >= layerBounds.start && angle < layerBounds.end) {
            return i;
        }
    }
    return -1;
}
//获得移动方向的角度，相当于移动的向量角度

double direction(AYShapeLayerAngle angle) {
    
    return angle.start + (angle.end - angle.start) / 2;
}
@end
