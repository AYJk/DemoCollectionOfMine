//
//  CATransactionViewController.m
//  DemoCollectionOfMine
//
//  Created by Andy on 15/12/29.
//  Copyright © 2015年 Andy. All rights reserved.
//

#import "CATransactionViewController.h"

@interface CATransactionViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *caImageView;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSArray *transitions;
@property (nonatomic, copy) NSString *currentAnima;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@end


@implementation CATransactionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"CATransaction";
//    _caImageView.userInteractionEnabled = YES;
    _images = [NSMutableArray array];
    for (int index = 1; index < 10; index ++) {
        [_images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",index]]];
    }
    _currentAnima = @"suckEffect";
    _transitions = @[@"cube",@"suckEffect",@"oglFlip",@"rippleEffect",@"pageCurl",@"pageUnCurl",@"cameraIrisHollowOpen",@"cameraIrisHollowClose",kCATransitionReveal,kCATransitionPush,kCATransitionMoveIn,kCATransitionFade];
}
/**
 *  kCATransitionReveal
 @"cube" //立方体
 @"suckEffect" //吸走的效果
 @"oglFlip"//前后翻转效果
 @"rippleEffect" //水波纹
 @"pageCurl" //翻页起来
 @"pageUnCurl"//翻页下来
 @"cameraIrisHollowOpen" //镜头开
 @"cameraIrisHollowClose" //镜头关
*/
- (IBAction)lastAction:(UIButton *)sender {
    CATransition *transition = [[CATransition alloc] init];
    transition.type = _currentAnima;
    transition.duration = 1;
    _currentIndex --;
    if (_currentIndex <= 0) {
        _currentIndex = 8;
    }
    transition.subtype = @"fromLeft";
    _caImageView.image = _images[_currentIndex];
    [_caImageView.layer addAnimation:transition forKey:@"animation"];
}

- (IBAction)nextAction:(UIButton *)sender {
    CATransition *transition = [[CATransition alloc] init];
    transition.type = _currentAnima;
    transition.duration = 1;
    _currentIndex ++;
    if (_currentIndex >= 9) {
        _currentIndex = 1;
    }
    transition.subtype = @"fromRight";
    _caImageView.image = _images[_currentIndex];
    [_caImageView.layer addAnimation:transition forKey:@"animation"];
}

- (IBAction)changeAction:(UIButton *)sender {
    
    _currentAnima = _transitions[arc4random() % _transitions.count];
    [_changeBtn setTitle:_currentAnima forState:UIControlStateNormal];
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
