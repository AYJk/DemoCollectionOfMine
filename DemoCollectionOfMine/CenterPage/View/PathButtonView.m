//
//  PathButtonView.m
//  DemoCollectionOfMine
//
//  Created by Andy on 15/12/30.
//  Copyright © 2015年 Andy. All rights reserved.
//

#import "PathButtonView.h"
#import "PathButton.h"
#import <math.h>
#define iconWidth 25

static BOOL _isClick;
@interface PathButtonView () <PathButtonDelegate>

@property (nonatomic, strong) UIButton *centerItem;

@end

@implementation PathButtonView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        _centerItem = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth - iconWidth) * .5, kScreenHeight - 100, iconWidth, iconWidth)];
        [_centerItem addTarget:self action:@selector(centerAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_centerItem];
    }
    return self;
}

- (void)setCenterItemNormalImage:(NSString *)centerItemNormalImage {
    
    if (_centerItemNormalImage != centerItemNormalImage) {
        _centerItemNormalImage = centerItemNormalImage;
        [_centerItem setBackgroundImage:[UIImage imageNamed:_centerItemNormalImage] forState:UIControlStateNormal];
    }
}

- (void)setCenterItemHighlightImage:(NSString *)centerItemHighlightImage {
    
    if (_centerItemHighlightImage != centerItemHighlightImage) {
        _centerItemHighlightImage = centerItemHighlightImage;
        [_centerItem setBackgroundImage:[UIImage imageNamed:_centerItemHighlightImage] forState:UIControlStateHighlighted];
    }
}

- (void)centerAction:(UIButton *)btn {
    
    _isClick = !_isClick;
    
    if (_isClick) {
        
        [self centerItemClick];
    } else {
        
        [self centeritemUnClick];
    }
}

- (void)centerItemClick {
    
    
    self.backgroundColor = [UIColor colorWithWhite:.5 alpha:.5];
    POPBasicAnimation *basicAnima = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    basicAnima.fromValue = @(0);
    basicAnima.toValue = @(-M_PI * .75);
    basicAnima.duration = .25;
    basicAnima.beginTime = CACurrentMediaTime();
    [_centerItem.layer pop_addAnimation:basicAnima forKey:@"btnRotation"];
    //每个按钮间隔角度
    CGFloat angel = M_PI / (_pathItems.count - 1);
    for (int index = 0; index < _pathItems.count; index ++) {
        CGFloat currentAngel = angel * index;
        PathButton *item = _pathItems[index];
        item.frame = CGRectMake(0, 0, iconWidth, iconWidth);
        item.center = _centerItem.center;
        CGPoint endPoint = CGPointMake(_centerItem.center.x + cosf(currentAngel) * 100, _centerItem.center.y - sinf(currentAngel ) * 100);
        POPSpringAnimation *positionAnima = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnima.fromValue = [NSValue valueWithCGPoint:_centerItem.center];
        positionAnima.toValue = [NSValue valueWithCGPoint:endPoint];
        positionAnima.beginTime = CACurrentMediaTime();
        positionAnima.springBounciness = 13;
        positionAnima.springSpeed = 20;
        [item.layer pop_addAnimation:positionAnima forKey:@"beginSpring"];
        
        POPBasicAnimation *alphaAnima = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
        alphaAnima.fromValue = @0;
        alphaAnima.toValue = @1;
        alphaAnima.beginTime = CACurrentMediaTime();
        [item pop_addAnimation:alphaAnima forKey:@"beginAlphaBasic"];
        
        POPBasicAnimation *rotationAnima = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
        rotationAnima.fromValue = @0;
        rotationAnima.toValue = @(-M_PI * 2);
        rotationAnima.duration = .5;
        rotationAnima.beginTime = CACurrentMediaTime();
        [item.layer pop_addAnimation:rotationAnima forKey:@"beginRotationBasic"];
    }
}

