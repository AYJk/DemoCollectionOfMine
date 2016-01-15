//
//  PieChatCircularArc.h
//  PieChatTest
//
//  Created by Andy on 16/1/4.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>

struct AYShapeLayerAngle {
    double start;
    double end;
};
typedef struct AYShapeLayerAngle AYShapeLayerAngle;
CG_INLINE AYShapeLayerAngle AYShapeLayerAngleMake(double startAngle ,double endAngle) {
    
    AYShapeLayerAngle angle;
    angle.start = startAngle;
    angle.end = endAngle;
    return angle;
}


@interface AYLayer : CAShapeLayer

- (void)configrationLayerWithRadius:(CGFloat)radius angle:(AYShapeLayerAngle)angle;

@end

@interface PieChartCircularArc : UIView

- (instancetype)pieChartCenter:(CGPoint)center radius:(CGFloat)radius colors:(NSArray<UIColor *> *)colors datas:(NSArray<NSNumber *> *)datas offset:(CGFloat)offset;

@property (nonatomic, copy) void (^tappedHandler) (NSInteger, BOOL);

@end
