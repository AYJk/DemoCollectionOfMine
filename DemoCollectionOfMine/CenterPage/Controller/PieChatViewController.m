//
//  PieChatViewController.m
//  DemoCollectionOfMine
//
//  Created by Andy on 16/1/7.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "PieChatViewController.h"
#import "PieChartCircularArc.h"
#import "HalfPieChatProgressView.h"
@interface PieChatViewController ()

@end

@implementation PieChatViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"PieChat";
//    PieChartCircularArc *pieChat = [[PieChartCircularArc alloc] pieChartCenter:CGPointMake([UIScreen mainScreen].bounds.size.width * .5, [UIScreen mainScreen].bounds.size.height * .5) radius:120 colors:@[[UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor grayColor]] datas:@[@.2,@.4,@.1,@.3] offset:20];
//    [self.view addSubview:pieChat];
    HalfPieChatProgressView *halfPie = [[HalfPieChatProgressView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    halfPie.lineWidth = 7;
    halfPie.finishCorlor = [UIColor colorWithRed:241 /255.0 green:47 / 255.0 blue:9 /255.0 alpha:1];
    halfPie.unfinishCorlor = [UIColor colorWithRed:255 / 255.0 green:223 / 255.0 blue:216.0/255.0 alpha:1];
    halfPie.backCorlor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    [self.view addSubview:halfPie];
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
