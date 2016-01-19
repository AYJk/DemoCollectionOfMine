//
//  WaterWareViewController.m
//  DemoCollectionOfMine
//
//  Created by Andy on 16/1/13.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "WaterWareViewController.h"
#import "WaterWareView.h"

@interface WaterWareViewController ()

@property (strong, nonatomic) WaterWareView *waterView;

@end

@implementation WaterWareViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Water Ware";
    _waterView = [[WaterWareView alloc] initWithFrame:CGRectMake(0, 0, 200,200)];
    _waterView.center = CGPointMake([UIScreen mainScreen].bounds.size.width * .5, [UIScreen mainScreen].bounds.size.height * .5);
    _waterView.percent = .25;
    [self.view addSubview:_waterView];
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
