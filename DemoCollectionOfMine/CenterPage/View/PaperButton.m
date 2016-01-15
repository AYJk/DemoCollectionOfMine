//
//  PaperButton.m
//  DemoCollectionOfMine
//
//  Created by Andy on 15/12/31.
//  Copyright © 2015年 Andy. All rights reserved.
//

#import "PaperButton.h"
@interface PaperButton ()

@property (nonatomic, strong) CALayer *topLayer;
@property (nonatomic, strong) CALayer *middleLayer;
@property (nonatomic, strong) CALayer *bottomLayer;

@end

@implementation PaperButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self configLayer];
    }
    return self;
}

- (void)configLayer {
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = 2.0f;
    CGFloat cornerRadius = 1.0f;
    CGColorRef color = [self.tintColor CGColor];
    
    _topLayer = [CALayer layer];
    _topLayer.frame = CGRectMake(0, CGRectGetMinY(self.frame), width, height);
    _topLayer.backgroundColor = color;
    _topLayer.cornerRadius = cornerRadius;
    
    _middleLayer = [CALayer layer];
    _middleLayer.frame = CGRectMake(0, CGRectGetMidY(self.frame) - height * .5, width, height);
    _middleLayer.backgroundColor = color;
    _middleLayer.cornerRadius = cornerRadius;
    
    _bottomLayer = [CALayer layer];
    _bottomLayer.frame = CGRectMake(0, CGRectGetMaxY(self.frame) - height, width, height);
    _bottomLayer.backgroundColor = color;
    _bottomLayer.cornerRadius = cornerRadius;
    
    [self.layer addSublayer:_topLayer];
    [self.layer addSublayer:_middleLayer];
    [self.layer addSublayer:_bottomLayer];
    
    [self addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickAction:(PaperButton *)btn {
    
    static BOOL isClick;
    isClick = !isClick;
    if (_paperButtonBlock) {
        _paperButtonBlock(btn);
    }
    if (isClick) {
        
        [self showMenu];
    } else {
        
        [self closeMenu];
    }
    
}

- (void)showMenu {
    
    [self removeAllAnimations];

    POPBasicAnimation *showTopAnimaPosi = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    showTopAnimaPosi.toValue = [NSValue valueWithCGPoint:CGPointMake(self.bounds.size.width * .5, self.bounds.size.height * .5)];
    showTopAnimaPosi.duration = .3;
    
    POPSpringAnimation *showTopAnimaRota = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    showTopAnimaRota.toValue = @(M_PI_4);
    showTopAnimaRota.springBounciness = 20;
    showTopAnimaRota.springSpeed = 20;
    showTopAnimaRota.dynamicsTension = 1000;
    
    POPBasicAnimation *showBtmAnimaPosi = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    showBtmAnimaPosi.toValue = [NSValue valueWithCGPoint:CGPointMake(self.bounds.size.width * .5, self.bounds.size.height * .5)];
    showBtmAnimaPosi.duration = .3;
    
    POPSpringAnimation *showBtmAnimaRota = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    showBtmAnimaRota.toValue = @(-M_PI_4);
    showBtmAnimaRota.springBounciness = 20;
    showBtmAnimaRota.springSpeed = 20;
    showBtmAnimaRota.dynamicsTension = 1000;
    
    POPBasicAnimation *showMidAnimaOpacity = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    showMidAnimaOpacity.fromValue = @1;
    showMidAnimaOpacity.toValue = @0;
    showMidAnimaOpacity.duration = .3;
    
    [_topLayer pop_addAnimation:showTopAnimaPosi forKey:@"showTopLayerPosi"];
    [_topLayer pop_addAnimation:showTopAnimaRota forKey:@"showTopLayerRota"];
    [_bottomLayer pop_addAnimation:showBtmAnimaPosi forKey:@"showBottomLayerPosi"];
    [_bottomLayer pop_addAnimation:showBtmAnimaRota forKey:@"showBottomLayerRota"];
    [_middleLayer pop_addAnimation:showMidAnimaOpacity forKey:@"showMiddleLayerOpacity"];
}

- (void)closeMenu {
    
    [self removeAllAnimations];

    POPBasicAnimation *closeTopAnimaPosi = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    closeTopAnimaPosi.toValue = [NSValue valueWithCGPoint:CGPointMake(self.bounds.size.width * .5, 0)];
    closeTopAnimaPosi.duration = .3;
    
    POPSpringAnimation *closeTopAnimaRota = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    closeTopAnimaRota.toValue = @(0);
    closeTopAnimaRota.springBounciness = 20;
    closeTopAnimaRota.springSpeed = 20;
    closeTopAnimaRota.dynamicsTension = 1000;
    
    POPBasicAnimation *closeBtmAnimaPosi = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    closeBtmAnimaPosi.toValue = [NSValue valueWithCGPoint:CGPointMake(self.bounds.size.width * .5, self.frame.size.height)];
    closeBtmAnimaPosi.duration = .3;
    
    POPSpringAnimation *closeBtmAnimaRota = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    closeBtmAnimaRota.toValue = @(0);
    closeBtmAnimaRota.springBounciness = 20;
    closeBtmAnimaRota.springSpeed = 20;
    closeBtmAnimaRota.dynamicsTension = 1000;
    
    POPBasicAnimation *closeMidAnimaOpacity = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    closeMidAnimaOpacity.fromValue = @0;
    closeMidAnimaOpacity.toValue = @1;
    closeMidAnimaOpacity.duration = .3;
    
    [_topLayer pop_addAnimation:closeTopAnimaPosi forKey:@"closeTopLayerPosi"];
    [_topLayer pop_addAnimation:closeTopAnimaRota forKey:@"closeTopLayerRota"];
    [_bottomLayer pop_addAnimation:closeBtmAnimaPosi forKey:@"closeBottomLayerPosi"];
    [_bottomLayer pop_addAnimation:closeBtmAnimaRota forKey:@"closeBottomLayerRota"];
    [_middleLayer pop_addAnimation:closeMidAnimaOpacity forKey:@"closeMiddleLayerOpacity"];
}

- (void)removeAllAnimations {
    
    [_topLayer pop_removeAllAnimations];
    [_middleLayer pop_removeAllAnimations];
    [_bottomLayer pop_removeAllAnimations];
}

@end