- (void)centeritemUnClick {
    
    self.backgroundColor = [UIColor clearColor];
    POPBasicAnimation *basicAnima = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    basicAnima.toValue = @(0);
    basicAnima.duration = .25;
    basicAnima.beginTime = CACurrentMediaTime();
    CGFloat angel = M_PI / (_pathItems.count - 1);
    [_centerItem.layer pop_addAnimation:basicAnima forKey:@"btnRotationReset"];

    for (int index = 0; index < _pathItems.count; index ++) {
        CGFloat currentAngel = angel * index;
        PathButton *item = _pathItems[index];
        CGPoint endPoint = CGPointMake(_centerItem.center.x + cosf(currentAngel) * 130, _centerItem.center.y - sinf(currentAngel ) * 130);
        
        POPBasicAnimation *positionAnima1 = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnima1.toValue = [NSValue valueWithCGPoint:endPoint];
        positionAnima1.beginTime = CACurrentMediaTime();
        positionAnima1.duration = .2;
        [item.layer pop_addAnimation:positionAnima1 forKey:@"endPosition1Basic"];
        
        positionAnima1.completionBlock = ^(POPAnimation *popAnimation, BOOL complete) {
            
            if (complete) {
                POPBasicAnimation *positionAnima2 = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
                positionAnima2.toValue = [NSValue valueWithCGPoint:_centerItem.center];
                positionAnima2.beginTime = CACurrentMediaTime();
                positionAnima2.duration = .25;
                [item.layer pop_addAnimation:positionAnima2 forKey:@"endPosition2eBasic"];
                
                POPBasicAnimation *alphaAniam = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
                alphaAniam.fromValue = @1;
                alphaAniam.toValue = @0;
                alphaAniam.duration = .25;
                alphaAniam.beginTime = CACurrentMediaTime();
                [item pop_addAnimation:alphaAniam forKey:@"endAlphaBasic"];
            }
        };
       
        POPBasicAnimation *rotationAnima = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
        rotationAnima.toValue = @(M_PI * 2);
        rotationAnima.duration = .25;
        rotationAnima.beginTime = CACurrentMediaTime();
        [item.layer pop_addAnimation:rotationAnima forKey:@"endRotationBasic"];
    }
}

- (void)setPathItems:(NSArray *)pathItems {
    
    if (_pathItems != pathItems) {
        
        _pathItems = pathItems;
        for (int index = 0; index < _pathItems.count; index ++) {
            
            PathButton *item = _pathItems[index];
            item.delegate = self;
            item.frame = CGRectMake(0, 0, iconWidth, iconWidth);
            item.center = _centerItem.center;
            item.alpha = 0;
            [self insertSubview:item belowSubview:_centerItem];
        }
    }
}

- (void)pathButtonDidClicked:(PathButton *)pathButton {
    
    self.backgroundColor = [UIColor clearColor];
    CGRect btnFrame = pathButton.imageView.frame;
    for (PathButton *pathItem in _pathItems) {
        if (pathButton == pathItem) {
            
            POPBasicAnimation *largeAnima = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerSize];
            largeAnima.toValue = [NSValue valueWithCGSize:CGSizeMake(btnFrame.size.width + 70, btnFrame.size.height + 70)];
            largeAnima.duration = .3;
            largeAnima.beginTime = CACurrentMediaTime();
            [pathButton.layer pop_addAnimation:largeAnima forKey:@"PathBtnSizeLarge"];
            
            POPBasicAnimation *alphaAnima = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
            alphaAnima.fromValue = @1;
            alphaAnima.toValue = @0;
            alphaAnima.duration = .3;
            alphaAnima.beginTime = CACurrentMediaTime();
            [pathButton.layer pop_addAnimation:alphaAnima forKey:@"PathBtnOpacityHide"];
            [alphaAnima setCompletionBlock:^(POPAnimation *animation, BOOL finish) {
                
                if (finish) {
                    CGRect pathBtnFrame = pathButton.frame;
                    pathBtnFrame.size = CGSizeMake(0, 0);
                    pathButton.frame = pathBtnFrame;
                    
                    pathButton.alpha = 0;
                }
            }];
        } else {
            
            POPBasicAnimation *smallAnima = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerSize];
            smallAnima.toValue = [NSValue valueWithCGSize:CGSizeMake(0, 0)];
            smallAnima.duration = .3;
            smallAnima.beginTime = CACurrentMediaTime();
            [pathItem.layer pop_addAnimation:smallAnima forKey:@"PathBtnSizeSmall"];
            
            POPBasicAnimation *alphaAnima = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
            alphaAnima.fromValue = @1;
            alphaAnima.toValue = @0;
            alphaAnima.duration = .3;
            alphaAnima.beginTime = CACurrentMediaTime();
            [pathItem.layer pop_addAnimation:alphaAnima forKey:@"PathBtnOpacityShow"];
        }
    }
    
    POPBasicAnimation *basicAnima = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    basicAnima.toValue = @(0);
    basicAnima.duration = .25;
    basicAnima.beginTime = CACurrentMediaTime();
    [_centerItem.layer pop_addAnimation:basicAnima forKey:@"btnRotationReset"];
    _isClick = NO;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self pathButtonDidClicked:nil];
}


@end
