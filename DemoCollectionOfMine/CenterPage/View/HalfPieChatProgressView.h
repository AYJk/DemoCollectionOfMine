//
//  HalfPieChatProgressView.h
//  DemoCollectionOfMine
//
//  Created by Andy on 16/1/21.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>

struct AYHalfShapeLayerAngle {
    double start;
    double end;
};
typedef struct AYHalfShapeLayerAngle AYHalfShapeLayerAngle;
CG_INLINE AYHalfShapeLayerAngle AYHalfShapeLayerAngleMake(double startAngle ,double endAngle) {
    
    AYHalfShapeLayerAngle angle;
    
    angle.start = (M_PI * startAngle)/ 180.0;
    angle.end = (M_PI * endAngle)/ 180.0;
    return angle;
}


@interface AYHalfLayer : CAShapeLayer


- (void)configrationLayerWithRadius:(CGFloat)radius angle:(AYHalfShapeLayerAngle)angle;

@end

@interface HalfPieChatProgressView : UIView

//  起点 角度
@property (nonatomic, assign) CGFloat startAngle;
//  终点 角度
@property (nonatomic, assign) CGFloat endAngle;
//  已经完成的颜色
@property (nonatomic, strong) UIColor *finishCorlor;
//  未完成的颜色
@property (nonatomic, strong) UIColor *unfinishCorlor;
//  最外圈修饰色
@property (nonatomic, strong) UIColor *backCorlor;
//  要显示的进度
@property (nonatomic, assign) CGFloat percent;
//  线宽
@property (nonatomic, assign) CGFloat lineWidth;
//  半径
@property (nonatomic, assign) CGFloat radius;

//- (instancetype)pieChartCenter:(CGPoint)center radius:(CGFloat)radius finishColor:(UIColor *)finishColor unfinishColor:() progressNum:(CGFloat)progressNum startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle offset:(CGFloat)offset;

@end
