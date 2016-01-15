//
//  HardWareMotionViewController.m
//  DemoCollectionOfMine
//
//  Created by Andy on 16/1/14.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "HardWareMotionViewController.h"
#import <CoreMotion/CoreMotion.h>
@interface HardWareMotionViewController ()

@property (weak, nonatomic) IBOutlet UILabel *yawValue;
@property (weak, nonatomic) IBOutlet UILabel *pitchValue;
@property (weak, nonatomic) IBOutlet UILabel *rollValue;

@property (weak, nonatomic) IBOutlet UILabel *userAccelerationX;
@property (weak, nonatomic) IBOutlet UILabel *userAccelerationY;
@property (weak, nonatomic) IBOutlet UILabel *userAccelerationZ;

@property (weak, nonatomic) IBOutlet UILabel *gravityX;
@property (weak, nonatomic) IBOutlet UILabel *gravityY;
@property (weak, nonatomic) IBOutlet UILabel *gravityZ;

@property (weak, nonatomic) IBOutlet UILabel *rotationX;
@property (weak, nonatomic) IBOutlet UILabel *rotationY;
@property (weak, nonatomic) IBOutlet UILabel *rotationZ;

@property (weak, nonatomic) IBOutlet UISwitch *openSwitch;

@property (strong, nonatomic) CMMotionManager *motionManger;

@end

@implementation HardWareMotionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.motionManger = [[CMMotionManager alloc] init];
    self.motionManger.deviceMotionUpdateInterval = .1f;
    self.title = @"Motion Tracking";
}

- (IBAction)switchAction:(UISwitch *)sender {
    
    if (sender.on) {
        
        [self displayHardWareMotion];
    } else {
        
        [self stopDisplayHardWaremotion];
    }
}

- (void)stopDisplayHardWaremotion {
    
    [self.motionManger stopDeviceMotionUpdates];
}

- (void)displayHardWareMotion {
    
    [self.motionManger startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {

        self.yawValue.text = [NSString stringWithFormat:@"%.2f",motion.attitude.yaw];
        self.pitchValue.text = [NSString stringWithFormat:@"%.2f",motion.attitude.pitch];
        self.rollValue.text = [NSString stringWithFormat:@"%.2f",motion.attitude.roll];

//        if (fabs(motion.userAcceleration.x)>1.3f) {
            self.userAccelerationX.text = [NSString stringWithFormat:@"%.2f",motion.userAcceleration.x];
//        }
//        if (fabs(motion.userAcceleration.y) > 1.3f) {
            self.userAccelerationY.text = [NSString stringWithFormat:@"%.2f",motion.userAcceleration.y];
//        }
//        if (fabs(motion.userAcceleration.z) > 1.3f) {
            self.userAccelerationZ.text = [NSString stringWithFormat:@"%.2f",motion.userAcceleration.z];
//        }
        
        self.gravityX.text = [NSString stringWithFormat:@"%.2f",motion.gravity.x];
        self.gravityY.text = [NSString stringWithFormat:@"%.2f",motion.gravity.y];
        self.gravityZ.text = [NSString stringWithFormat:@"%.2f",motion.gravity.z];
        
        self.rotationX.text = [NSString stringWithFormat:@"%.2f",motion.rotationRate.x];
        self.rotationY.text = [NSString stringWithFormat:@"%.2f",motion.rotationRate.y];
        self.rotationZ.text = [NSString stringWithFormat:@"%.2f",motion.rotationRate.z];
        
    }];
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
