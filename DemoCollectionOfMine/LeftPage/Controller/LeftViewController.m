//
//  LeftViewController.m
//  DemoCollectionOfMine
//
//  Created by Andy on 15/12/29.
//  Copyright © 2015年 Andy. All rights reserved.
//

#import "LeftViewController.h"
#import "SWRevealViewController.h"
#import "MasonryViewController.h"
#import "POPHomeViewController.h"
#import "CoreAnimaViewController.h"
#import "QRCodeViewController.h"
#import "MagicalRecordViewController.h"
#import "TouchIDViewController.h"
@interface LeftViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *demosArray;

@end

static NSString *reuseID = @"LeftCell";

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _demosArray = @[@"Home",@"Masonry",@"POP",@"CoreAnimation",@"QRCode",@"MagicalRecord",@"Touch ID"];
    [self configTableView];
}

- (void)configTableView {

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, 230, kScreenHeight - 20) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseID];
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDelegate / UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _demosArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    cell.textLabel.text = _demosArray[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SWRevealViewController *revealViewController = self.revealViewController;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        CenterViewController *centerVC = [[CenterViewController alloc] init];
        UINavigationController *centerNC = [[UINavigationController alloc] initWithRootViewController:centerVC];
        centerVC.viewControllerTitle = cell.textLabel.text;
        [revealViewController pushFrontViewController:centerNC animated:YES];
        
    }else if (indexPath.row == 1) {
        MasonryViewController *masonryVC = [[MasonryViewController alloc] init];
        UINavigationController *masonryNC = [[UINavigationController alloc] initWithRootViewController:masonryVC];
        masonryVC.viewControllerTitle = cell.textLabel.text;
        [revealViewController pushFrontViewController:masonryNC animated:YES];
    } else if (indexPath.row == 2) {
        POPHomeViewController *popHomeVC = [[POPHomeViewController alloc] init];
        UINavigationController *popNC = [[UINavigationController alloc] initWithRootViewController:popHomeVC];
        popHomeVC.viewControllerTitle = cell.textLabel.text;
        [revealViewController pushFrontViewController:popNC animated:YES];
    } else if (indexPath.row == 3) {
        CoreAnimaViewController *caVC = [[CoreAnimaViewController alloc] init];
        UINavigationController *caNC = [[UINavigationController alloc] initWithRootViewController:caVC];
        caVC.viewControllerTitle = cell.textLabel.text;
        [revealViewController pushFrontViewController:caNC animated:YES];
    } else if (indexPath.row == 4) {
        QRCodeViewController *qrCodeVC = [[QRCodeViewController alloc] init];
        UINavigationController *qrCodeNC = [[UINavigationController alloc] initWithRootViewController:qrCodeVC];
        qrCodeVC.viewControllerTitle = cell.textLabel.text;
        [revealViewController pushFrontViewController:qrCodeNC animated:YES];
    } else if (indexPath.row == 5) {
        MagicalRecordViewController *magicalVC = [[MagicalRecordViewController alloc] init];
        UINavigationController *magicalNC = [[UINavigationController alloc] initWithRootViewController:magicalVC];
        magicalVC.viewControllerTitle = cell.textLabel.text;
        [revealViewController pushFrontViewController:magicalNC animated:YES];
    } else if (indexPath.row == 6) {
        TouchIDViewController *touchIDVC = [[TouchIDViewController alloc] init];
        UINavigationController *touchIDNC = [[UINavigationController alloc] initWithRootViewController:touchIDVC];
        [revealViewController pushFrontViewController:touchIDNC animated:YES];
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
