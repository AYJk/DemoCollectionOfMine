//
//  POPHomeViewController.m
//  DemoCollectionOfMine
//
//  Created by Andy on 15/12/29.
//  Copyright © 2015年 Andy. All rights reserved.
//

#import "POPHomeViewController.h"
#import "POPViewController.h"
#import "POPPanUpViewController.h"
#import "PathMenuViewController.h"
@interface POPHomeViewController ()

@end

@implementation POPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)popBasicAction:(UIButton *)sender {
    
    POPViewController *popVC = [[POPViewController alloc] init];
    [self.navigationController pushViewController:popVC animated:YES];
}
- (IBAction)popPanUpAction:(UIButton *)sender {
    POPPanUpViewController *popVC = [[POPPanUpViewController alloc] init];
    [self.navigationController pushViewController:popVC animated:YES];
}

- (IBAction)pathMenuAction:(UIButton *)sender {
    
    PathMenuViewController *pathVC = [[PathMenuViewController alloc] init];
    [self.navigationController pushViewController:pathVC animated:YES];
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
