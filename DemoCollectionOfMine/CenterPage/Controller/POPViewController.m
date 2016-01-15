//
//  POPViewController.m
//  DemoCollectionOfMine
//
//  Created by Andy on 15/12/29.
//  Copyright © 2015年 Andy. All rights reserved.
//

#import "POPViewController.h"
#import <POP/POP.h>

@interface POPViewController ()

@property (nonatomic, strong) UIView *redView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation POPViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"POP基础";
    _redView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 100,100)];
    _redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_redView];
}

- (IBAction)buttonAction:(id)sender {
    
    POPBasicAnimation *basicAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    basicAnimation.toValue = @(_redView.center.x + 50);
    basicAnimation.beginTime = CACurrentMediaTime();
    [_redView pop_addAnimation:basicAnimation forKey:@"position"];
}
- (IBAction)springAction:(id)sender {
    
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    spring.toValue = @(_redView.center.x + 100);
    spring.springBounciness = 20;
    spring.beginTime = CACurrentMediaTime();
    [_redView pop_addAnimation:spring forKey:@"position"];
}

- (IBAction)decayAction:(id)sender {
    
    POPDecayAnimation *decay = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    decay.velocity = @(300);
    decay.beginTime = CACurrentMediaTime();
    [_redView pop_addAnimation:decay forKey:@"position"];
}

- (IBAction)propertyAction:(id)sender {
    
    static BOOL isClick;
    isClick = !isClick;
    UIButton *propertyBtn = (UIButton *)sender;
    if (isClick) {
        
        [propertyBtn setTitle:@"timeStop" forState:UIControlStateNormal];
        POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"countdown" initializer:^(POPMutableAnimatableProperty *prop) {
            
            prop.writeBlock = ^ (id obj , const CGFloat values[]) {
                
                UILabel *label = (UILabel *)obj;
                label.text = [NSString stringWithFormat:@"%02d:%02d:%02d",(int)values[0]/60,(int)values[0]%60,(int)(values[0]*100)%100];
            };
        }];
        POPBasicAnimation *basic = [POPBasicAnimation linearAnimation];
        basic.property = prop;
        basic.fromValue = @(0);
        basic.toValue = @(3 * 60);
        basic.duration = 3 * 60;
        basic.beginTime = CACurrentMediaTime();
        [_countLabel pop_addAnimation:basic forKey:@"countdown"];
    } else {
        
        [propertyBtn setTitle:@"timeStart" forState:UIControlStateNormal];
        [_countLabel pop_removeAllAnimations];
    }
}

- (IBAction)resetAction:(id)sender {
    
    _redView.frame = CGRectMake(10, 100, 100, 100);
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
