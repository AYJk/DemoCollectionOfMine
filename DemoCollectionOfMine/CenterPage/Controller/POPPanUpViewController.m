//
//  POPPanUpViewController.m
//  DemoCollectionOfMine
//
//  Created by Andy on 15/12/29.
//  Copyright © 2015年 Andy. All rights reserved.
//

#import "POPPanUpViewController.h"

@interface POPPanUpViewController () <POPAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *circleView;

@end

static CGPoint  bottomCenter;

@implementation POPPanUpViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"各类菜单";
    [self configBottomViews];
    [self configCircleViews];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    bottomCenter = _bottomView.center;
}

- (void)configCircleViews {

    _circleView.layer.cornerRadius = _circleView.bounds.size.width * .5;
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [_circleView addGestureRecognizer:panGes];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCircleAction:)];
    [_circleView addGestureRecognizer:tap];
}

- (void)configBottomViews {
    
//    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:_bottomView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(15, 15)];
//    CAShapeLayer *maskShaperLayer = [[CAShapeLayer alloc] init];
//    maskShaperLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, 100);
//    maskShaperLayer.path = bezierPath.CGPath;
//    _bottomView.layer.mask = maskShaperLayer;
//    _bottomView.layer.masksToBounds = YES;
    _bottomView.layer.cornerRadius = 15;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_bottomView addGestureRecognizer:tap];
}

- (void)panAction:(UIPanGestureRecognizer *)pan {
    
    CGPoint translation = [pan translationInView:self.view];
    pan.view.center = CGPointMake(translation.x + pan.view.center.x, translation.y + pan.view.center.y);
    [pan setTranslation:CGPointMake(0, 0) inView:self.view];
    if (pan.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [pan velocityInView:self.view];
        POPDecayAnimation *popDecayAnima = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
        popDecayAnima.velocity = [NSValue valueWithCGPoint:velocity];
        popDecayAnima.delegate = self;
        [pan.view.layer pop_addAnimation:popDecayAnima forKey:@"DecayAnima"];
    }
}

- (void)tapCircleAction:(UITapGestureRecognizer *)tap {
    
    [_circleView.layer pop_removeAllAnimations];
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    static BOOL isClick;
    isClick = !isClick;
    if (isClick) {
        
        [self showBottomView];
    } else {
        
        [self hidenBottomView];
    }
}

- (void)showBottomView {
    
    POPSpringAnimation *springAnima = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    springAnima.toValue = [NSValue valueWithCGPoint:CGPointMake(bottomCenter.x, bottomCenter.y - 200)];
    springAnima.springSpeed = 16;
    springAnima.springBounciness = 12;
    springAnima.beginTime = CACurrentMediaTime();
    [_bottomView.layer pop_addAnimation:springAnima forKey:@"showSpringAnima"];
    self.view.backgroundColor = [UIColor colorWithWhite:.9 alpha:.7];
}

- (void)hidenBottomView {
    
    POPSpringAnimation *springAnima = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    springAnima.toValue = [NSValue valueWithCGPoint:bottomCenter];
    springAnima.springSpeed = 16;
    springAnima.springBounciness = 12;
    springAnima.beginTime = CACurrentMediaTime();
    [_bottomView.layer pop_addAnimation:springAnima forKey:@"HidenSpringAnima"];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - POPAnimationDelegate
- (void)pop_animationDidApply:(POPDecayAnimation *)anim {
    
    BOOL isContainsRect = CGRectContainsRect(self.view.frame, _circleView.frame);
    if (!isContainsRect) {
        
        CGPoint lastVelocity = [anim.velocity CGPointValue];
        CGPoint nextVelocity = CGPointMake(lastVelocity.x, -lastVelocity.y);
        POPSpringAnimation *springAnima = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
        springAnima.toValue = [NSValue valueWithCGPoint:self.view.center];
        springAnima.velocity = [NSValue valueWithCGPoint:nextVelocity];
        [_circleView.layer pop_addAnimation:springAnima forKey:@"DecayAnima"];
    }
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
