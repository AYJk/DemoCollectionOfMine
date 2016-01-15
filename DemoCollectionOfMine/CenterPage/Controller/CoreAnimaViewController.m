//
//  CoreAnimaViewController.m
//  DemoCollectionOfMine
//
//  Created by Andy on 16/1/7.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "CoreAnimaViewController.h"
#import "CATransactionViewController.h"
#import "PieChatViewController.h"
#import "WaterWareViewController.h"
#import "HardWareMotionViewController.h"
@interface CoreAnimaViewController ()

@end

@implementation CoreAnimaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)transactionAction:(UIButton *)sender {
    
    CATransactionViewController *caTVC = [[CATransactionViewController alloc] init];
    [self.navigationController pushViewController:caTVC animated:YES];
}

- (IBAction)pieChatAction:(UIButton *)sender {
    
    PieChatViewController *pieChatVC = [[PieChatViewController alloc] init];
    [self.navigationController pushViewController:pieChatVC animated:YES];
}

- (IBAction)waterWareAction:(UIButton *)sender {
    
    WaterWareViewController *waterWareVC = [[WaterWareViewController alloc] init];
    [self.navigationController pushViewController:waterWareVC animated:YES];
}
- (IBAction)hardWareMotionAction:(UIButton *)sender {
    
    HardWareMotionViewController *hardWareMotionVC = [[HardWareMotionViewController alloc] init];
    [self.navigationController pushViewController:hardWareMotionVC animated:YES];
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
