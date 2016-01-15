//
//  CenterViewController.m
//  DemoCollectionOfMine
//
//  Created by Andy on 15/12/29.
//  Copyright © 2015年 Andy. All rights reserved.
//

#import "CenterViewController.h"

@interface CenterViewController ()

@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *revealViewController = self.revealViewController;
    [self.view addGestureRecognizer:revealViewController.panGestureRecognizer];
}

- (void)setViewControllerTitle:(NSString *)viewControllerTitle {
    
    if (_viewControllerTitle != viewControllerTitle) {
        _viewControllerTitle = viewControllerTitle;
        self.title = _viewControllerTitle;
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
