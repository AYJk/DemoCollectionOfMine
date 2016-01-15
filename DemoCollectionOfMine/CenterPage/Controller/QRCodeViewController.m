//
//  QRCodeViewController.m
//  DemoCollectionOfMine
//
//  Created by Andy on 16/1/7.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "QRCodeViewController.h"
#import "ScanViewController.h"
@interface QRCodeViewController ()

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)scanAction:(id)sender {
    ScanViewController *scanVC = [[ScanViewController alloc] init];
    [self.navigationController pushViewController:scanVC animated:YES];
}
- (IBAction)createAction:(id)sender {
}
- (IBAction)loadAction:(id)sender {
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
